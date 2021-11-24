<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> <!-- 게시글을 작성할수있는 데이터베이스는 bbsDAO 객체를 이용해서 다룰수있다. -->
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
<jsp:setProperty name="bbs" property="bbsTitle"/> <!-- 게시물 제목 -->
<jsp:setProperty name="bbs" property="bbsContent"/><!-- 게시물 글 -->


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
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()"); // 이전페이지로 돌아간다.
			script.println("</script>");
		}else{			
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent()); //user 인스턴스가 join 함수를 실행하도록 매개변수로 들어간다.
			if(result == -1){// 이거 너무어렵다...게시판.. 진짜...계속 연습하자!!!
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()"); 
				script.println("</script>");
			}
			else { 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'bbs.jsp' "); //링크달기 
				script.println("</script>");			
			}
		}	
	}		
	%>
</body>
</html>