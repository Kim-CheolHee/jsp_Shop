<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="common.JDBConnect"%>
<%@page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");

	String data = request.getParameter("data");
	JDBConnect jdbc = new JDBConnect();
	if(data != null){
		String Iquery = "INSERT INTO testtable(data) VALUES(?)";
		PreparedStatement psmt = jdbc.con.prepareStatement(Iquery);
		psmt.setString(1, data);
		psmt.executeUpdate();
	}
	
	String Squery = "SELECT data FROM testtable ORDER BY id DESC LIMIT 1";
	PreparedStatement psmt = jdbc.con.prepareStatement(Squery);
	ResultSet rs = psmt.executeQuery();

	// Retrieve the value from the result set
	String value = "";
	if (rs.next()) {
	    value = rs.getString("data");
	}

	out.print("Most recent value: " + value);
	
	jdbc.close();
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
<script src="resources/js/validation.js" type="text/javascript"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">연동 하기</h1>
		</div>
	</div>
	
	<div class="container">
		<h2>GitHub에서 이클립스로 clone</h2>
		<h2>수정 후 다시 commit & push</h2>
		<h2>aws ubuntu에서 pull 후 톰캣으로 컴파일!</h2>
		<h2>아두이노에서 데이터 받기 : <%= value %></h2>
	</div>
</body>
</html>