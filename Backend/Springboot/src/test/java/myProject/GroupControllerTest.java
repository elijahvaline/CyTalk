package myProject;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Scanner;

import org.json.JSONObject;
import org.junit.ClassRule;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.rules.SpringClassRule;
import org.springframework.test.context.junit4.rules.SpringMethodRule;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import myProject.user.User;
import myProject.user.UserDB;
import myProject.webSocket.Group;
import myProject.webSocket.GroupController;
import myProject.webSocket.GroupRepository;
import myProject.webSocket.MessageRepository;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.when;
import static org.mockito.Mockito.*;

@RunWith(Parameterized.class)
@WebMvcTest(GroupController.class)
public class GroupControllerTest {

	@Autowired
	private MockMvc controller;
	
	@MockBean
	private GroupRepository groupRepo;
	
	@MockBean
	private UserDB userRepo;
	
	@MockBean
	private MessageRepository msgRepo;
	
	//Allow mockito test with parameters
	@ClassRule
    public static final SpringClassRule scr = new SpringClassRule();
 
    @Rule
    public final SpringMethodRule smr = new SpringMethodRule();
    
    //Each of the parameters
    @Parameter(value = 0)
    public String body;
    
    @Parameter(value = 1)
    public int uid1;
 
    @Parameter(value = 2)
    public String path;
    
    @Parameter(value = 3)
    public int uid2;
    
    @Parameter(value = 4)
    public String group;
    
    @Parameter(value = 5)
    public int gid;
    
    @Parameter(value = 6)
    public boolean status;
    
    @Parameters
	public static Collection<Object[]> getParameters() {
		Collection<Object[]> retList = new ArrayList<Object[]>();
		try {
			//Fill containing test cases
			Scanner in = new Scanner(new File("groupTests.txt"));

			while (in.hasNextLine()) {
				String l = in.nextLine();
				
				String dataArray[] = l.split(",");
				Object[] d = new Object[7];
				d[0] = dataArray[0];
				d[1] = Integer.parseInt(dataArray[1]);
				d[2] = dataArray[2]; 
				d[3] = Integer.parseInt(dataArray[3]);
				d[4] = dataArray[4];
				d[5] = Integer.parseInt(dataArray[5]);
				d[6] = Boolean.parseBoolean(dataArray[6]);

				// add the test data into the arraylist
				retList.add(d);
				
			} // end of while
			in.close();

		} catch (FileNotFoundException e) {
			e.printStackTrace();

		}
		
		// return all the test-cases
		return retList;
	}

    //Create two different groups
	@Test
	public void createGroup() throws Exception {
		//User 1
		User u1 = new User();
		u1.setId(uid1);
    	u1.setUName(body);
    	when(userRepo.findOneByUsername(body)).thenReturn(u1);
		
    	//User 2
		User u2 = new User();
    	u2.setId(uid2);
    	u2.setUName(path);
		when(userRepo.findOneByUsername(path)).thenReturn(u2);
		
		//Create 1st group
		Group g = new Group();
		g.setId(gid);
		g.setGroupName(group);
		when(groupRepo.save(any(Group.class))).thenReturn(g);
		
		//Request to create group
		String json = "{ \"groupName\" : \""+ group + "\"}";
    	MvcResult result = controller.perform(MockMvcRequestBuilders.post("/user/" + path + "/group").contentType(MediaType.APPLICATION_JSON).content(json))
				.andReturn();
    	if (status) {
    		assertEquals(200, result.getResponse().getStatus());
    		String r = result.getResponse().getContentAsString();
    		JSONObject j = new JSONObject(r);
    		assertEquals(g.getGroupName(), j.get("groupName"));
    		
    		assertEquals(uid2, j.getJSONArray("users").getJSONObject(0).get("id"));
    		assertEquals(path, j.getJSONArray("users").getJSONObject(0).get("uname"));
    		
    		//Create 2nd group
    		g = new Group();
    		g.setId(gid + 1);
    		g.setGroupName(group);
    		when(groupRepo.save(any(Group.class))).thenReturn(g);
    		
    		//Request to create group
    		MvcResult result3 = controller.perform(MockMvcRequestBuilders.post("/user/" + body + "/group").contentType(MediaType.APPLICATION_JSON).content(json))
    				.andReturn();
    		assertEquals(200, result3.getResponse().getStatus());
    		String r3 = result3.getResponse().getContentAsString();
    		JSONObject j3 = new JSONObject(r3);
    		assertEquals(g.getGroupName(), j3.get("groupName"));
    		
    		assertEquals(uid1, j3.getJSONArray("users").getJSONObject(0).get("id"));
    		assertEquals(body, j3.getJSONArray("users").getJSONObject(0).get("uname"));
    	} else assertEquals(404, result.getResponse().getStatus());
	}
	
	//Add multiple users to a group
	@Test
	public void addToGroup() throws Exception {
		//User 1
		User u1 = new User();
		u1.setId(uid1);
    	u1.setUName(body);
    	when(userRepo.findOneByUsername(body)).thenReturn(u1);
    	
    	//User 2
		User u2 = new User();
    	u2.setId(uid2);
    	u2.setUName(path);
		when(userRepo.findOneByUsername(path)).thenReturn(u2);
		
		Group g = new Group();
		g.setId(gid);
		g.setGroupName(group);
		when(groupRepo.save(any(Group.class))).thenReturn(g);
		when(groupRepo.findOne((long) gid)).thenReturn(g);
		
		//Add 1st user
    	MvcResult result = controller.perform(MockMvcRequestBuilders.put("/user/" + path + "/" + gid).contentType(MediaType.APPLICATION_JSON))
				.andReturn();
    	if (status) {
    		assertEquals(200, result.getResponse().getStatus());
    		String r = result.getResponse().getContentAsString();
    		JSONObject j = new JSONObject(r);
    		assertEquals(g.getGroupName(), j.get("groupName"));
    		
    		assertEquals(uid2, j.getJSONArray("users").getJSONObject(0).get("id"));
    		assertEquals(path, j.getJSONArray("users").getJSONObject(0).get("uname"));
    		
    		g.addUser(u2);
    		
    		//Add 2nd user to group
    		MvcResult result2 = controller.perform(MockMvcRequestBuilders.put("/user/" + body + "/" + gid).contentType(MediaType.APPLICATION_JSON))
    				.andReturn();
    		assertEquals(200, result2.getResponse().getStatus());
    		String r2 = result2.getResponse().getContentAsString();
    		JSONObject j2 = new JSONObject(r2);
    		assertEquals(g.getGroupName(), j2.get("groupName"));
    		
    		assertTrue(uid1 == Integer.parseInt(j2.getJSONArray("users").getJSONObject(1).get("id").toString()) ||
    				uid1 == Integer.parseInt( j2.getJSONArray("users").getJSONObject(0).get("id").toString()));
    		assertTrue(body.equals(j2.getJSONArray("users").getJSONObject(1).get("uname").toString()) ||
    				body.equals(j2.getJSONArray("users").getJSONObject(0).get("uname").toString()));
    	} else assertEquals(404, result.getResponse().getStatus());
	}
}
