<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="header.jsp"%>
<% 
org.svnadmin.entity.Usr entity = (org.svnadmin.entity.Usr)request.getAttribute("entity");
%>

<div class="outer">
	<div class="inner">
		<ul class="breadcrumb">
             <li><a href="#"><i class="font-home"></i>Home</a> <span class="divider">/</span></li>
             <li class="active">修改密码</li>
        </ul>
		<div class="row-fluid body">
			<div>
			<form class="form-horizontal"  action="<%=ctx%>/password" method="post" onsubmit="return checkForm(this);">
				<fieldset>
					<div class="well">
					<div class="control-group">
						<label class="control-label align-right">原密码:<span class="req">*</span></label>
						<div class="controls">
							<input type="password" class="span12" name="oldpwd" value="">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label align-right">新密码:<span class="req">*</span></label>						
						<div class="controls">
							<input type="password" class="span12" name="newpwd" value="">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label align-right">确认密码:<span class="req">*</span></label>
						<div class="controls">
							<input type="password" class="span12" name="repwd" value="">
						</div>
					</div>
					<div class="form-actions align-center">
						<input type="hidden" name="usr" value="<%=entity.getUsr()%>">
						<button type="submit" class="btn btn-primary"><%=I18N.getLbl(request,"pjgr.btn.submit","提交") %></button>
					</div>
					</div>
				</fieldset>
			</form>
			</div>
		</div>
	</div>
</div>
<%@include file="footer.jsp"%>