<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Adding two numbers</title>
</head>
<body bgcolor="cyan">
	<% 
		int i = Integer.parseInt(request.getParameter("num1"));
		int j = Integer.parseInt(request.getParameter("num2"));
	
		int k = i + j;
 
		out.println("Output : " + k * k);
	%>
</body>
</html>