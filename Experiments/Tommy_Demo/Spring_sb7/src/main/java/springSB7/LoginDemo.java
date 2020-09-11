package springSB7;

import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.FileReader;
import java.io.BufferedReader;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
public class LoginDemo extends JFrame implements ActionListener {
   JPanel panel;
   JLabel user_label, password_label, message;
   JTextField userName_text;
   JPasswordField password_text;
   JButton submit, cancel;
   LoginDemo() {

      user_label = new JLabel();
      user_label.setText("User Name :");
      userName_text = new JTextField();

      password_label = new JLabel();
      password_label.setText("Password :");
      password_text = new JPasswordField();
   
      submit = new JButton("SUBMIT");
      panel = new JPanel(new GridLayout(3, 1));
      panel.add(user_label);
      panel.add(userName_text);
      panel.add(password_label);
      panel.add(password_text);
      message = new JLabel();
      panel.add(message);
      panel.add(submit);
      setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
     
      submit.addActionListener(this);
      add(panel, BorderLayout.CENTER);
      setTitle("Please Login Here !");
      setSize(450,350);
      setVisible(true);
   }
   public static void main(String[] args) {
      new LoginDemo();
      
   }
   @Override
   public void actionPerformed(ActionEvent ae) {
      String userName = userName_text.getText();
      String password = password_text.getText();
      userTable(userName_text.getText(),password_text.getText());
      message.setText("User Created");
   }
   
   public static void userTable(String username, String password){
	   try(FileWriter fw = new FileWriter("myfile.txt", true);
			    BufferedWriter bw = new BufferedWriter(fw);
			    PrintWriter out = new PrintWriter(bw))
			{
			    out.println("user: "+ username + "|" + "password: " + password);
			} catch (IOException e) {
			    //exception handling left as an exercise for the reader
			}
   }
   
   public static void organizeFile() {
	   try {
		FileReader rf = new FileReader("myfile.txt");
	} catch (FileNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
   }
}
