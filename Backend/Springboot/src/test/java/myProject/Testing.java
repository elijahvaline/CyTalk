package myProject;

import org.json.JSONException;
import org.json.JSONObject;

public class Testing {
	public static void main(String [] args) throws JSONException {
		String body = "test";
		String s = "{ \"uname\" : \""+ body +"\"}";
		JSONObject j = new JSONObject(s);
		System.out.println(j.get("uname"));
	}
}
