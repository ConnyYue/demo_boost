//
//  MyFlutterBoostDelegate.h
//  Runner
//
//  Created by yuechen on 2021/11/15.
//  Copyright © 2021 TAL-Engineering. All rights reserved.
//

#import <flutter_boost/FlutterBoost.h>
#import <Foundation/Foundation.h>
#import <flutter_boost/FlutterBoost.h>

@interface MyFlutterBoostDelegate : NSObject<FlutterBoostDelegate>
    
@property (nonatomic,strong) UINavigationController *navigationController;

@end
