package springSB7;

public class NewUser 
{
	private Long id;
	private String username;
	private String password;
	
	public Long getId()
	{
		return id;
	}
	
	public void createUserId(Long id)
	{
		this.id = id;
	}
	
	public void createUsername(String username)
	{
		this.username= username;
	}
	
	public String getUsername()
	{
		return username;
	}
	
	public void createPassword(String password)
	{
		this.password = password;
	}
	
	public String getPassword()
	{
		return password;
	}
}
