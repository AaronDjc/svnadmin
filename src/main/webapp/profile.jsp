<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.svnadmin.Constants"%>
<%@include file="header.jsp"%>
<% 
org.svnadmin.entity.Usr entity = (org.svnadmin.entity.Usr)request.getAttribute("entity");
%>
<div class="outer">
	<div class="inner">
		<ul class="breadcrumb">
             <li><a href="#"><i class="font-home"></i>Home</a> <span class="divider">/</span></li>
             <li class="active">我的资料</li>
        </ul>
        <div class="body">
        	<div class="tabbable">
        		<ul class="nav nav-tabs">
                     <li class="active"><a href="<%=ctx%>/profile">基本资料</a></li>
                     <li><a href="<%=ctx%>/avatar">头像照片</a></li>
                </ul>
                <div class="tab-content">
					<div class="well">
						<div class="row-fluid form-horizontal">
							<div class="control-group">
								<span class="control-label align-right">用户名:</span>
								<div class="controls"><%=entity.getUsr()%></div>
							</div>
							<div class="control-group">
								<span class="control-label align-right">姓名:</span>
								<div class="controls">
									<input type="text" class="input-medium" name="oldpwd" value="<%=entity.getUsrName()%>"/>
								</div>
							</div>
							<div class="control-group">
								<span class="control-label align-right">角色:</span>
								<div class="controls">
										 <select name="select2" class="style">
			                                 <option value="">选择角色</option>
			                                 <option value="<%=Constants.USR_ROLE_ADMIN%>">Admin</option>
			                             </select>
								</div>
							</div>
							<div class="control-group">
								<span class="control-label align-right">Email:</span>
								<div class="controls input-append">
									<input type="text" placeholder=".input-append" value="<%=entity.getUsr()%>">
									<span class="add-on">@ciwong.com</span>
								</div>
							</div>
		
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="footer.jsp"%>