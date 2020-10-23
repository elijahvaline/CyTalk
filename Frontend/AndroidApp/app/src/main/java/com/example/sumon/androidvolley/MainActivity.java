package com.example.sumon.androidvolley;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

public class MainActivity extends Activity implements OnClickListener {
    private Button btnJson, btnString, btnViewPost,btnCreatePost;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

//        btnString = (Button) findViewById(R.id.btnStringRequest);
//        btnJson = (Button) findViewById(R.id.btnJsonRequest);
        btnViewPost = (Button) findViewById(R.id.btnViewPost);
        btnCreatePost = (Button) findViewById(R.id.btnCreatePost);

        // button click listeners
//        btnString.setOnClickListener(this);
//        btnJson.setOnClickListener(this);
        btnViewPost.setOnClickListener(this);
        btnCreatePost.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
//            case R.id.btnStringRequest:
//                startActivity(new Intent(MainActivity.this,
//                        StringRequestActivity.class));
//                break;
//            case R.id.btnJsonRequest:
//                startActivity(new Intent(MainActivity.this,
//                        JsonRequestActivity.class));
//                break;
            case R.id.btnViewPost:
                startActivity(new Intent(MainActivity.this,
                        PostListActivity.class));
                break;

            case R.id.btnCreatePost:
                startActivity(new Intent(MainActivity.this,
                        CreatePostScreen.class));
                break;
            default:
                break;
        }
    }

}
