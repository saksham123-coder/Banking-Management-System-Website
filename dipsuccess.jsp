
<%@ page import="java.sql.*"%>
<%@ page language="java" session="true"%>
<%@ page import= "java.util.Calendar"%>
<%@ page import= "java.util.Date"%>
<%
    String deposit = request.getParameter("dipamount");
    String accno = (String)session.getAttribute("accno");
    String pinno = (String)session.getAttribute("pinno");
    String dipth = request.getParameter("dipth");
    Date d=new Date();  
            Date today = new Date(); 
         Calendar cal = Calendar.getInstance();
         cal.setTime(today); 
         String[] monthNames = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
 int month = cal.get(Calendar.MONTH); 
         String monthsnames =  monthNames[month];
    if(dipth.equals("Deposit")){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            String uname = "root";
            int bal_due=0;
            String pass = "";
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank",uname,pass);
            Statement st = con.createStatement();
            Statement sts = con.createStatement();
            ResultSet yts = sts.executeQuery("SELECT Account_user_id FROM account_table where pin_no='"+pinno+"'");
            yts.next();
            String accusid = yts.getString("Account_user_id");
            ResultSet rs = st.executeQuery("Select balance from account_table where Account_user_id = "+accusid);
            rs.next();
            String balance = rs.getString("balance");
            int w = Integer.parseInt(deposit);
            int s = Integer.parseInt(balance);
            bal_due= s+w;
            String qry= "INSERT INTO `deposit_table` (`Account_no`, `deposit_amount`,`Account_user_id`,`balance_due`,`Month`,`Date`) VALUES ('"+accno+"', '"+deposit+"', '"+accusid+"', '"+bal_due+"','"+monthsnames+"','"+java.time.LocalDate.now()+"')";
            String qrry= "UPDATE account_table SET balance="+ bal_due+" WHERE Account_no = '"+accno+"' ;";
            st.executeUpdate(qry);
            st.executeUpdate(qrry);
            
            %>
            <script type="text/javascript">
            alert("Deposition Successfull");
            window.location.href = "dash.jsp";
            </script>
            <%
                    

           
    }
            catch(Exception e){
            out.println(e.getMessage());
        }
    }
    else{
        out.print("withdraw cancel");
    }
%>