package myProject.webSocket;

import java.util.List;
import java.util.Set;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import myProject.user.User;
import myProject.user.UserDB;

@Api(value = "GroupController", description = "REST APIs for Group/Message related data by Casey Wong")
@RestController
public class GroupController {

	@Autowired
	GroupRepository groupRepo;
	@Autowired
	UserDB userRepo;
	@Autowired
	MessageRepository msgRepo;
	
	@ApiOperation(value = "Creates a group for a user")
	@PostMapping("/user/{username}/group")
	public Group createGroup(@RequestBody Group g, @PathVariable String username) {
		Group s = groupRepo.save(g);
		s.addUser(userRepo.findOneByUsername(username));
		groupRepo.save(s);
		return s;
	}
	
	@ApiOperation(value = "Creates a DM between two users")
	@PostMapping("/user/{username}/private")
	public Group createPrivate(@RequestBody User u, @PathVariable String username) {
		Group g = new Group();
		g.setGroupName("DM");
		g.addUser(userRepo.findOneByUsername(username));
		g.addUser(userRepo.findOneByUsername(u.getUName()));
		groupRepo.save(g);
		return g;
	}
	
	@ApiOperation(value = "Adds a user to a group")
	@PutMapping("/user/{username}/{group}")
	public Group addToGroup(@PathVariable String username, @PathVariable long group) {
		Group s = groupRepo.findOne(group);
		s.addUser(userRepo.findOneByUsername(username));
		groupRepo.save(s);
		return s;
	}
	
	@ApiOperation(value = "Deletes a group")
	@DeleteMapping("/user/{username}/group")
	public Group deleteGroup(@RequestBody Group g, @PathVariable String username) {
		groupRepo.delete(g);
		return g;
	}
	
	@ApiOperation(value = "Gets set of user in a group")
	@GetMapping("/group/{group}")
	public Set<User> getUsers(@PathVariable long group) {
		return groupRepo.findOne(group).getUsers();
	}
	
	@ApiOperation(value = "Get list of all groups")
	@GetMapping("/group")
	public List<Group> getGroups() {
		List<Group> g = groupRepo.findAll();
		for (Group i : g) {
			i.clearSet();
		}
		return g;
	}
	
	@ApiOperation(value = "Get last message sent in a group")
	@GetMapping(path = "/group/{group}/msg", produces= MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> getLastGroupMsg(@PathVariable long group) throws JSONException {
		Message m = msgRepo.findMessageByGroupId(group);
		JSONObject j = new JSONObject();
		j.put("uname", m.getUserName());
		j.put("content", m.getContent());
		return ResponseEntity.ok().body(j.toString());
		
	}
}
