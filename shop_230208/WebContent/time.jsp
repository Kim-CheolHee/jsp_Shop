<%@ page import="java.io.*, java.net.*" %>
<%
// get the time parameter from the Arduino request
String time = request.getParameter("time");

// process the time parameter (e.g. store it in a database, display it on a web page, etc.)
// ...

// send a response back to the Arduino
response.setContentType("text/plain");
PrintWriter outWriter = response.getWriter();
out.println("Received time: " + time);
%>