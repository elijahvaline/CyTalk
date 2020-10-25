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

	@GetMapping("/user/{username}")
	public User getPerson(@PathVariable String username) {
		User get = db.findOneByUsername(username);
		get.setPasswd(null);
		return get;
	}
	
	@GetMapping("/user/{username}/{image}")
    public ResponseEntity<Resource> downloadFile(@PathVariable("username") String username, @PathVariable("image") String image) throws IOException {
		File file = null;
		if(image.equals("background")) {
			file = storage.load(db.findOneByUsername(username).getBackground()).toFile();
		} else if(image.equals("profile")) {
			file = storage.load(db.findOneByUsername(username).getProfile()).toFile();
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
	
	@PutMapping("/user/{username}")
	User updateUser(@RequestBody User u, @PathVariable String username) {
		User old_u = db.findOneByUsername(username);
		//if (u.getCookie() == old_u.getCookie()) {
			old_u.setUser(u.getFName(), u.getLName(), u.getUName(), u.getPassword(), u.getEmail(), u.getType(), u.getBio());
			db.save(old_u);
			return old_u;
		//} else return null;
	}
	
	@PostMapping("/user/{username}/{image}")
	public void uploadFile(@PathVariable("username") String username, @PathVariable("image") String image, @RequestParam("file") MultipartFile file ) { //, @RequestParam("cookie") String cookie) {
		User temp = db.findOneByUsername(username);
		//if (cookie == temp.getCookie() || db.findOneByCookie(cookie).getType() >= 2) {
			if(image.equals("background")) {
				storage.delete(db.findOneByUsername(username).getBackground());
				temp.setBackground(file.getOriginalFilename());
			} else if(image.equals("profile")) {
				storage.delete(db.findOneByUsername(username).getProfile());
				temp.setProfile(file.getOriginalFilename());
			}

			db.save(temp);
			storage.store(file);
		//}
	}
	
	@DeleteMapping("/user/{username}/{image}") 
	public void deleteFile(@PathVariable("username") String username, @PathVariable("image") String image ) { //, @RequestParam("cookie") String cookie) {
		//if (cookie == db.findOneByUsername(username).getCookie() || db.findOneByCookie(cookie).getType() >= 2) {
			if(image.equals("background")) {
				storage.delete(db.findOneByUsername(username).getBackground());
			} else if(image.equals("profile")) {
				storage.delete(db.findOneByUsername(username).getProfile());
			}
		//}
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
