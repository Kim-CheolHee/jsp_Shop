<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="common.JDBConnect"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>회원 상세 정보</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 상세 정보</h1>
		</div>
	</div>
	
	<%
		String id = (String)session.getAttribute("sessionId");
		JDBConnect jdbc = new JDBConnect();
	
		String sql = "select * from member where id=?";
		ResultSet rs = null;
		PreparedStatement psmt = jdbc.con.prepareStatement(sql);
		psmt.setString(1, id);
		rs=psmt.executeQuery();
		rs.next();
	%>
	
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<img src="upload/<%=rs.getString("photo")%>"
				style="width:100%;height:400px;">
			</div>
			<div class="col-md-6">
				<h3> 회원 아이디 : <%=rs.getString("id")%> </h3>
				<h3> 회원 비밀번호 : <%=rs.getString("pass")%> </h3>
				<h3> 회원 이름 : <%=rs.getString("name")%> </h3>

			</div>
		</div>
	</div>
	
</body>
</html>









