package myProject.comment;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import myProject.post.Post;

@Repository
public interface CommentDB extends JpaRepository<Comment, Integer> {
	List<Comment> getCommentBypId(int pId);
}