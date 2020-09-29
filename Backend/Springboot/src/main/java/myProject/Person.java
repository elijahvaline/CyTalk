package myProject;

import javax.persistence.*;

@Entity
class Person {
	
	@Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer id;
	
	@Column
	String user;
	
	@Column
	String address;
	
	public Integer getId() { return id; }
	
	public String getUser() { return user; }
	public String getAddress() { return address; }
	public void setAddress(String address) { this.address = address; }
	
	
}