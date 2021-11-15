package com.idlefish.flutterboost.example.tab;

import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;

import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentActivity;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import com.idlefish.flutterboost.FlutterBoost;
import com.idlefish.flutterboost.containers.FlutterBoostFragment;
import com.idlefish.flutterboost.example.R;

import java.util.ArrayList;
import java.util.List;

public class TabMainActivity extends FragmentActivity implements View.OnClickListener {
    private LinearLayout mes;
    private LinearLayout friend;
    private LinearLayout address;

    private ImageView mesImag;
    private ImageView friendImag;
    private ImageView addressImag;

    private MsgFlutterFragment mesFragment;
    private FriendFlutterFragment friendFragment;
    public NativeFragment nativeFragment;

    Fragment currentFragment;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.tab_main_page);

        //页面初始化
        init();
        //页面的点击事件初始化
        initClick();
        //页面的默认选中
        setSelect(0);
    }


    @Override
    public void onBackPressed() {
        if (currentFragment instanceof FlutterBoostFragment) {
            ((FlutterBoostFragment)currentFragment).onBackPressed();
        } else {
            finish();
        }
    }

    //初始化元素
    private void init() {
        // 第一个页面 FlutterFragment
        mes = (LinearLayout) findViewById(R.id.mes);
        mesImag = (ImageView) findViewById(R.id.mes_imag);
        mesFragment = new MsgFlutterFragment
                .CachedEngineFragmentBuilder(MsgFlutterFragment.class)
                .url("tab_message")
                .build();


        // 第二个页面 FlutterFragment
        friend = (LinearLayout) findViewById(R.id.friend);
        friendImag = (ImageView) findViewById(R.id.friend_imag);
        friendFragment = new FriendFlutterFragment
                .CachedEngineFragmentBuilder(FriendFlutterFragment.class)
                .url("tab_friend")
                .build();

        // 第三个页面 原生
        address = (LinearLayout) findViewById(R.id.address);
        addressImag = (ImageView) findViewById(R.id.address_imag);
        nativeFragment = new NativeFragment();
    }

    //初始化监听
    private void initClick() {
        mes.setOnClickListener(this);
        friend.setOnClickListener(this);
        address.setOnClickListener(this);
    }

    private void showFragment(Fragment fragment) {
        FragmentManager fm = getSupportFragmentManager();
        if (currentFragment != fragment) {
            // 传入的fragment 判断currentFragment
            FragmentTransaction transaction = fm.beginTransaction();
            if (currentFragment != null) {
                // 传入的fragment 不是currentFragment 隐藏currentFragment
                transaction.hide(currentFragment);
            }

            // 传入的fragment 更新currentFragment
            currentFragment = fragment;

            // 传入的fragment 校验是否已添加
            if (!fragment.isAdded()) {
                transaction.add(R.id.fragment_stub, fragment).show(fragment).commit();
            } else {
                transaction.show(fragment).commit();
            }
        }
    }

    @Override
    public void onClick(View view) {
        resetImages();
        switch (view.getId()) {
            case R.id.mes:
                setSelect(0);
                break;
            case R.id.friend:
                setSelect(1);
                break;
            case R.id.address:
                setSelect(2);
                break;
        }

    }

    //全部图片设为暗色
    private void resetImages() {
        mesImag.setImageResource(R.drawable.tab1_normal);
        friendImag.setImageResource(R.drawable.tab2_normal);
        addressImag.setImageResource(R.drawable.tab3_normal);
    }

    //点亮选中图片
    private void setSelect(int i) {
        resetImages();
        switch (i) {
            case 0:
                mesImag.setImageResource(R.drawable.tab1_selected);
                showFragment(mesFragment);
                break;
            case 1:
                friendImag.setImageResource(R.drawable.tab2_selected);
                showFragment(friendFragment);
                break;
            case 2:
                addressImag.setImageResource(R.drawable.tab3_selected);
                showFragment(nativeFragment);
                break;
        }
    }
}