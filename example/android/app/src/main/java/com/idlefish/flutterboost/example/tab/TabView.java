package com.idlefish.flutterboost.example.tab;

import android.content.Context;
import android.util.Log;
import android.util.TypedValue;
import android.view.Gravity;
import android.widget.FrameLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;

public class TabView extends FrameLayout {
    private String title;

    public TabView(@NonNull Context context) {
        super(context);
        title = "这是一个原生视图，hashCode=" + hashCode();
        TextView textView = new TextView(getContext());
        textView.setText(title);
        textView.setGravity(Gravity.CENTER);
        textView.setTextSize(TypedValue.COMPLEX_UNIT_DIP, 18);
        textView.setTextColor(0xffffffff);
        this.addView(textView, -1, -1);
        onCreate();
    }

    public void onCreate() {
        Log.d("cccLog", "TabView.onCreate" + title);
    }

    public void onResume() {
        Log.d("cccLog", "TabView.onResume" + title);
    }

    public void onPause() {
        Log.d("cccLog", "TabView.onPause" + title);
    }

    public void onDestroy() {
        Log.d("cccLog", "TabView.onDestroy" + title);
    }
}