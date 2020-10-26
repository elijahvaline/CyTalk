package myProject;

import javax.persistence.*;

@Entity
@Table(name = "post")
class Post {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer pId;

	@Column
	private double date;

	@Column
	private Integer userId;
	
	@Column
	private String userName;

	@Column
	private String content;
	
	@Column
	private String name;

	@Column
	private Integer pVotes = 0;

	@Column
	private Integer nVotes = 0;

	public Integer getPostId() {
		return pId;
	}

	public double getDate() {
		return date;
	}

	public Integer getUserId() {
		return userId;
	}

	public String getContent() {
		return content;
	}
	
	public String getUserName() {
		return userName;
	}
	
	public String getName() {
		return name;
	}
	
	public Integer getPosVoteCount() {
		return pVotes;
	}

	public Integer getNegVoteCount() {
		return nVotes;
	}

	public void setContent(String s) {
		content = s;
	}

	public void setUserId(int i) {
		userId = i;
	}
	
	public void setUserName(String s) {
		userName = s;
	}
}
