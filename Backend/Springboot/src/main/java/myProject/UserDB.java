package myProject;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;


@Repository
public interface UserDB extends JpaRepository<User, Integer> {
	User findOneByUsername(String username);
	User findOneByCookie(String cookie);
}
