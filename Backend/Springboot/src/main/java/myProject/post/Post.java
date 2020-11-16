package myProject.post;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModelProperty;

@Entity
@Table(name = "post")
public class Post {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer pId;

	@ApiModelProperty(notes = "date of when post was created",name="date",value="1456432")
	@Column
	private double date;

	@ApiModelProperty(notes = "the id of a specific user",name="userId",value="1")
	@Column
	private Integer userId;
	
	@ApiModelProperty(notes = "the username of a user",name="userName",value="akashd")
	@Column
	private String userName;

	@ApiModelProperty(notes = "the content in a specific post",name="content",value="Pizza at MU!")
	@Column
	private String content;
	
	@ApiModelProperty(notes = "name of the user",name="name",value="Akash")
	@Column
	private String name;

	@ApiModelProperty(notes = "Number of positive votes for a post",name="pVotes",value="14")
	@Column
	private Integer pVotes = 0;

	@ApiModelProperty(notes = "Number of negative votes for a post",name="nVotes",value="0")
	@Column
	private Integer nVotes = 0;

	public Integer getpId() {
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
	
	public void increasePvotes() {
		pVotes++;
	}
	
	public void increaseNvotes() {
		nVotes++;
	}
}
