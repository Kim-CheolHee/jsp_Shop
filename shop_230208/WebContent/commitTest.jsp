<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="common.JDBConnect"%>
<%@page import="java.sql.*"%>
<%
	PreparedStatement psmt;
	ResultSet rs;
  
	request.setCharacterEncoding("utf-8");

	String TDSVALUE = request.getParameter("TDS");
	String WATERVALUE = request.getParameter("WL");
	String PHVALUE = request.getParameter("PH");
	String TEMPVALUE = request.getParameter("TMP");
	String DETECTVALUE = request.getParameter("MT");
	
	JDBConnect jdbc = new JDBConnect();
	
	if(TDSVALUE != null){
		String Iquery = "INSERT INTO TDS(TDSVALUE) VALUES(?)";
		psmt = jdbc.con.prepareStatement(Iquery);
		psmt.setString(1, TDSVALUE);
		psmt.executeUpdate();
	}
	if(WATERVALUE != null){
		String Iquery = "INSERT INTO WATERLEVEL(WATERVALUE) VALUES(?)";
		psmt = jdbc.con.prepareStatement(Iquery);
		psmt.setString(1, WATERVALUE);
		psmt.executeUpdate();
	}
	if(PHVALUE != null){
		String Iquery = "INSERT INTO PH(PHVALUE) VALUES(?)";
		psmt = jdbc.con.prepareStatement(Iquery);
		psmt.setString(1, PHVALUE);
		psmt.executeUpdate();
	}
	if(TEMPVALUE != null){
		String Iquery = "INSERT INTO TEMPERATURE(TEMPVALUE) VALUES(?)";
		psmt = jdbc.con.prepareStatement(Iquery);
		psmt.setString(1, TEMPVALUE);
		psmt.executeUpdate();
	}
	if(DETECTVALUE != null){
		String Iquery = "INSERT INTO MOTION(DETECTVALUE) VALUES(?)";
		psmt = jdbc.con.prepareStatement(Iquery);
		psmt.setString(1, DETECTVALUE);
		psmt.executeUpdate();
	}
	
	String Squery1 = "SELECT TDSVALUE FROM TDS ORDER BY NUM DESC LIMIT 1";
	psmt = jdbc.con.prepareStatement(Squery1);
	rs = psmt.executeQuery();
	String RSTDSVALUE = "";
	if (rs.next()) {
		RSTDSVALUE = rs.getString("TDSVALUE");
	}
	String Squery2 = "SELECT WATERVALUE FROM WATERLEVEL ORDER BY NUM DESC LIMIT 1";
	psmt = jdbc.con.prepareStatement(Squery2);
	rs = psmt.executeQuery();
	String RSWATERVALUE = "";
	if (rs.next()) {
		RSWATERVALUE = rs.getString("WATERVALUE");
	}
	String Squery3 = "SELECT PHVALUE FROM PH ORDER BY NUM DESC LIMIT 1";
	psmt = jdbc.con.prepareStatement(Squery3);
	rs = psmt.executeQuery();
	String RSPHVALUE = "";
	if (rs.next()) {
		RSPHVALUE = rs.getString("PHVALUE");
	}
	String Squery4 = "SELECT TEMPVALUE FROM TEMPERATURE ORDER BY NUM DESC LIMIT 1";
	psmt = jdbc.con.prepareStatement(Squery4);
	rs = psmt.executeQuery();
	String RSTEMPVALUE = "";
	if (rs.next()) {
		RSTEMPVALUE = rs.getString("TEMPVALUE");
	}
	String Squery5 = "SELECT DETECTVALUE FROM MOTION ORDER BY NUM DESC LIMIT 1";
	psmt = jdbc.con.prepareStatement(Squery5);
	rs = psmt.executeQuery();
	String RSDETECTVALUE = "";
	if (rs.next()) {
		RSDETECTVALUE = rs.getString("DETECTVALUE");
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
		<h3>아두이노에서 데이터 받기</h3>
		<h3>TDSVALUE : <%= RSTDSVALUE %></h3>
		<h3>WATERVALUE : <%= RSWATERVALUE %></h3>
		<h3>PHVALUE : <%= RSPHVALUE %></h3>
		<h3>TEMPVALUE : <%= RSTEMPVALUE %></h3>
		<h3>DETECTVALUE : <%= RSDETECTVALUE %></h3>
	</div>
</body>
</html>