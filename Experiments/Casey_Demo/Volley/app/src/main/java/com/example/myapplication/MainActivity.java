package com.example.myapplication;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.android.volley.toolbox.StringRequest;

public class MainActivity extends AppCompatActivity {
    Button btnStringRequest, btnJsonRequest, btnImageRequest;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        btnStringRequest = (Button) findViewById(R.id.btnStringRequest);
        btnJsonRequest = (Button) findViewById(R.id.btnJsonRequest);
        btnImageRequest = (Button) findViewById(R.id.btnImageRequest);

        btnStringRequest.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent i = new Intent(MainActivity.this, StringRequest.class);
                startActivity(i);
            }
        });
        btnJsonRequest.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent i = new Intent(MainActivity.this, JsonRequest.class);
                startActivity(i);
            }
        });
        btnImageRequest.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent i = new Intent(MainActivity.this, ImageRequest.class);
                startActivity(i);
            }
        });
    }
}