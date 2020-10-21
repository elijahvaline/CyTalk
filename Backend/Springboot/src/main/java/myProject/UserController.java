package myProject;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import myProject.uploading.StorageService;

//import uploading.StorageService;

@RestController
public class UserController {

	@Autowired
	UserDB db;
	StorageService storage;

	@Autowired
	public UserController(StorageService storageService) {
		storage = storageService;
	}

	@GetMapping("/user/{id}")
	User getPerson(@PathVariable Integer id) {
		return db.findOne(id);
	}
	
	@GetMapping("/user/{id}/{image}")
    public ResponseEntity<Resource> download(@PathVariable("id") Integer id, @PathVariable("image") String image) throws IOException {
		File file = null;
		if(image.equals("background")) {
			file = storage.load(db.findOne(id).getBackground()).toFile();
		} else if(image.equals("profile")) {
			file = storage.load(db.findOne(id).getProfile()).toFile();
		}

        Path path = Paths.get(file.getAbsolutePath());
        ByteArrayResource resource = new ByteArrayResource(Files.readAllBytes(path));

        return ResponseEntity.ok()
                .contentLength(file.length())
                .contentType(MediaType.parseMediaType("application/octet-stream"))
                .body(resource);
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
		old_u.setUser(u.getFName(), u.getLName(), u.getUName(), u.getPassword(), u.getEmail(), u.getType(), u.getBio());
		db.save(old_u);
		return old_u;
	}
	
	@PostMapping("/user/{id}/{image}")
	public void fileUpload(@PathVariable("id") Integer id, @PathVariable("image") String image, @RequestParam("file") MultipartFile file) {
		if(image.equals("background")) {
			storage.delete(db.findOne(id).getBackground());
			db.findOne(id).setBackground(image);
		} else if(image.equals("profile")) {
			storage.delete(db.findOne(id).getProfile());
			db.findOne(id).setProfile(image);
		}
		storage.store(file);
	}
	
	@DeleteMapping("/user/{id}/{image}") 
	public void deleteFile(@PathVariable("id") Integer id, @PathVariable("image") String image) {
		if(image.equals("background")) {
			storage.delete(db.findOne(id).getBackground());
		} else if(image.equals("profile")) {
			storage.delete(db.findOne(id).getProfile());
		}
	}

}
