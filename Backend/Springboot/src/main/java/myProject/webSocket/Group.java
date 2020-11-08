package myProject.webSocket;

import java.util.Set;

import javax.persistence.*;
import javax.validation.constraints.Size;

import lombok.Data;
import myProject.user.User;

@Entity
@Table(name = "chatGroups")
@Data
public class Group {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
    @Column
    @Size(max = 100)
    private String groupName;
	
	@OneToMany(mappedBy="group")
	private Set<Message> messages;
	
	@ManyToMany
	@JoinTable( name = "groupMembers", 
	joinColumns= @JoinColumn(name = "groupId"), 
	inverseJoinColumns= @JoinColumn(name = "userId"))
	Set<User> groups;
	
	public Group() {};
	
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String group) {
		groupName = group;
	}
}
