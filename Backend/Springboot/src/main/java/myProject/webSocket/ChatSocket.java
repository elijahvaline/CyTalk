package myProject.webSocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import myProject.user.User;
import myProject.user.UserDB;

@Controller      // this is needed for this to be an endpoint to springboot
@ServerEndpoint(value = "/chat/{username}/{group}")  // this is Websocket url
public class ChatSocket {

  // cannot autowire static directly (instead we do it by the below
  // method
	private static MessageRepository msgRepo; 
	private static GroupRepository groupRepo; 
	private static UserDB userRepo;
	private Group groupChat;
	/*
   * Grabs the MessageRepository singleton from the Spring Application
   * Context.  This works because of the @Controller annotation on this
   * class and because the variable is declared as static.
   * There are other ways to set this. However, this approach is
   * easiest.
	 */
	@Autowired
	public void setMessageRepository(MessageRepository repo, GroupRepository group, UserDB users) {
		msgRepo = repo;  // we are setting the static variable
		groupRepo = group;
		userRepo = users;
		
	}

	// Store all socket session and their corresponding username.
	private static Map<Session, String> sessionUsernameMap = new Hashtable<>();
	private static Map<String, Session> usernameSessionMap = new Hashtable<>();

	private final Logger logger = LoggerFactory.getLogger(ChatSocket.class);

	@OnOpen
	public void onOpen(Session session, @PathParam("username") String username, @PathParam("group") long group) 
      throws IOException {

		logger.info("Entered into Open");
		this.groupChat = groupRepo.findOne(group);
    // store connecting user information
		sessionUsernameMap.put(session, username);
		usernameSessionMap.put(username, session);

		//Send chat history to the newly connected user
		sendMessageToParticularUser(username, getChatHistory());
	}


	@OnMessage
	public void onMessage(Session session, String message) throws IOException {

		// Handle new messages
		logger.info("Entered into Message: Got Message:" + message);
		String username = sessionUsernameMap.get(session);

		broadcast(username + ": " + message + "*");

		// Saving chat history to repository
		msgRepo.save(new Message(username, groupChat, message));
	}


	@OnClose
	public void onClose(Session session) throws IOException {
		logger.info("Entered into Close");

    // remove the user connection information
		String username = sessionUsernameMap.get(session);
		sessionUsernameMap.remove(session);
		usernameSessionMap.remove(username);
	}


	@OnError
	public void onError(Session session, Throwable throwable) {
		// Do error handling here
		logger.info("Entered into Error");
		throwable.printStackTrace();
	}


	private void sendMessageToParticularUser(String username, String message) {
		try {
			usernameSessionMap.get(username).getBasicRemote().sendText(message);
		} 
    catch (IOException e) {
			logger.info("Exception: " + e.getMessage().toString());
			e.printStackTrace();
		}
	}


	private void broadcast(String message) {
		Set<User> s = groupChat.getUsers();
		for (User u: s) {
			try {
				if (usernameSessionMap.containsKey(u.getUName()))
				usernameSessionMap.get(u.getUName()).getBasicRemote().sendText(message);
			} 
	    catch (IOException e) {
				logger.info("Exception: " + e.getMessage().toString());
				e.printStackTrace();
			}
		}

	}
	

  // Gets the Chat history from the repository
	private String getChatHistory() {
		List<Message> messages = msgRepo.findAllByGroupId(groupChat.getGroupId());
    
    // convert the list to a string
		StringBuilder sb = new StringBuilder();
		if(messages != null && messages.size() != 0) {
			for (Message message : messages) {
				sb.append(message.getUserName() + ": " + message.getContent() + "*\n");
			}
		}
		return sb.toString();
	}

} // end of Class
