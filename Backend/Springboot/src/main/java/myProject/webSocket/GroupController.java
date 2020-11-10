package myProject.webSocket;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import myProject.user.User;
import myProject.user.UserDB;

@RestController
public class GroupController {

	@Autowired
	GroupRepository groupRepo;
	@Autowired
	UserDB userRepo;
	
	@PostMapping("/user/{username}/group")
	public Group createGroup(@RequestBody Group g, @PathVariable String username) {
		Group s = groupRepo.save(g);
		s.addUser(userRepo.findOneByUsername(username));
		groupRepo.save(s);
		return s;
	}
	
	@PostMapping("/user/{username}/private")
	public Group createPrivate(@RequestBody User u, @PathVariable String username) {
		Group g = new Group();
		g.setGroupName("DM");
		g.addUser(userRepo.findOneByUsername(username));
		g.addUser(userRepo.findOneByUsername(u.getUName()));
		groupRepo.save(g);
		g.clearSet();
		return g;
	}
	
	@PutMapping("/user/{username}/{group}")
	public Group addToGroup(@PathVariable String username, @PathVariable long group) {
		Group s = groupRepo.findOne(group);
		s.addUser(userRepo.findOneByUsername(username));
		groupRepo.save(s);
		s.clearSet();
		return s;
	}
	
	@DeleteMapping("/user/{username}/group")
	public Group deleteGroup(@RequestBody Group g, @PathVariable String username) {
		groupRepo.delete(g);
		return g;
	}
	
	@GetMapping("/group/{group}")
	public Set<User> getUsers(@PathVariable long group) {
		return groupRepo.findOne(group).getUsers();
	}
	
	@GetMapping("/group")
	public List<Group> getGroups() {
		List<Group> g = groupRepo.findAll();
		for (Group i : g) {
			i.clearSet();
		}
		return g;
	}
}
