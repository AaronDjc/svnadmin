<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%
String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width" />
	<title>错误</title>
	<link rel="stylesheet" href="<%=ctx%>/resources/css/main.css"  type="text/css" media="screen"/>
</head>
<body>
<div>
<div class="outer">
	<div class="inner">	
		<div class="well">
			<%
			StringWriter sWriter = new StringWriter();
			PrintWriter pWriter = new PrintWriter(sWriter);
			exception.printStackTrace(pWriter);
			%>
			<code>
				<%=sWriter.toString()%>
			</code>
		</div>
	</div>
</div>
</body>
</html>