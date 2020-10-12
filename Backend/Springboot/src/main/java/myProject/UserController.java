package myProject;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import uploading.StorageService;

@RestController
public class UserController {

	@Autowired
	UserDB db;
	StorageService storage;
	
	ServletContext servletContext;

	@Autowired
	public UserController(StorageService storageService) {
		storage = storageService;
	}

	@GetMapping("/user/{id}")
	User getPerson(@PathVariable Integer id, HttpServletResponse response) {
		InputStream in = servletContext.getResourceAsStream(storage.load(db.findOne(id).getEmail()).toString());
	    response.setContentType(MediaType.IMAGE_JPEG_VALUE);

	    try {
			IOUtils.copy(in, response.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
		}
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
