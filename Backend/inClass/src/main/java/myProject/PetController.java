package myProject;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class PetController {

	@Autowired
	PetDB db;


	@RequestMapping("/pets")
	List<Pet> hello() {
		return db.findAll();
	}

	@PostMapping("/pet")
	Pet createPerson(@RequestBody Pet p) {
		db.save(p);
		return p;
	}

}
