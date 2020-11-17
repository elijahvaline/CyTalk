package myProject.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

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
	Comment getCommentInfo(@PathVariable int id) {
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
	Comment updateComment(@RequestBody String s, @PathVariable Integer id) {
		Comment old_c = db.findOne(id);
		old_c.setContent(s);
		db.save(old_c);
		return old_c;
	}
	
	@ApiOperation(value = "Delete a comment")
	@DeleteMapping("/Commentdelete/{id}") 
	public void deleteComment(@PathVariable int id) {
		db.delete(id);
	}
	
	@ApiOperation(value = "Increase upvotes by 1")
	@PutMapping("/CommentPvote/{id}")
	public void upVote(@PathVariable int id) {
		Comment c = db.findOne(id);
		c.increasePvotes();
		db.save(c);
	}
	
	@ApiOperation(value = "Increase downvotes by 1")
	@PutMapping("/CommentNvote/{id}")
	public void downVote(@PathVariable int id) {
		Comment c = db.findOne(id);
		c.increaseNvotes();
		db.save(c);
	}
	
	@ApiOperation(value = "Return the number of upvotes from a comment id")
	@GetMapping("/CommentGetUp/{id}")
	public int getPvotes(@PathVariable int id) {
		Comment c = db.findOne(id);
		return c.getPosVoteCount();
	}
	
	@ApiOperation(value = "Return the number of downvotes from a comment id")
	@GetMapping("/CommentGetDown/{id}")
	public int getNvotes(@PathVariable int id) {
		Comment c = db.findOne(id);
		return c.getNegVoteCount();
	}
}
