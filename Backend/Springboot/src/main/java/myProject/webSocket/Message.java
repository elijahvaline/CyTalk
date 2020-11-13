package myProject.webSocket;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.Data;
import myProject.user.User;

@Entity
@Table(name = "messages")
public class Message {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
    @ManyToOne
    @JoinColumn(name = "user_id", nullable=false)
    private User user;
	
	@NotNull
    @Lob
    private String content;
	
	@NotNull
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "sent")
    private Date sent = new Date();
		
	@ManyToOne
	@JoinColumn
	(name="group_id", nullable=false)
	private Group group;
	
	public Message() {};
	
	public Message(User userName, Group group, String content) {
		this.user = userName;
		this.group = group;
		this.content = content;
	}

	public String getUserName() {
		return user.getUName();
	}

	public String getContent() {
		return content;
	}
	
	public Group getGroup() {
		return group;
	}
}
