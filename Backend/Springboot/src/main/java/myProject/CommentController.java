package myProject;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class CommentController {

	@Autowired
	CommentDB db;

	@GetMapping("/Comment/{id}")
	Comment getComment(@PathVariable Integer id) {
		return db.findOne(id);
	}

	@GetMapping("/Comments")
	List<Comment> hello() {
		return db.findAll();
	}

	@PostMapping("/Comment/{id}")
	Comment createComment(@RequestBody Comment c) {
		db.save(c);
		return c;
	}

	@PutMapping("/Comment/{id}")
	Comment updateComment(@RequestBody Comment c, @PathVariable Integer id) {
		Comment old_c = db.findOne(id);
		old_c.setContent(c.getContent());
		db.save(old_c);
		return old_c;
	}
}
