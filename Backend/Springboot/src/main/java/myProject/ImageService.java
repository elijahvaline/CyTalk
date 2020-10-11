package myProject;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ImageService implements StorageService {

	private Path rootLocation;

	@Autowired
	public ImageService(StorageProperties properties) {
		rootLocation = Paths.get(properties.getLocation());
	}

	@Override
	public void store(MultipartFile file) {
		try {
			if (file.isEmpty()) {
				throw new StorageException("Failed to store empty file " + file.getOriginalFilename());
			}
			Files.copy(file.getInputStream(), rootLocation.resolve(file.getOriginalFilename()));
		} catch (IOException e) {
			throw new StorageException("Failed to store file " + file.getOriginalFilename(), e);
		}
	}

	@Override
	public Path load(String filename) {
		return rootLocation.resolve(filename);
	}
}