package com.mnt.time.controller;

import java.awt.Color;
import java.awt.Container;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.Timer;

import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;
 
public class Login extends JFrame implements ActionListener
{
	public static final DateFormat df = new SimpleDateFormat("hh:mm:ss");
    JLabel l1, l2, l3;
    JTextField tf1,tf2,tf3;
    JButton btn1,btn2,btn3;
    JPasswordField p1;
  
    private int hour = 00;
    private int min = 00;
    private int sec = 00;
    private int msec = 00;
    private Timer timer;
    Connection con ;
    public int currentUserID;
    public String dayString;
 
    Login()
    {
        setTitle("Login Form ");
        setVisible(true);
        setSize(600, 400);
        setLayout(null);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setBackground(Color.black);
       
       
        l1 = new JLabel("Login Form :");
        l1.setForeground(Color.blue);
        l1.setFont(new Font("Serif", Font.BOLD, 20));
 
        l2 = new JLabel("Enter Username:");
        l3 = new JLabel("Enter Password:");
        tf1 = new JTextField();
        p1 = new JPasswordField();
        btn1 = new JButton("Submit");
 
        l1.setBounds(100, 30, 400, 30);
        l2.setBounds(80, 70, 200, 30);
        l3.setBounds(80, 110, 200, 30);
        tf1.setBounds(300, 70, 200, 30);
        p1.setBounds(300, 110, 200, 30);
        btn1.setBounds(150, 160, 100, 30);
 
        add(l1);
        add(l2);
        add(tf1);
        add(l3);
        add(p1);
        add(btn1);
        btn1.addActionListener(this);
    }
 

    public void actionPerformed(ActionEvent e)
    {
        showData();
     
    }
 
   private class UpdateTimeAction implements ActionListener{
        public void actionPerformed(ActionEvent e){
            addMsec();
            tf1.setText(hour+"");
            tf2.setText(min+"");
            tf3.setText(sec+"");
            try
            {
            	Class.forName("com.mysql.jdbc.Driver");
	            Calendar cal = Calendar.getInstance();
	            int month = cal.get(cal.DAY_OF_WEEK);
	            switch (month) {
		            case 1:  dayString = "sun";
		                     break;
		            case 2:  dayString = "mon";
		                     break;
		            case 3:  dayString = "tue";
		                     break;
		            case 4:  dayString = "wed";
		                     break;
		            case 5:  dayString = "thus";
		                     break;
		            case 6:  dayString = "fri";
		                     break;
		            case 7:  dayString = "sat";
		                     break;
		           
		            default: dayString = "Invalid month";
	                     	break;
	            }
	            if((sec % 10) == 0 && con != null){
	            	
	            	updatetime();
		           
	            }
	            /*if (btn3.getActionListeners() != null) {
	            	
	            	updatetime();
				}	       */     	
	            
	           
            } catch (Exception ex)
            {
                System.out.println(ex);
            }
        }
   }  
     private void addMsec(){
     msec++;
     if(msec==10){
         msec=0;
         sec++;
         if(sec==60){
             sec=0;
             min++;
             if(min==60){
                 min=0;
                 hour++;
             }
         }
     
     }

    }

     private void updatetime() throws SQLException, ParseException
     {
  	   java.sql.Statement stmt =  con.createStatement();
     	String time = String.format("%02d:%02d:%02d", hour, min, sec);
     	 DateFormat formatter = new SimpleDateFormat("hh:mm:ss");
     	 Date date = (Date)formatter.parse(time);
     	 Time time1 = new Time(date.getTime());
     	 System.out.println("QUERY :: "+time1);
      String query = "UPDATE timesheet_row  SET "+dayString+" = '"+time1+"' where timesheet_row.timesheet_id = ( Select timesheet.id from timesheet where timesheet.user_id = "+currentUserID+" )";
        int i = stmt.executeUpdate(query);
     } 
    
    
    public void showData()
    {
        JFrame f1 = new JFrame();
        JLabel l, l0;
        JFrame gui = new JFrame();
        
        timer=new Timer(100,new UpdateTimeAction());
        
        String str1 = tf1.getText();
        char[] p = p1.getPassword();
        String str2 = new String(p);
        try
        {
            //Class.forName("com.mysql.jdbc.Driver");
        
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/timecld", "root", "");
        	
            PreparedStatement ps = con.prepareStatement("select * from user where first_name=? and password=?");
            ps.setString(1, str1);
            ps.setString(2, str2);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
            {
            	
                f1.setVisible(true);
                f1.setSize(600, 600);
                f1.setLayout(null);
                setVisible(false);
              f1.setBackground(Color.BLUE);
                
                
              tf1 = new JTextField();
                tf2 = new JTextField();
                tf3 = new JTextField();
               
                btn2 = new JButton("start");
                btn3 = new JButton("stop");
               
               
               tf1.setBounds(80, 70, 80, 30);
                tf2.setBounds(200, 70, 80, 30);
                tf3.setBounds(320, 70, 80, 30);
                btn2.setBounds(120, 160, 100, 30);
                btn3.setBounds(250, 160, 100, 30);
              
             
                f1.add(tf1);
                f1.add(tf2);
                f1.add(tf3);
               
                f1.add(btn2);
      	     	f1.add(btn3);
                
      	       l = new JLabel();
               l0 = new JLabel("you are succefully logged in..");
               l0.setForeground(Color.blue);
               l0.setFont(new Font("Serif", Font.BOLD, 30));
                l.setBounds(60, 230, 400, 30);
                l0.setBounds(60, 300, 400, 40);
                
                currentUserID = Integer.parseInt(rs.getString(1));
                f1.add(l);
                f1.add(l0);
                l.setText("Welcome User :" + rs.getString(1));
                l.setForeground(Color.red);
                l.setFont(new Font("Serif", Font.BOLD, 30));
               
               
               Display display = new Display();
       	       Shell shell = new Shell(display);
       	       shell.setLayout(new GridLayout(3, true));
       	       
       	       
       	      btn2.addActionListener(new ActionListener(){
                  public void actionPerformed(ActionEvent e){
                      timer.start();
                  }    
              });
              
             // JButton pauseBut=new JButton("Start/Pause");
              btn3.addActionListener(new ActionListener(){
                  public void actionPerformed(ActionEvent e){
                      if(timer.isRunning())
                          timer.stop();
                      		try {
								updatetime();
							} catch (SQLException e1) {
								
								e1.printStackTrace();
							} catch (ParseException e1) {
								
								e1.printStackTrace();
							}
                  }
              });
            } else
            {
                JOptionPane.showMessageDialog(null,
                   "Incorrect username or password..Try Again with correct detail");
            }
        }
        catch (Exception ex)
        {
            System.out.println(ex);
        }
    }
    
    
 
    public static void main(String arr[])
    {
        new Login();
        
    }
}