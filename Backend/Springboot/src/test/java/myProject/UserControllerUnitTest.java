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
@WebMvcTest(UserController.class)
public class UserControllerUnitTest {
	
//	@Test
//    public void shouldAnswerWithTrue()
//    {
//        assertTrue( true );
//    }
	
	@Autowired
	private MockMvc controller;

	@MockBean // note that this service is needed in my controller
	private StorageService service;
	
	@MockBean // note that this repo is also needed in controller
	private UserDB repo;
	
	@MockBean User u;

	@Before
	public void setUp() {
		User l = new User();
		l.setBackground("test");
		when(repo.findOne(1)).thenReturn(l);
	}
	
	@Rule
	public TemporaryFolder folder = new TemporaryFolder();
	
	@Test
	public void login() throws Exception {
		when(u.getId()).thenReturn(1);
		when(u.getUName()).thenReturn("test");
		when(u.getPassword()).thenReturn("password");
		when(repo.findOneByUsername("test")).thenReturn(u);
		String json = "{ \"uname\" : \"test\", \"password\" : \"password\"}";
		MvcResult result = controller.perform(MockMvcRequestBuilders.get("/login").contentType(MediaType.APPLICATION_JSON).content(json))
				.andExpect(MockMvcResultMatchers.status().is(200)).andReturn();
		String json2 = "{ \"uname\" : \"test\", \"password\" : \"pass\"}";
		MvcResult result1 = controller.perform(MockMvcRequestBuilders.get("/login").contentType(MediaType.APPLICATION_JSON).content(json2))
				.andExpect(MockMvcResultMatchers.status().is(403)).andReturn();
	}
	
//	@Test
//	public void uploadFile() throws Exception {
//		MockMultipartFile multipartFile = new MockMultipartFile("file", "test.txt",
//				"multipart/form-data", "Spring Framework".getBytes());
//		MvcResult result = controller.perform(MockMvcRequestBuilders.fileUpload("/user/1/background").file(multipartFile))
//				.andExpect(status().is(200)).andReturn();
//        assertEquals(200, result.getResponse().getStatus());
//        assertNotNull(result.getResponse().getContentAsString());
//        verify(service).store(multipartFile);
//	}

	@Test
	public void downloadFile() throws Exception {
		File test = folder.newFile("test.txt");
		when(service.load(Mockito.anyString())).thenReturn(test.toPath());
        MvcResult result = controller.perform(MockMvcRequestBuilders.get("/user/1/background").contentType(MediaType.APPLICATION_OCTET_STREAM))
			.andExpect(MockMvcResultMatchers.status().is(200)).andReturn();
        assertEquals(200, result.getResponse().getStatus());
        verify(service).load("test");
	}
	
//	@Test
//	public void deleteFile() throws Exception {
//        MvcResult result = controller.perform(MockMvcRequestBuilders.delete("/user/1/background").contentType(MediaType.APPLICATION_OCTET_STREAM))
//			.andExpect(MockMvcResultMatchers.status().is(200)).andReturn();
//        assertEquals(200, result.getResponse().getStatus());
//        verify(service).delete("test");
//	}
}
