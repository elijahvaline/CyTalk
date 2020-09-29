package myProject;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class UserController {

	@Autowired
	UserDB db;


	@GetMapping("/user/{id}")
	User getPerson(@PathVariable Integer id) {
		return db.findOne(id);
	}
	
	@GetMapping("/users")
	List<User> hello() {
		return db.findAll();
	}

	@PostMapping("/user")
	User createPerson(@RequestBody User u) {
		db.save(u);
		return u;
	}
	
	@PutMapping("/user/{id}")
	User updateUser(@RequestBody User u, @PathVariable Integer id) {
		User old_u = db.findOne(id);
		old_u.setUser(u.getFName(), u.getLName(), u.getUName(), u.getPassword(), u.getEmail(), u.getType());
		db.save(old_u);
		return old_u;
	}

}
