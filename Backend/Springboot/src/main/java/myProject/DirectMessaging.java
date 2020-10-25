package myProject;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "directmessaging")
public class DirectMessaging {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer p1Id;

	@Column
	private Integer p2Id;

	@Column
	private Integer date;

	@Column
	private String content;

	public Integer getp1Id() {
		return p1Id;
	}

	public Integer getp2Id() {
		return p1Id;
	}

	public String getContent() {
		return content;
	}

}
