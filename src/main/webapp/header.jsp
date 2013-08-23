<%@ page contentType="text/html;charset=UTF-8" errorPage="error.jsp"%>
<%@page import="org.svnadmin.entity.Usr"%>
<%@page import="org.svnadmin.util.*"%>
<%@page import="org.svnadmin.servlet.BaseServlet"%>
<%
response.setHeader("Cache-Control", "no-cache, post-check=0, pre-check=0");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "Thu, 01 Dec 1970 16:00:00 GMT");
String ctx = request.getContextPath();
Usr _usr = BaseServlet.getUsrFromSession(request);
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width" />
    <title><%=I18N.getLbl(request,"main.title","SVN ADMIN")%></title>
    <link rel="shortcut icon" href="http://i.ciwong.com/favicon.ico"/>	
    <%if(_usr == null){%>
	<script type="text/javascript">
		alert("超时或未登录");	
		top.location="login.jsp";
	</script>
	<%
	return;
	}%>
    <link rel="stylesheet" href="<%=ctx%>/resources/css/main.css"  type="text/css" media="screen"/>
    <script type="text/javascript" src="<%=ctx%>/resources/jquery-1.7.min.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/jquery_ui_custom.js"></script>
	
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/charts/excanvas.min.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/charts/jquery.sparkline.min.js"></script>
	
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/forms/jquery.tagsinput.min.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/forms/jquery.inputlimiter.min.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/forms/jquery.maskedinput.min.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/forms/jquery.autosize.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/forms/jquery.ibutton.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/forms/jquery.dualListBox.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/forms/jquery.validate.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/forms/jquery.uniform.min.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/forms/jquery.select2.min.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/forms/jquery.cleditor.js"></script>
	
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/uploader/plupload.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/uploader/plupload.html4.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/uploader/plupload.html5.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/uploader/jquery.plupload.queue.js"></script>
	
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/wizard/jquery.form.wizard.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/wizard/jquery.form.js"></script>
	
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/ui/jquery.collapsible.min.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/ui/jquery.timepicker.min.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/ui/jquery.jgrowl.min.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/ui/jquery.pie.chart.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/ui/jquery.fullcalendar.min.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/ui/jquery.elfinder.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/ui/prettify.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/ui/jquery.fancybox.js"></script>
	
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/tables/jquery.dataTables.min.js"></script>
	
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/bootstrap/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/bootstrap/bootstrap-bootbox.min.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/bootstrap/bootstrap-progressbar.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/bootstrap/bootstrap-colorpicker.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/moment/moment.js"></script>
	<script type="text/javascript" src="<%=ctx%>/resources/js/functions/custom.js"></script>
</head>
<body>
<!-- Top nav -->
<div id="top">
    <div class="top-wrapper">
        <a href="index.html" title=""><img src="<%=ctx%>/resources/images/logo.png" class="logo" alt=""></a>
        <ul class="topnav">
            <li class="topuser"> 
                <a title="" data-toggle="dropdown"><img src="<%=ctx%>/avatar?act=view&name=<%=_usr.getUsr() %>" style="width:30px;height" onerror="this.src='<%=ctx%>/resources/images/user.png';"><span><%=_usr.getUsr()%></span><i class="caret"></i></a>
                <ul class="dropdown-menu">
                    <li><a href="<%=ctx%>/profile" title=""><span class="user-profile"></span>我的资料</a></li>
                    <li><a href="<%=ctx%>/avatar" title=""><span class="user-profile"></span>修改头像</a></li>
                    <li><a href="<%=ctx%>/password" title=""><span class="user-profile"></span>修改密码</a></li>
                    <li><a href="<%=ctx%>/login?act=logout" title=""><span class="user-logout"></span>退出</a></li>
                </ul>
            </li>
            <li><a href="#" title=""><b class="settings"></b></a></li>
            <li><a href="<%=ctx%>/login?act=logout" title=""><b class="logout"></b></a></li>
        </ul>
    </div>
</div>
<!-- /top nav -->

<!-- Main wrapper -->
<div class="wrapper">
	<!-- Left sidebar -->
    <div class="sidebar" id="left-sidebar">
    		<ul class="navigation standard">
    		<!-- standard nav -->
            <li><a href="#" title="" class="expand subClosed"><span class="menu-dashboard"></span>管理首页</a></li>
            <li><a href="<%=ctx%>/user" title=""><span class="menu-icons"></span>用户</a></li>
            <li class="active"><a href="<%=ctx%>/project" title=""><span class="menu-icons"></span>项目</a></li> 
			<li><a href="<%=ctx%>/i18n" title=""><span class="menu-icons"></span>语言</a></li>   
            <!-- /standard nav -->            
    		</ul>
    </div>
    <!-- /Left sidebar -->
    
	<!-- /left sidebar -->
	
	<!-- Main content -->	
	<div class="content">
	
	    <%
		String errorMsg = (String)request.getAttribute(org.svnadmin.Constants.ERROR);
		if(errorMsg != null){
		%>
			<div class="notice outer">
				<div class="note note-danger">
					<button type="button" class="close">×</button>
					<strong>错误!</strong><%=errorMsg%>
				</div>
			</div>
		<%}%>

		

