package myProject;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
    public ResponseEntity<Resource> downloadFile(@PathVariable("id") Integer id, @PathVariable("image") String image) throws IOException {
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
		if (u.getCookie() == old_u.getCookie()) {
			old_u.setUser(u.getFName(), u.getLName(), u.getUName(), u.getPassword(), u.getEmail(), u.getType(), u.getBio());
			db.save(old_u);
			return old_u;
		} else return null;
	}
	
	@PostMapping("/user/{id}/{image}")
	public void uploadFile(@PathVariable("id") Integer id, @PathVariable("image") String image, @RequestParam("file") MultipartFile file, @RequestParam("cookie") String cookie) {
		User temp = db.findOne(id);
		if (cookie == temp.getCookie() || db.findOneByCookie(cookie).getType() >= 2) {
			if(image.equals("background")) {
				storage.delete(db.findOne(id).getBackground());
				temp.setBackground(file.getOriginalFilename());
			} else if(image.equals("profile")) {
				storage.delete(db.findOne(id).getProfile());
				temp.setProfile(file.getOriginalFilename());
			}

			db.save(temp);
			storage.store(file);
		}
	}
	
	@DeleteMapping("/user/{id}/{image}") 
	public void deleteFile(@PathVariable("id") Integer id, @PathVariable("image") String image, @RequestParam("cookie") String cookie) {
		if (cookie == db.findOne(id).getCookie() || db.findOneByCookie(cookie).getType() >= 2) {
			if(image.equals("background")) {
				storage.delete(db.findOne(id).getBackground());
			} else if(image.equals("profile")) {
				storage.delete(db.findOne(id).getProfile());
			}
		}
	}
	
	@GetMapping("/login")
	public ResponseEntity<String> login(@RequestBody User u) {
		User s = db.findOneByUsername(u.getUName());
		if (s.getUName() != null && s.getPassword().equals(u.getPassword())) {
			String c = s.getId().toString();
			Random rand = new Random();
			for (int i = 0; i < 11; i++) {
				c += (char) (rand.nextInt(94) + 33);
			}
			s.setCookie(c);
			db.save(s);
			return ResponseEntity.ok().body(s.getCookie());
		} else {
			return ResponseEntity.status(403).body("Wrong username or password");
		}
	}
}
