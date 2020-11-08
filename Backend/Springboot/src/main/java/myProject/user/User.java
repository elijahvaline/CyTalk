package myProject.user;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;

@Entity
@Table(name = "users")
public class User {

	@Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@ApiModelProperty(notes = "First name of the User",name="fname",value="John")
	@Column
	private String fname;
	
	@ApiModelProperty(notes = "Last name of the User",name="lname",value="Doe")
	@Column
	private String lname;
	
	@ApiModelProperty(notes = "Username of the User",name="username",value="JD")
	@Column (unique = true)
	@NotNull
	private String username;

	@ApiModelProperty(notes = "Password of the User",name="password",value="pass")
	@Column
	private String password;
	
	@ApiModelProperty(notes = "Email of the User",name="email",value="John@mail.com")
	@Column
	private String email;
	
	@ApiModelProperty(notes = "Type of User (1 = Admin, 0 = General)",name="type",value="1")
	@Column
	private int type;
	
	@ApiModelProperty(notes = "Background image of the User",name="background",value="test.png")
	@Column
	private String background;
	
	@ApiModelProperty(notes = "{Profile image of the User",name="profile",value="test.png")
	@Column 
	private String profile;
	
	@ApiModelProperty(notes = "Bio information of the User",name="bio",value="Hello world")
	@Column
	private String bio;
	
	@ApiModelProperty(notes = "Cookie of User when logged in",name="cookie",value="cookie")
	@Column
	private String cookie;
	
	public void setUser(String f, String l, String u, String p, String e, String b) {
		if (f != null)
		fname = f;
		if (l != null)
		lname = l;
		if (u != null)
		username = u;
		if (p != null)
		password = p;
		if (e != null)
		email = e;
		if (b != null)
		bio = b;
	}

	public Integer getId() {
		return id; 
	}

	public String getFName() { 
		return fname; 
	}
	
	public String getLName() { 
		return lname; 
	}
	
	public String getUName() { 
		return username; 
	}
	
	public String getPassword() { 
		return password; 
	}
	
	public String getEmail() { 
		return email; 
	}
	
	public int getType() { 
		return type; 
		}
	
	public String getBackground() { 
		return background; 
		}
	
	public String getProfile() { 
		return profile; 
		}
	
	public String getBio() {
		return bio;
	}
	public String getCookie() {
		return cookie;
	}
	
	public void setFName(String fname) { 
		this.fname = fname; 
	}
	public void setLName(String lname) { 
		this.lname = lname; 
	}
	
	public void setUName(String uname) { 
		username = uname; 
	}
	
	public void setPassword(String password) { 
		this.password = password; 
	}
	
	public void setEmail(String email) { 
		this.email = email; 
	}
	
	public void setType(int type) { 
		this.type = type; 
	}
	
	public void setBackground(String background) { 
		this.background = background; 
		}
	
	public void setProfile(String profile) { 
		this.profile = profile;  
		}
	
	public void setBio(String bio) {
		this.bio = bio;
	}
	
	public void setCookie(String cookie) {
		this.cookie = cookie;
	}
	
	public void setId(int i) {
		this.id = i;
	}
}
