package myProject;

import javax.persistence.*;

@Entity
@Table(name = "users")
class User {

	@Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column
	private String user_name;

	@Column
	private String password;
	
	@Column
	private String email;
	
	@Column
	private String type;

	public Integer getId() {
		return id; 
	}

	public String getName() { 
		return user_name; 
	}
	
	public String getType() { 
		return type; 
		}
	
	public void setType(String type) { 
		this.type = type; 
	}


}
