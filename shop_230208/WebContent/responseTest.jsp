<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>
<%@page import="java.net.*" %>
<%
    // Define the IP address and port of the Arduino
    String ip = "192.168.0.166";
    int port = 80;

    // Check whether the form was submitted
    if (request.getParameter("submit") != null) {
        // Define the parameter values to send
        int redValue = Integer.parseInt(request.getParameter("red"));
        int greenValue = Integer.parseInt(request.getParameter("green"));
        int blueValue = Integer.parseInt(request.getParameter("blue"));

        // Construct the URL and parameter string
        String url = "http://" + ip + ":" + port + "/";
        String params = "red=" + redValue + "&green=" + greenValue + "&blue=" + blueValue;

        // Create a connection to the Arduino and send the parameters
        URLConnection conn = new URL(url + "?" + params).openConnection();
        try{
	        conn.getInputStream();
	        out.print("data 전송 완료");
        } catch (Exception e){
        	out.print(e);
        } finally {
	     	// Redirect to the current page to refresh it
    	    response.sendRedirect(request.getRequestURI());
    	    out.print("페이지 새로고침");
        }
    }
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
            <h1 class="display-3">LED Control</h1>
        </div>
    </div>
    
    <div class="container">
        <h1>LED Control</h1>
        <form method="get" action="<%=request.getRequestURI()%>">
             Red: <input type="number" name="red" value="<%=request.getParameter("red") != null ? request.getParameter("red") : 0 %>"><br>
            Green: <input type="number" name="green" value="<%=request.getParameter("green") != null ? request.getParameter("green") : 0 %>"><br>
            Blue: <input type="number" name="blue" value="<%=request.getParameter("blue") != null ? request.getParameter("blue") : 0 %>"><br>
            <input type="submit" name="submit" value="Submit">
        </form>
    </div>
</body>
</html>