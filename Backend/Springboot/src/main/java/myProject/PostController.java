package myProject;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.*;

@RestController
public class PostController {

	@Autowired
	PostDB db;

	@GetMapping("/post/{id}")
	Post getPost(@PathVariable Integer id) {
		return db.findOne(id);
	}

	@GetMapping("/posts")
	List<Post> hello() {
		return db.findAll();
	}
	
	@GetMapping("/posts/{un}")
	List<Post> getPost(@PathVariable String un) {
		return db.getPostsByuserName(un);
	}
	
	@PostMapping("/post")
	Post createPost(@RequestBody Post p) {
		db.save(p);
		return p;
	}
	@PutMapping("/post/{id}")
	Post updatePost(@RequestBody Post p, @PathVariable Integer id) {
		Post old_p = db.findOne(id);
		old_p.setContent(p.getContent());
		db.save(old_p);
		return old_p;
	}

}
