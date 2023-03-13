<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="common.JDBConnect"%>
<%@page import="java.sql.*"%>
<%
	PreparedStatement psmt;
	ResultSet rs;

	request.setCharacterEncoding("utf-8");

	String data = request.getParameter("data");
	String red = request.getParameter("red");
	String green = request.getParameter("green");
	String blue = request.getParameter("blue");
	
	JDBConnect jdbc = new JDBConnect();
	if(data != null){
		String Iquery = "INSERT INTO testtable(data) VALUES(?)";
		psmt = jdbc.con.prepareStatement(Iquery);
		psmt.setString(1, data);
		psmt.executeUpdate();
	}
	if(red != null && green != null && blue != null){
		String Iquery = "INSERT INTO rgb(red, green, blue) VALUES(?, ?, ?)";
		psmt = jdbc.con.prepareStatement(Iquery);
		psmt.setString(1, red);
		psmt.setString(2, green);
		psmt.setString(3, blue);
		psmt.executeUpdate();
	}
	
	String Squery1 = "SELECT data FROM testtable ORDER BY id DESC LIMIT 1";
	psmt = jdbc.con.prepareStatement(Squery1);
	rs = psmt.executeQuery();

	// Retrieve the value from the result set
	String value1 = "";
	if (rs.next()) {
	    value1 = rs.getString("data");
	}
	
	String Squery2 = "SELECT * FROM rgb ORDER BY num DESC LIMIT 1";
	psmt = jdbc.con.prepareStatement(Squery2);
	rs = psmt.executeQuery();

	// Retrieve the value from the result set
	String valueRed = "";
	String valueGreen = "";
	String valueBlue = "";
	if (rs.next()) {
		valueRed = rs.getString("red");
		valueGreen = rs.getString("green");
		valueBlue = rs.getString("blue");
	}

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
		<h3>아두이노에서 데이터 받기 : <%= value1 %></h3>
		<h3>red : <%= valueRed %></h3>
		<h3>green : <%= valueGreen %></h3>
		<h3>blue : <%= valueBlue %></h3>
	</div>
</body>
</html>