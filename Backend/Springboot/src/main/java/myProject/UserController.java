package myProject;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class UserController {

	@Autowired
	UserDB db;


	@RequestMapping("/users")
	List<User> hello() {
		return db.findAll();
	}

	@PostMapping("/users")
	User createPerson(@RequestBody User p) {
		db.save(p);
		return p;
	}

}
