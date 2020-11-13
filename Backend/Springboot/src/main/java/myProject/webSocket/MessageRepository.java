package myProject.webSocket;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface MessageRepository extends JpaRepository<Message, Long>{
	List<Message> findAllByGroupId(long group);
	
	@Query(value ="Select * From messages m Where m.group_id = ?1 And "
			+ "m.id = (SELECT max(id) FROM messages Where group_id = ?1)", nativeQuery = true)
	Message findMessageByGroupId(long group);
}
