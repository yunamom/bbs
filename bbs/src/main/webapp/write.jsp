<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
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
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){ //로그인을 한경우 
			userID = (String) session.getAttribute("userID");
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
		<form method="post" action="writeAction.jsp"> 
		<!-- 폼 태그를 이용해서 액션페이지로 보낼수있게 만든다 메소드를 post 라고해서 보내지는 내용이 숨겨지도록 만든다. -->
			<table class="table table-striped" style="text-align: center; border: solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>	
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td> <!--특정한 정보를 input 페이지로 보내기위해 사용한다. -->
					</tr> <!-- 글 제목과 내용이 한줄씩 나올수있도록 tr태그로 각각 묶어준다. -->
					<tr>
						<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height:350px;"></textarea></td> <!--  글작성  -->
					</tr>
				</tbody>				
			</table>		
			<input type="submit" class="btn btn-primary pull-right" value="글쓰기"> <!-- 글쓰기 버튼 -->
		</form>
		</div>
	</div>
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>