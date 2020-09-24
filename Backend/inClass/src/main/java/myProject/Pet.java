package myProject;

import javax.persistence.*;

@Entity
class Pet {

	@Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer id;

	@Column
	String name;

	@Column
	String type;

	public Integer getId() { return id; }

	public String getName() { return name; }
	public String getType() { return type; }
	public void setType(String type) { this.type = type; }


}
