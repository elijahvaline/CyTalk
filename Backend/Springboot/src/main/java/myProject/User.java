package myProject;

import javax.persistence.*;

@Entity
@Table(name = "users")
class User {

	@Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column
	private String fname;
	
	@Column
	private String lname;
	
	@Column
	private String user_name;

	@Column
	private String password;
	
	@Column
	private String email;
	
	@Column
	private String type;
	
	@Column
	private String background;
	
	@Column 
	private String profile;
	
	@Column
	private String bio;
	
	public void setUser(String f, String l, String u, String p, String e, String t, String b) {
		if (f != null)
		fname = f;
		if (l != null)
		lname = l;
		if (u != null)
		user_name = u;
		if (p != null)
		password = p;
		if (e != null)
		email = e;
		if (t != null)
		type = t;
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
		return user_name; 
	}
	
	public String getPassword() { 
		return password; 
	}
	
	public String getEmail() { 
		return email; 
	}
	
	public String getType() { 
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
	
	public void setFName(String fname) { 
		this.fname = fname; 
	}
	public void setLName(String lname) { 
		this.lname = lname; 
	}
	
	public void setUName(String uname) { 
		user_name = uname; 
	}
	
	public void setPasswd(String password) { 
		this.password = password; 
	}
	
	public void setEmail(String email) { 
		this.email = email; 
	}
	
	public void setType(String type) { 
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
}
