<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	String id = (String)session.getAttribute("sessionId");
%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>회원정보수정</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원정보수정</h1>
		</div>
	</div>
	
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			
			<form class="form-signin" action="editmemberprocess.jsp" method="post">

				<div class="form-group">
					<label for="inputUserId" class="sr-only">아이디</label> 
					<input type="text" class="form-control" name="id" readonly value=<%=id%>>
				</div>
				<div class="form-group">
					<label for="inputPassword" class="sr-only">비밀번호</label> 
					<input type="password" class="form-control" 
					placeholder="비밀번호" name="password" required>
				</div>
				<div class="form-group">
					<label for="inputName" class="sr-only">이름</label> 
					<input type="text" class="form-control" 
					placeholder="이름" name="name" required>
				</div>
				
				<button class="btn btn btn-lg btn-success btn-block" 
					type="submit">회원정보수정</button>

			</form>
		</div>
	</div>
</body>
</html>