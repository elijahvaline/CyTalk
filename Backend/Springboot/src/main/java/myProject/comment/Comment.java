package myProject.comment;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "comment")
public class Comment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer cId;

	@Column
	private Integer pId;
	
	@Column
	private double date;

	@Column
	private String content;

	@Column
	private Integer pVotes=0;

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

	public void setContent(String c) {
		content = c;
	}
	
	public void setCommentId(int i) {
		cId = i;
	}
}
