<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="common.JDBConnect"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	
	JDBConnect jdbc = new JDBConnect();
	
	String sql = "update member set pass=?, name=? where id=?";
	PreparedStatement psmt = jdbc.con.prepareStatement(sql);
	psmt.setString(1, password);
	psmt.setString(2, name);
	psmt.setString(3, id);
	int result = psmt.executeUpdate();
	
	String resultmessage="";
	if(result==1) {
		resultmessage = "회원 정보가 정상적으로 수정되었습니다.";
	} else {
		resultmessage = "회원 정보 수정이 잘못되었습니다.";
	}
%>

<!DOCTYPE html>
<html>
<head>
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
	<div class="container">
			<h1 class="display-5"><%=resultmessage%></h1>
	</div>
</body>
</html>