<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = null; //로그인이 된사람은 회원가입 페이지에 접근할수 없게한다.
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		if(user.getUserID() == null || user.getUserPassword() == null 
		|| user.getUserName() == null || user.getUserGender() == null){ //하나라도 입력이 안된경우.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()"); // 이전페이지로 돌아간다.
			script.println("</script>");
		}else{			
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user); //user 인스턴스가 join 함수를 실행하도록 매개변수로 들어간다.
			if(result == -1){// 데이터 오류의 경우는 해당아이디가 존재하는 경우밖에없다. 
// 우리가 데이터를 만들때 primary key를  user ID 에게만 주었기때문에 단하나만 존재하는 아이디가 되어야한다.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()"); 
				script.println("</script>");
			}
			else { //아이디가 중복되지않은 경우. 오호 
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp' "); //링크달기 
				script.println("</script>");			
			}
		}		
	%>
</body>
</html>