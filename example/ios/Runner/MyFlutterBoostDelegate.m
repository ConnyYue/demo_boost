//
//  MyFlutterBoostDelegate.m
//  Runner
//
//  Created by yuechen on 2021/11/15.
//  Copyright © 2021 TAL-Engineering. All rights reserved.
//

#import "MyFlutterBoostDelegate.h"

@implementation MyFlutterBoostDelegate

- (void)pushNativeRoute:(NSString *)pageName arguments:(NSDictionary *)arguments
{
    BOOL animated = [arguments[@"animated"] boolValue];
    BOOL present= [arguments[@"present"] boolValue];
    
    UIViewController *nvc = [[UIViewController alloc] init];
    if (present) {
        [self.navigationController presentViewController:nvc animated:animated completion:^{ }];
    } else {
        [self.navigationController pushViewController:nvc animated:animated];
    }
}

- (void)pushFlutterRoute:(FlutterBoostRouteOptions *)options
{
    FBFlutterViewContainer *vc = [FBFlutterViewContainer init];
    [vc setName:options.pageName uniqueId:options.uniqueId params:options.arguments opaque:options.opaque];
    
    //是否伴随动画
    BOOL animated = [options.arguments[@"animated"] boolValue];
    //是否是present的方式打开,如果要push的页面是透明的，那么也要以present形式打开
    BOOL present = [options.arguments[@"present"] boolValue] || !options.opaque;

    if (present) {
        [self.navigationController presentViewController:(UIViewController *)vc animated:animated completion:^{
            options.completion(YES);
        }];
    } else {
        [self.navigationController pushViewController:(UIViewController *)vc animated:animated];
        options.completion(YES);
    }
}

- (void)popRoute:(FlutterBoostRouteOptions *)options
{
    //拿到当前vc
    FBFlutterViewContainer *vc = (id)self.navigationController.presentedViewController;
    
    //是否伴随动画,默认是true
    BOOL animated = true;
    NSNumber * animatedValue = options.arguments[@"animated"];
    if(animatedValue){
        animated = [animatedValue boolValue];
    }

    //present的情况，走dismiss逻辑
    if([vc isKindOfClass:FBFlutterViewContainer.class] && [vc.uniqueIDString isEqual: options.uniqueId]){
        
        //这里分为两种情况，由于UIModalPresentationOverFullScreen下，生命周期显示会有问题
        //所以需要手动调用的场景，从而使下面底部的vc调用viewAppear相关逻辑
        UIViewController *curVC = (UIViewController *)self.navigationController.presentedViewController;
        if(curVC.modalPresentationStyle == UIModalPresentationOverFullScreen){
            
            //这里手动beginAppearanceTransition触发页面生命周期
            [self.navigationController.topViewController beginAppearanceTransition:YES animated:NO];
            
            [curVC dismissViewControllerAnimated:YES completion:^{
                [self.navigationController.topViewController endAppearanceTransition];
            }];
        }else{
            //正常场景，直接dismiss
            [curVC dismissViewControllerAnimated:YES completion:^{}];
        }
    }else{
        //否则走pop逻辑
        [self.navigationController popViewControllerAnimated:animated];
    }
    
    options.completion(YES);
}

@end
