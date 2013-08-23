<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@include file="header.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%!

public String renderHtml(String id,String basePath,String input)
{
	String outinput="";
	try {
	outinput = input;
	}catch(Exception e)
	{
		System.out.println("解码错误!");
	}
	
	String uc_api =basePath+"avatar";

	String urlCameraFlash = "/svnadmin/resources/swf/camera.swf?nt=1&inajax=1&appid=1&input="+input+"&uploadSize=200&ucapi="+uc_api;
	urlCameraFlash = "<script type=\"text/javascript\" src=\"/svnadmin/resources/js/functions/common.js\"></script><script type=\"text/javascript\">document.write(AC_FL_RunContent(\"width\",\"450\",\"height\",\"253\",\"scale\",\"exactfit\",\"src\",\""+urlCameraFlash+"\",\"id\",\"mycamera\",\"name\",\"mycamera\",\"quality\",\"high\",\"bgcolor\",\"#ffffff\",\"wmode\",\"transparent\",\"menu\",\"false\",\"swLiveConnect\",\"true\",\"allowScriptAccess\",\"always\"));</script>";

	return urlCameraFlash;
}
%>
<div class="outer">
	<div class="inner">
		<ul class="breadcrumb">
             <li><a href="#"><i class="font-home"></i>Home</a> <span class="divider">/</span></li>
             <li class="active">修改头像</li>
        </ul>
		<div class="body">	
			<div class="tabbable">
        		<ul class="nav nav-tabs">
                     <li><a href="<%=ctx%>/profile">基本资料</a></li>
                     <li class="active"><a href="<%=ctx%>/avatar">头像照片</a></li>
                </ul>
                <div class="tab-content">
						<script type="text/javascript">
							var avatar_edit = function(){
								$("#avatar-view-div").hide();
								$("#avatar-edit-div").show();
							}
							var updateavatar=function(){
								$("#avatar-view-div").show();
								$("#avatar-edit-div").hide();
								
								var img1= $("#big_img").attr("src")+"&"+Math.round(Math.random() * 10000);
								var img2= $("#mid_img").attr("src")+"&"+Math.round(Math.random() * 10000);
								var img3= $("#small_img").attr("src")+"&"+Math.round(Math.random() * 10000);
			
								$("#big_img").attr("src",img1);
								$("#mid_img").attr("src",img2);
								$("#small_img").attr("src",img3);
							}
						</script>
						<div id="avatar-view-div" class="avatar-edit-grid clearfix">
							<div class="col col-1">
								<div class="hd"><h4>大头像：</h4></div>
								<div><img id="big_img" src="<%=ctx%>/avatar?act=view&name=<%=_usr.getUsr() %>&type=big"/></div>
							</div>
							<div class="col col-2">
								<div class="hd"><h4>小头像：</h4></div>
								<div class="bd clearfix">
									<div class="col col-21"><img id="mid_img" src="<%=ctx%>/avatar?act=view&name=<%=_usr.getUsr() %>&type=middle"/></div>
									<div class="col col-21"><img id="small_img" src="<%=ctx%>/avatar?act=view&name=<%=_usr.getUsr() %>&type=small"/></div>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="avatar-edit-actions">
								<button class="btn btn-success" type="button" onclick="avatar_edit()">修改头像</button>
							</div>
						</div>
						<div id="avatar-edit-div" class="control-group" style="display:none;">
						<%
						out.print(renderHtml("5",(String)request.getAttribute("basePath"),"avatar@"+_usr.getUsr()));
						%>
						</div>
					</div>
				</div>
			</div>
	</div>
</div>
<%@include file="footer.jsp"%>