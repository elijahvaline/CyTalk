package myProject.uploading;

import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Path;
/**
 * Service for uploading images/files
 * @author Casey Wong
 */
public interface StorageService {

	/**
	 * Uploads the file
	 * @param file the files to be uploaded
	 */
	void store(MultipartFile file);

	/**
	 * Loads the path to the named file
	 * @param filename the string name of the file
	 * @return the path to the named file on the server
	 */
	Path load(String filename);
	
	/**
	 * Deletes the named file from storage
	 * @param filename the string name of the file
	 */
	void delete(String filename);
}

