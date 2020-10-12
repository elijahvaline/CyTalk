package myProject;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

import uploading.StorageProperties;


@SpringBootApplication
@EnableConfigurationProperties(StorageProperties.class)
public class App {

	public static void main(String[] args) {
		SpringApplication.run(App.class, args);
	}
}