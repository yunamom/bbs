<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "java.util.ArrayList" %> <!-- ArrayList 게시판의 목록을 출력하기 위해서 불러온다. -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 컴퓨터 폰 어느곳에서도 해상도에 맞게 알아서 디자인이 변경되는 반응형 웹 메타테그 -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- css폴더 안의 bootstrap.css를 참조해서 이 홈페이지의 디자인을 사용하는 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>BBS</title>
<style type="text/css">
	a, a:hover { 
		color: #000000; 
		text-decoration: none; //색을 검정으로 바꾸고 밑줄이 그어지지 않게끔 style 코드를 추가 
	}
</style>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){ //로그인을 한경우 
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<!--  네비게이션 영역 -->
	<nav class="navbar navbar-default">
		<!-- 헤더 영역(홈페이지 로고 등) -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			</button>
			<!-- 상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동한다 -->
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null){ //로그인이 되어있지 않다면.
			%>		
				<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<!--  드랍다운 아이템 영역 -->
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
				 	</ul>
				 </li>
			</ul>			
			<%
				} else {//로그인이 되어있는 회원들이 볼수있는 영역.
			%>
				<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<!--  드랍다운 아이템 영역 -->
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
				 	</ul>
				 </li>
			</ul>										
			<% 
				}
			%>
			
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();//인스턴스생성
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int i=0; i<list.size(); i++){
					%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td> <!-- 특수문자를 치환해 주는 코드를 추가해 줌으로써 보안상의 문제를 막아줄수있다.외부에서 악성스크립트를 삽입하려고 하더라도 특수문자를 우리눈에 보이는 형태로 치환해줌으로써 미연에 방지한다. -->
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
					</tr>				
					<% 
						}	
					%>
				</tbody>		
			</table> <!-- 테이블 자체는 글의 목록을 보여주는 역할이고 오른쪽 밑에 글을 쓸수있는 화면으로 넘어갈수있게 링크를 달아준다.  -->
			<%
				if(pageNumber != 1){
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber -1 %>" class="btn btn-success btn-arraw-left">이전</a>
			<%
				} if(bbsDAO.nextPage(pageNumber + 1)) {
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber +1 %>" class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>