package myProject;

import myProject.uploading.StorageService;

//import junit/spring tests
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.io.InputStream;

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
	
	@Autowired
	private MockMvc controller;

	@MockBean // note that this service is needed in my controller
	private StorageService service;
	
	@MockBean // note that this repo is also needed in controller
	private UserDB repo;

	@Test
	public void uploadFile() throws Exception {
		MockMultipartFile multipartFile = new MockMultipartFile("file", "test.txt",
				"multipart/form-data", "Spring Framework".getBytes());
		MvcResult result = controller.perform(MockMvcRequestBuilders.fileUpload("/user/1").file(multipartFile))
				.andExpect(status().is(200)).andReturn();
        assertEquals(200, result.getResponse().getStatus());
        assertNotNull(result.getResponse().getContentAsString());
        verify(service).store(multipartFile);
	}

	@Test
	public void downloadFile() throws Exception {
        MvcResult result = controller.perform(MockMvcRequestBuilders.get("/user/1").contentType(MediaType.APPLICATION_OCTET_STREAM))
			.andExpect(MockMvcResultMatchers.status().is(200)).andReturn();
        assertEquals(200, result.getResponse().getStatus());
	}
}
