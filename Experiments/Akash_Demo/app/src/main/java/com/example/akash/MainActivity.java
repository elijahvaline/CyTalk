package com.example.akash;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button addBtn = (Button) findViewById(R.id.addBtn);
        addBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                EditText UserName = (EditText) findViewById(R.id.UserName);
                EditText Username = (EditText) findViewById(R.id.Username);
                TextView resultTextView = (TextView) findViewById(R.id.resultTextView);

                String s = UserName.getText().toString();
                String s2 = Username.getText().toString();
                String result = s+s2;
                resultTextView.setText(result + "");
            }
        });
    }
}