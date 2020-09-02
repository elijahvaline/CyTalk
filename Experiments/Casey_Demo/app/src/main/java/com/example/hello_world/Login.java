package com.example.hello_world;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class Login extends AppCompatActivity implements EXDialog.ExampleDialogListener {
    private TextView textViewUsername, textViewPassword;
    private Button loginButton;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        textViewUsername= (TextView) findViewById(R.id.usernameTextView);
        textViewPassword= (TextView) findViewById(R.id.passwordTextView);
        loginButton = (Button) findViewById(R.id.loginButton);
        loginButton.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {
                openDialog();
            }
        });
    }

    public void openDialog() {
        EXDialog exDialog = new EXDialog();
        exDialog.show(getSupportFragmentManager(), "example dialog");
    }

    @Override
    public void applyTexts(String username, String password) {
        textViewUsername.setText(username);
        textViewPassword.setText(password);
    }
}