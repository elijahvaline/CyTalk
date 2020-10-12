package myProject;

import static org.junit.Assert.assertEquals;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.springframework.http.MediaType;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.util.FileSystemUtils;

import uploading.ImageService;
import uploading.StorageProperties;

import static org.assertj.core.api.Assertions.assertThat;

public class ImageServiceTest {

	private StorageProperties properties = new StorageProperties();
	private ImageService service;

	@Before
	public void init() {
		properties.setLocation("target/images");
		service = new ImageService(properties);
		FileSystemUtils.deleteRecursively(Paths.get(properties.getLocation()).toFile());
		try {
			Files.createDirectories(Paths.get(properties.getLocation()));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@After
	public void end() {
		FileSystemUtils.deleteRecursively(Paths.get(properties.getLocation()).toFile());
	}

	@Test
	public void saveAndLoad() {
		service.store(new MockMultipartFile("test", "test.txt", MediaType.TEXT_PLAIN_VALUE,
				"Hello World!".getBytes()));
		assertThat(service.load("test.txt")).exists();
		assertEquals("target\\images\\test.txt", service.load("test.txt").toString());
	}

	@Test
	public void deletionTest() {
		service.store(new MockMultipartFile("test", "test.txt", MediaType.TEXT_PLAIN_VALUE,
				"Hello World!".getBytes()));
		assertThat(service.load("test.txt")).exists();
		service.delete("test.txt");
		assertThat(service.load("test.txt")).doesNotExist();
	}
}


