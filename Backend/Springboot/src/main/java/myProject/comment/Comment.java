package myProject.comment;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import io.swagger.annotations.ApiModelProperty;

@Entity
@Table(name = "comment")
public class Comment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer cId;

	@ApiModelProperty(notes = "post id that is linked with a comment",name="pId",value="4")
	@Column
	private Integer pId;
	
	@ApiModelProperty(notes = "date of when comment was created",name="date",value="1456432")
	@Column
	private double date;

	@ApiModelProperty(notes = "content of comment",name="content",value="I'll be there!")
	@Column
	private String content;

	@ApiModelProperty(notes = "name of comment creator",name="name",value="Jack")
	@Column
	private String name;
	
	@ApiModelProperty(notes = "username of comment creator",name="userName",value="JackH")
	@Column
	private String userName;
	
	@ApiModelProperty(notes = "number of positive votes on a comment",name="pVotes",value="3")
	@Column
	private Integer pVotes=0;

	@ApiModelProperty(notes = "number of negative votes on a comment",name="nVotes",value="0")
	@Column
	private Integer nVotes=0;

	public Integer getCommentId() {
		return cId;
	}

	public double getDate() {
		return date;
	}

	public String getContent() {
		return content;
	}

	public Integer getPosVoteCount() {
		return pVotes;
	}

	public Integer getNegVoteCount() {
		return nVotes;
	}

	public String getUserName() {
		return userName;
	}
	
	public String getName() {
		return name;
	}
	
	public Integer getpId() {
		return pId;
	}
	
	public void setContent(String c) {
		content = c;
	}
	
	public void setCommentId(int i) {
		cId = i;
	}
	
	public void setpId(int i) {
		pId = i;
	}
	
	public void increasePvotes() {
		pVotes++;
	}
	
	public void increaseNvotes() {
		nVotes++;
	}
}
