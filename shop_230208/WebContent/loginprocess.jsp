<%@page import="java.sql.*"%>
<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		JDBConnect jdbc = new JDBConnect();
			
		String sql = "select * from member";
		PreparedStatement psmt = jdbc.con.prepareStatement(sql);
		ResultSet rs = psmt.executeQuery();
		
		String result="";
		while(rs.next()) {
			String id2 = rs.getString(1);
			String password2 = rs.getString(2);
			String name = rs.getString(3);
			
			if(id.equals(id2) && password.equals(password2)) {
				result=name + "님 환영합니다.";
				session.setAttribute("sessionId",id2);
				session.setAttribute("sessionName",name);
				break;
			}
		}
		
		if(result=="") {
			RequestDispatcher rd 
			= request.getRequestDispatcher("login.jsp?error=1");
			rd.forward(request, response);
		}
		jdbc.close();
	
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">로그인 처리</h1>
		</div>
	</div>
	
	<div class="container">
			<h1 class="display-5"><%=result%></h1>
			<a href="welcome.jsp" class="btn btn-secondary"> 돌아가기 </a>
	</div>
</body>
</html>