package myProject.webSocket;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import myProject.user.User;

@Entity
@Table(name = "chatGroups")
public class Group {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
    @Column
    @Size(max = 100)
    private String groupName;
	
    @JsonIgnore
	@OneToMany(mappedBy="group")
	private Set<Message> messages;
	
	@JsonIgnore
	@ManyToMany (fetch = FetchType.EAGER)
	@JoinTable( name = "groupMembers", 
	joinColumns= @JoinColumn(name = "groupId"), 
	inverseJoinColumns= @JoinColumn(name = "userId"))
	private Set<User> members;
	
	public void addUser(User u) {
		if (members == null) members = new HashSet<>();
		members.add(u);
		u.addGroup(this);
	}
	
	public void removeUser(User u) {
		this.members.remove(u);
		u.removeGroup(this);
	}
	public Set<User> getUsers() {
		return members;
	}
	
	public Group() {};
	
	public long getGroupId() {
		return id;
	}
	
	public String getGroupName() {
		return groupName;
	}
	
	public void clearSet() {
		members = new HashSet<>();
	}
	
	public void setGroupName(String group) {
		groupName = group;
	}
}
