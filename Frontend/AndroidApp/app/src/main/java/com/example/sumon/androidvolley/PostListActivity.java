package com.example.sumon.androidvolley;

import android.content.Intent;
import android.graphics.Color;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.VolleyLog;
import com.android.volley.toolbox.JsonArrayRequest;
import com.example.sumon.androidvolley.app.AppController;
import com.example.sumon.androidvolley.utils.Const;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class PostListActivity extends AppCompatActivity {

    private String TAG = PostListActivity.class.getSimpleName();
    private String tag_json_obj = "jobj_req", tag_json_arry = "jarray_req";
    private LinearLayout linearListLayout;
    private JSONArray r;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_post_list);

        Toolbar myToolbar = findViewById(R.id.toolbar);
        setSupportActionBar(myToolbar);

        // Get a support ActionBar corresponding to this toolbar
        ActionBar ab = getSupportActionBar();

        // Enable the Up button
        ab.setDisplayHomeAsUpEnabled(true);

        linearListLayout = findViewById(R.id.linearListLayout);

        makeJsonArryReq();
    }

    private void makeJsonArryReq() {
        JsonArrayRequest req = new JsonArrayRequest(Const.URL_POST_ARRAY,
                new Response.Listener<JSONArray>() {
                    @Override
                    public void onResponse(JSONArray response) {
                        Log.d(TAG, response.toString());
                        r = response;
                        for (int i = 0; i < r.length(); i++) {
                            try {
                                linearListLayout.addView(addPost(r.getJSONObject(i)));
                            } catch (JSONException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                VolleyLog.d(TAG, "Error: " + error.getMessage());
            }
        });

        // Adding request to request queue
        AppController.getInstance().addToRequestQueue(req,
                tag_json_arry);

        // Cancelling request
        // ApplicationController.getInstance().getRequestQueue().cancelAll(tag_json_arry);
    }

    private Button addPost(JSONObject j) {
        Button viewPost = new Button(this);
        String s = "";
        viewPost.setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT));
        try {
            s = j.getString("id");
            viewPost.setText(s);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        viewPost.setBackgroundColor(Color.parseColor("#DDD0D0")); // hex color 0xAARRGGBB
        viewPost.setPadding(20, 20, 20, 20);// in pixels (left, top, right, bottom)

        final String finalS = s;
        viewPost.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                Intent i = new Intent(PostListActivity.this, ViewPostActivity.class);
                i.putExtra("id" , finalS);
                startActivity(i);

            }
        });
        return viewPost;
    }
}