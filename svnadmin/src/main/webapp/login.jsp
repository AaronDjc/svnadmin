<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.svnadmin.util.SpringUtils"%>
<%@page import="org.svnadmin.util.I18N"%>
<%@page import="org.svnadmin.service.UsrService"%>
<%@page import="java.io.*"%>
<!DOCTYPE html>
<html>
<%
response.setHeader("Cache-Control", "no-cache, post-check=0, pre-check=0");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "Thu, 01 Dec 1970 16:00:00 GMT");

String ctx = request.getContextPath();
UsrService usrService = SpringUtils.getBean(UsrService.BEAN_NAME);
//验证是否连接上数据库 @see Issue 12
try{
	usrService.validatConnection();
}catch(Exception e){
	StringWriter sWriter = new StringWriter();
	PrintWriter pWriter = new PrintWriter(sWriter);
	e.printStackTrace(pWriter);
	out.println("Could not connect to database."
			+"<br>连接数据库失败!请确认数据库已经正确建立,并正确配置WEB-INF/jdbc.properties连接参数"
			+"<br><br><div style='color:red;'>" +sWriter.toString()+"</div>");
	return;
}
%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title><%=I18N.getLbl(request, "login.title", "SVN ADMIN 登录")%></title>
	<link rel="stylesheet" href="<%=ctx%>/resources/css/main.css"  type="text/css" media="screen"/>
	<link rel="shortcut icon" href="http://i.ciwong.com/favicon.ico"/>	
</head>
<body>
<div class="switcher">
        <div class="switcher-button"></div>
</div>
<%
	String errorMsg = (String)request.getAttribute(org.svnadmin.Constants.ERROR);
	if(errorMsg != null){
%>
<div class="notice outer">
	<div class="note note-danger">
	<button type="button" class="close">×</button>
	<strong>错误!</strong>
	<%=errorMsg%>
	</div>
</div>
<%}%>
<%
if(usrService.getCount() == 0){
%>
<div class="notice outer">
	<div class="note">
		<strong>Info:</strong><%=I18N.getLbl(request,"login.info.setadmin","欢迎使用SVN ADMIN,第一次使用请设置管理员帐号和密码.") %>
	</div>
</div>
<%}%>
<div class="login-wrapper">
	<div class="login">
        <a href="#" title="" class="login-logo"><img src="<%=ctx%>/resources/images/login-logo.png" alt=""></a>
        <!-- Login block -->        
        <div class="well">
            <div class="navbar">
                <div class="navbar-inner">
                    <h6><i class="font-user"></i>Login page</h6>
                    <div class="nav pull-right">
                        <a href="#" class="dropdown-toggle just-icon" data-toggle="dropdown"><i class="font-cog"></i></a>                        
                    </div>
                </div>
            </div>
            
            <form action="<%=ctx%>/login" class="row-fluid" method="post">
                <div class="control-group">
                    <label class="control-label">用户:</label>
                    <div class="controls"><input class="span12" type="text" id="usr" name="usr" value="<%=request.getParameter("usr")==null?"":request.getParameter("usr")%>" placeholder="username"></div>
                </div>
                
                <div class="control-group">
                    <label class="control-label">密码:</label>
                    <div class="controls"><input class="span12" type="password" id="psw" name="psw" value="<%=request.getParameter("psw")==null?"":request.getParameter("psw")%>" placeholder="password"></div>
                </div>

                <div class="login-btn"><input type="submit" value="登录" class="btn btn-info btn-block btn-large"></div>
            </form>
        </div>
        <!-- /login block -->

    </div>
</div>
</body>
</html>