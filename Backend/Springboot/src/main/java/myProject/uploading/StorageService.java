package myProject.uploading;

import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Path;

public interface StorageService {

	void store(MultipartFile file);

	Path load(String filename);
	
	void delete(String filename);
}

