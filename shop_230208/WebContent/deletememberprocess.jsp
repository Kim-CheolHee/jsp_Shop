<%@page import="java.sql.*"%>
<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		String id = (String)session.getAttribute("sessionId");
		String password = request.getParameter("password");
		JDBConnect jdbc = new JDBConnect();
			
		String sql = "select * from member where id=?";
		PreparedStatement psmt = jdbc.con.prepareStatement(sql);
		psmt.setString(1, id);
		ResultSet rs = psmt.executeQuery();
		
		String result="";
		
		while(rs.next()) {
			String password2 = rs.getString(2);
			String name = rs.getString(3);
				
			if(password.equals(password2)) {
				result=name + "님 회원 탈퇴가 정상적으로 진행되었습니다.";
				String sql2 = "delete from member where id=?";
				PreparedStatement psmt2 = jdbc.con.prepareStatement(sql2);
				psmt2.setString(1, id);
				psmt2.executeUpdate();
				
				session.invalidate();
				break;
			}
		}
		
		if(result=="") {
			RequestDispatcher rd 
			= request.getRequestDispatcher("deletemember.jsp?error=1");
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
			<h1 class="display-3">회원 탈퇴 처리</h1>
		</div>
	</div>
	
	<div class="container">
			<h1 class="display-5"><%=result%></h1>
			<a href="welcome.jsp" class="btn btn-secondary"> 돌아가기 </a>
	</div>
</body>
</html>