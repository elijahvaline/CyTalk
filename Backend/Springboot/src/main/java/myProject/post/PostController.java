package myProject.post;

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
import myProject.comment.Comment;

@Api(value = "PostController", description = "REST API from Akash Deshpande")
@RestController
public class PostController {

	@Autowired
	PostDB db;

	@ApiOperation(value = "Get post info by post id")
	@GetMapping("/post/{id}")
	Post getPost(@PathVariable int id) {
		return db.findOne(id);
	}

	@ApiOperation(value = "Return all posts")
	@GetMapping("/posts")
	List<Post> hello() {
		return db.findAll();
	}
	
	@ApiOperation(value = "Get a list of post from a username")
	@GetMapping("/posts/{un}")
	List<Post> getPost(@PathVariable String un) {
		return db.getPostsByuserName(un);
	}
	
	@ApiOperation(value = "Create a post")
	@PostMapping("/post")
	Post createPost(@RequestBody Post p) {
		db.save(p);
		return p;
	}
	
	@ApiOperation(value = "Update a post")
	@PutMapping("/post/{id}")
	Post updatePost(@RequestBody String s, @PathVariable Integer id) {
		Post old_p = db.findOne(id);
		old_p.setContent(s);
		db.save(old_p);
		return old_p;
	}
	
	@ApiOperation(value = "Delete a post")
	@DeleteMapping("/postdelete/{id}") 
	public void deletePost(@PathVariable int id) {
		db.delete(id);
	}
	
	@ApiOperation(value = "Increase upvotes by 1")
	@PutMapping("/postPvote/{id}")
	public void upVote(@PathVariable int id) {
		Post p = db.findOne(id);
		p.increasePvotes();
		db.save(p);
	}
	
	@ApiOperation(value = "Increase downvotes by 1")
	@PutMapping("/postNvote/{id}")
	public void downVote(@PathVariable int id) {
		Post p = db.findOne(id);
		p.increaseNvotes();
		db.save(p);
	}
	
	@ApiOperation(value = "Return the number of upvotes from a post id")
	@GetMapping("/postGetUp/{id}")
	public int getPvotes(@PathVariable int id) {
		Post p = db.findOne(id);
		return p.getPosVoteCount();
	}
	
	@ApiOperation(value = "Return the number of downvotes from a post id")
	@GetMapping("/postGetDown/{id}")
	public int getNvotes(@PathVariable int id) {
		Post p = db.findOne(id);
		return p.getNegVoteCount();
	}
}
