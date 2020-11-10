package myProject.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;

import myProject.post.Post;
@Api(value = "CommentController", description = "REST API from Akash Deshpande")
@RestController
public class CommentController {

	@Autowired
	CommentDB db;

	@ApiOperation(value = "Get comment info by comment id")
	@GetMapping("/Comment/{id}")
	Comment getComment(@PathVariable Integer id) {
		return db.findOne(id);
	}

	@ApiOperation(value = "Return all comments")
	@GetMapping("/Comments")
	List<Comment> hello() {
		return db.findAll();
	}

	@ApiOperation(value = "Get a list of commments from a post Id")
	@GetMapping("/Comments/{pId}")
	List<Comment> getComment(@PathVariable int pId) {
		return db.getCommentBypId(pId);
	}
	
	@ApiOperation(value = "Create a comment")
	@PostMapping("/Comment")
	Comment createComment(@RequestBody Comment c) {
		db.save(c);
		return c;
	}

	@ApiOperation(value = "Edit a comment")
	@PutMapping("/Comment/update/{id}")
	Comment updateComment(@RequestBody Comment c, @PathVariable Integer id) {
		Comment old_c = db.findOne(id);
		old_c.setContent(c.getContent());
		db.save(old_c);
		return old_c;
	}
}
