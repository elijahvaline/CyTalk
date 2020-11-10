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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.Data;

@Entity
@Table(name = "messages")
@Data
public class Message {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@NotNull
    @Size(max = 100)
    @Column
    private String userName;
	
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
	
	public Message(String userName, Group group, String content) {
		this.userName = userName;
		this.group = group;
		this.content = content;
	}

	public String getUserName() {
		return userName;
	}

	public String getContent() {
		return content;
	}
	
	public Group getGroup() {
		return group;
	}
}
