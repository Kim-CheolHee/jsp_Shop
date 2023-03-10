<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>메인 페이지</title>
</head>
<body>
	<%!
		String greeting = "웹 쇼핑몰에 오신 것을 환영합니다";
		String tagline = "Welcome to web market";
	%>
	
	<jsp:include page="menu.jsp"/>	
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3"><%=greeting%></h1>
		</div>
	</div>
	
	<div class="container">
		<div class="text-center">
			<h3><%=tagline%></h3>
			
			<%
				response.setIntHeader("Refresh", 1);
				Date day = new Date();
				int hour = day.getHours();
				int minute = day.getMinutes();
				int second = day.getSeconds();
				
				String am_pm;
				
				if(hour<12) {
					am_pm="AM";
					
				} else if(hour==12){
					am_pm="PM";
					
				} else {
					hour=hour-12;
					am_pm="PM";
				}
				
				String nowTime = hour + ":" + minute + ":" + second + " " + am_pm; 
				out.println("현재 접속 시간 " + nowTime);
			%>
			
		</div>
		<hr>
	</div>
	
	<jsp:include page="footer.jsp"/>
	
</body>
</html>