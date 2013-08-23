<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.svnadmin.util.I18N"%>
<%@page import="org.svnadmin.entity.*"%>
<%@page import="org.svnadmin.Constants"%>
<%@include file="header.jsp"%>

<%
//boolean hasAdminRight = (Boolean)request.getAttribute("hasAdminRight");
//boolean hasManagerRight = (Boolean)request.getAttribute("hasManagerRight");
%>

<%
//if(hasManagerRight){
Pj entity = (Pj)request.getAttribute("entity");
if(entity==null)entity=new Pj();
%>
<script>
function checkForm(f){
	if(f.elements["repository_owner"].value==""){
		alert("请选择项目组");
		f.elements["repository_owner"].focus();
		return false;
	}
	if(f.elements["repository_name"].value==""){
		alert("Repository Name 不可以为空");
		f.elements["repository_name"].focus();
		return false;
	}
	return true;
}
</script>
<div class="outer">
	<div class="inner">
		<ul class="breadcrumb">
             <li><a href="#"><i class="font-home"></i>Home</a> <span class="divider">/</span></li>
             <li class="active">创建项目</li>
        </ul>
        <div class="body">
		<form name="pj" action="<%=ctx%>/new" method="post" onsubmit="return checkForm(this);">
			<div class="row-fluid">
					<div class="control-group">
						<div class="controls owner-reponame clearfix">
							<dl class="owner form">
								<dt>Owner</dt>
								<dd>
									<select name="repository_owner" class="style">
		                                 <option value="">选择项目组</option>
		                                 <option value="base_center">基础平台中心项目</option>
		                                 <option value="iws">[IWS]作业平台中心项目</option>
		                                 <option value="sns">[SNS]SNS平台中心项目</option>
		                                 <option value="toa">[TOA]作业应用中心项目</option>
		                                 <option value="base">[BASE]WEB基础项目</option>
										 <option value="svn">[SVN]其他项目</option>   
		                        	</select>
								</dd>
							</dl>
							<span class="slash">/</span>
							<dl class="reponame form">
								<dt>Repository name</dt>
	                        	<dd><input type="text" name="repository_name" class="required" style="width:360px;" value="" onkeyup="value=value.replace(/[^_-A-Za-z0-9]/g,'')"/></dd>
	                        </dl>
						</div>
					</div>
					<div class="control-group">
						<span class="control-label align-right">Description:</span>
						<div class="controls">
							<input type="text" class="span6" name=repository_desc value=""/>	 
						</div>
					</div>
					<div class="control-group">
						<input type="checkbox" class="style" id="repository_init" name="repository_init" value="1" checked="checked"/>	
						<label for="repository_init">Initialize this repository</label> 
					</div>
					<div class="form-actions" style="padding:0 6px;">
						<button type="submit" class="btn btn-primary" style="line-height:18px;">Create repository</button>
					</div>
			</div>
		</form>
		</div>
	</div>
</div>
<%//}%>

<%@include file="footer.jsp"%>