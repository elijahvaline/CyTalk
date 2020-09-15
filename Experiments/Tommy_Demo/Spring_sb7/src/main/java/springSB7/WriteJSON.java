package springSB7;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter; 
import java.util.LinkedHashMap; 
import java.util.Map; 
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject; 

public class WriteJSON {
	
	 public static void main(String[] args) throws FileNotFoundException, JSONException  
	    { 
	        // creating JSONObject 
	        JSONObject json = new JSONObject(); 

	        // putting data to JSONObject 
	        NumberOfUsers userNum = new NumberOfUsers();
	        
	        json.put("userid", userNum.newUser()); 
	        json.put("username", "cwong"); 
	        json.put("email", "cwong@iastate.edu");
	        json.put("password", "hardpass2");
	        
	        try(FileWriter fw = new FileWriter("JSONExample.json", true);
				    BufferedWriter bw = new BufferedWriter(fw);
				    PrintWriter out = new PrintWriter(bw))
				{
	        	out.write(json.toString());
	        	out.flush();
	        	out.close();
				} catch (IOException e) {
				    //exception handling left as an exercise for the reader
				}
	    } 
}
