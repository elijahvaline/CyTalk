package myProject.webSocket;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface GroupRepository extends JpaRepository<Group, Long>{
	Group findByGroupName(String group);
}
