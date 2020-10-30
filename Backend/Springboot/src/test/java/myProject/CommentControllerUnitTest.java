package myProject;
import myProject.uploading.StorageService;

import org.junit.Before;
import org.junit.Rule;
//import junit/spring tests
import org.junit.Test;
import org.junit.rules.TemporaryFolder;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.util.FileSystemUtils;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;

import javax.servlet.ServletContext;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

import org.springframework.http.MediaType;
import org.springframework.mock.web.MockMultipartFile;

//import mockito related
import static org.mockito.Mockito.when;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.any;
import static org.hamcrest.CoreMatchers.*;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.is;

@RunWith(SpringRunner.class)
@WebMvcTest(CommentController.class)
public class CommentControllerUnitTest {
	@Autowired
	private MockMvc controller;

	//@MockBean // note that this service is needed in my controller
	//private StorageService service;
	
	@MockBean // note that this repo is also needed in controller
	private CommentDB repo;
	
	@MockBean Comment c;
	
	@Before
	public void setUp() {
		Comment c = new Comment();
		c.setContent("test");
	}
	
	@Test
	public void newComment() throws Exception{
		when(c.getCommentId()).thenReturn(1);
		when(c.getContent()).thenReturn("test");
		String json = "{ \"content\" : \"nice post\"}";
		MvcResult result = controller.perform(MockMvcRequestBuilders.get("/Comment").contentType(MediaType.APPLICATION_JSON).content(json)).andReturn();
	}
	
	@Test
	public void addComment() throws Exception{
		when(c.getCommentId()).thenReturn(1);
		when(c.getContent()).thenReturn("akash");
		String json = "{ \"content\" : \"I like your post\"}";
		MvcResult result = controller.perform(MockMvcRequestBuilders.get("/Comment").contentType(MediaType.APPLICATION_JSON).content(json)).andReturn();
	}
}
