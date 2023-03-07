<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.*"%>
<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String url = application.getRealPath("/upload");  
	int maxSize = 5 * 1024 * 1024;
	
	
	MultipartRequest mr = new MultipartRequest(request,url,maxSize,"utf-8",new DefaultFileRenamePolicy());
	String id = mr.getParameter("id");
	String password = mr.getParameter("password");
	String name = mr.getParameter("name");
	String filename = mr.getFilesystemName("photoImage");
	
	JDBConnect jdbc = new JDBConnect();
		
	
	String sql = "select * from member";
	PreparedStatement psmt = jdbc.con.prepareStatement(sql);
	ResultSet rs = psmt.executeQuery();
	
	String result="";
	while(rs.next()) {
		String id2 = rs.getString(1);
				
		if(id.equals(id2)) {
			result="기존회원";
			RequestDispatcher rd 
			= request.getRequestDispatcher("addmember.jsp?error=1");
			rd.forward(request, response);
			break;
		} 
	}
	
	if(result=="") {	
		String sql2 = "insert into member values(?,?,?,?)";
		PreparedStatement psmt2 = jdbc.con.prepareStatement(sql2);
		psmt2.setString(1, id);
		psmt2.setString(2, password);
		psmt2.setString(3, name);
		psmt2.setString(4, filename);
		psmt2.executeUpdate();
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
			<h1 class="display-3">회원 가입</h1>
		</div>
	</div>
	
	<div class="container">
			<h1 class="display-5"><%=name%>님 회원가입을 환영합니다!!</h1>
	</div>
</body>
</html>