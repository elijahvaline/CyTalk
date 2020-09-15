package springSB7;

import java.util.UUID;

public class NumberOfUsers 
{
	private UUID uniqueUser;
	
	NumberOfUsers(){
	}
	
	UUID newUser(){
		uniqueUser = UUID.randomUUID();
		System.out.println(uniqueUser);
		return uniqueUser;
	}

}
