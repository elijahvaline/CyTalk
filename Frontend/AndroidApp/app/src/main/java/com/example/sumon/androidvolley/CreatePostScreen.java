package com.example.sumon.androidvolley;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageButton;

public class CreatePostScreen extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_create_post_screen);
        ImageButton addBtn = (ImageButton) findViewById(R.id.createPost);
        addBtn.setOnClickListener(new View.OnClickListener(){

            @Override
            public void onClick(View v) {
                startActivity(new Intent(CreatePostScreen.this,JsonRequestActivity.class));
            }
        });
    }


}


