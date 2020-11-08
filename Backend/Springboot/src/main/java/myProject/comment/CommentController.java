package myProject.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import myProject.post.Post;

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

	@GetMapping("/Comments/{pId}")
	List<Comment> getComment(@PathVariable int pId) {
		return db.getCommentBypId(pId);
	}
	
	@PostMapping("/Comment")
	Comment createComment(@RequestBody Comment c) {
		db.save(c);
		return c;
	}

	@PutMapping("/Comment/update/{id}")
	Comment updateComment(@RequestBody Comment c, @PathVariable Integer id) {
		Comment old_c = db.findOne(id);
		old_c.setContent(c.getContent());
		db.save(old_c);
		return old_c;
	}
}
