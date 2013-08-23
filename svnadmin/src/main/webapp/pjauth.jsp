<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.svnadmin.Constants"%>
<%@page import="org.svnadmin.util.I18N"%>
<%
String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<script src="<%=ctx%>/resources/jquery-1.7.min.js" type="text/javascript"></script>
		<script src="<%=ctx%>/resources/svnadmin.js"></script>
		<link rel="stylesheet" href="<%=ctx%>/resources/css/main.css" type="text/css" media="screen" />
		
			<script type="text/javascript" src="<%=ctx%>/resources/js/plugins/forms/jquery.uniform.min.js"></script>
		<script type="text/javascript" src="<%=ctx%>/resources/js/functions/custom.js"></script>
		<style type="text/css">
			* {padding:0;margin:0;}
		</style>
		<script type="text/javascript">
		$(function(){
		    //移到用户组右边
		    $('#group_add').click(function() {
		           //获取选中的选项，删除并追加给对方
		           $('#select3 option:selected').appendTo('#select4');
		    });
		    //移到用户组左边
		    $('#group_del').click(function() {
		           $('#select4 option:selected').appendTo('#select3');
		    });
		    //全部移到用户组右边
		    $('#group_add_all').click(function() {
		           //获取全部的选项,删除并追加给对方
		           $('#select3 option').appendTo('#select4');
		    });
		    //全部移到用户组左边
		    $('#group_del_all').click(function() {
		           $('#select4 option').appendTo('#select3');
		    });
		    
		    //移到用户右边
		    $('#user_add').click(function() {
		           //获取选中的选项，删除并追加给对方
		           $('#select1 option:selected').appendTo('#select2');
		    });
		    //移到用户左边
		    $('#user_del').click(function() {
		           $('#select2 option:selected').appendTo('#select1');
		    });
		    //全部移到用户右边
		    $('#user_add_all').click(function() {
		           //获取全部的选项,删除并追加给对方
		           $('#select1 option').appendTo('#select2');
		    });
		    //全部移到用户左边
		    $('#user_del_all').click(function() {
		           $('#select2 option').appendTo('#select1');
		    });
		    
		    //双击选项
		    $('#select1').dblclick(function(){     //绑定双击事件
		           //获取全部的选项,删除并追加给对方
		           $("option:selected",this).appendTo('#select2');     //追加给对方
		    });
		    //双击选项
		    $('#select2').dblclick(function(){
		           $("option:selected",this).appendTo('#select1');
		    });
		  //双击选项
		    $('#select3').dblclick(function(){     //绑定双击事件
		           //获取全部的选项,删除并追加给对方
		           $("option:selected",this).appendTo('#select4');     //追加给对方
		    });
		    //双击选项
		    $('#select4').dblclick(function(){
		           $("option:selected",this).appendTo('#select3');
		    });
		});
		
		function checkForm(f){
			if(f.elements["pj"].value==""){
				alert("<%=I18N.getLbl(request,"pjauth.error.pj","项目不可以为空") %>");
				f.elements["pj"].focus();
				return false;
			}
			if(f.elements["res"].value==""){
				alert("<%=I18N.getLbl(request,"pjauth.error.res","资源不可以为空") %>");
				f.elements["res"].focus();
				return false;
			}
			if(f.elements["grs"].value=="" && f.elements["usrs"].value==""){
				alert("<%=I18N.getLbl(request,"pjauth.error.grusr","请选择用户组或用户") %>");
				f.elements["grs"].focus();
				return false;
			}
			return true;
		}
		function onSetting(val){
			if(val==0){
				$("#box_setting").hide();
				$("#role_list").removeClass("span6");
			}else{
				$("#box_setting").show();
				$("#role_list").addClass("span6");
			}
		}
		</script>
</head>
<body class="inner" style="padding:0;margin:0;">
	<div class="wrapper">
		<%
		org.svnadmin.entity.PjAuth entity = (org.svnadmin.entity.PjAuth)request.getAttribute("entity");
		if(entity==null){
			entity=new org.svnadmin.entity.PjAuth();
		}
		%>
		<%-- error message --%>
		<%
		String errorMsg = (String)request.getAttribute(org.svnadmin.Constants.ERROR);
		if(errorMsg != null){
		%>
			<div style="color:red;"><%=I18N.getLbl(request,"sys.error","错误") %> <%=errorMsg%></div>
		<%}%>
		<div class="row-fluid">
		<div id="box_setting" class="span6 block well form-horizontal" style="">
			<div class="navbar"><div class="navbar-inner"><h5>设置权限</h5></div></div>
			<form name="pjauth" action="<%=ctx%>/pjauth" method="post" onsubmit="return checkForm(this);">	
			
			<div class="control-group">
                <div class="input-prepend input-append">
                	<span class="add-on">资源</span>
                	<input type="text" name="res" value="<%=entity.getRes()==null?"":entity.getRes()%>" class="span8">
					<select name="select2" class="style"  onchange="this.form.res.value=this.value">
	                              <option value=""><%=I18N.getLbl(request,"pjauth.res.select","选择资源") %></option>
						 <%
						 java.util.List<String> pjreslist = (java.util.List<String>)request.getAttribute("pjreslist");
						 for(int i=0;i<pjreslist.size();i++){
						 %>
						 <option value="<%=pjreslist.get(i)%>"><%=pjreslist.get(i)%></option>
						 <%
						 }
						 %>	
	                </select>              	
                </div>
            </div>
            <div class="control-group">
                <div class="input-prepend input-append">
                	<span class="add-on">权限</span>
					<select name="rw" class="style">
						<option value="" <%="".equals(entity.getRw())?"selected='selected'":""%> ><%=I18N.getLbl(request,"pjauth.rw.none","没有权限") %></option>
						<option value="r"<%="r".equals(entity.getRw())?"selected='selected'":""%>><%=I18N.getLbl(request,"pjauth.rw.r","可读") %></option>
						<option value="rw"<%="rw".equals(entity.getRw())?"selected='selected'":""%>><%=I18N.getLbl(request,"pjauth.rw.rw","可读可写") %></option>
	                </select>
                </div>                
            </div>
            <div class="control-group">
            <div class="well span6">
            	<div class="navbar"><div class="navbar-inner"><h5><%=I18N.getLbl(request,"pj_gr.gr","用户组") %></h5></div></div>				
				<div class="body">
					<div class="left-box">
							<select id="select3" multiple="multiple" class="multiple" style="height:180px;margin-top:0;">
								<%
								java.util.List<org.svnadmin.entity.PjGr> pjgrlist = (java.util.List<org.svnadmin.entity.PjGr>)request.getAttribute("pjgrlist");
								if(pjgrlist!=null){	
								for(int i = 0;i<pjgrlist.size();i++){
									org.svnadmin.entity.PjGr pjGr = pjgrlist.get(i);
								%>
								<option value="<%=pjGr.getGr()%>"><%=pjGr.getGr()%></option>
								<%}}%>
							</select>
					</div>
					<div class="dual-control" style="margin:30px 1px;left:45%;width:32px;">
							<button id="group_add" type="button" style="width:30px;" class="btn">&gt;</button><br/>
							<button id="group_add_all" type="button" style="width:30px;" class="btn">&gt;&gt;</button><br/>
							<button id="group_del" type="button" style="width:30px;" class="btn">&lt;</button><br/>
							<button id="group_del_all" type="button" style="width:30px;" class="btn">&lt;&lt;</button>
					</div>
					<div class="right-box">
							<select id="select4" name="grs" multiple="multiple" class="multiple" style="height:180px;margin-top:0;">
							</select>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			<div class="well span6">	
				    <div class="navbar"><div class="navbar-inner"><h5><%=I18N.getLbl(request,"usr.usr","用户") %></h5></div></div>
					<div class="body">
					<div class="left-box">
										<select id="select1" multiple="multiple" class="multiple" style="height:180px;margin-top:0;">
												<%
												java.util.List<org.svnadmin.entity.Usr> usrlist = (java.util.List<org.svnadmin.entity.Usr>)request.getAttribute("usrList");
												if(usrlist!=null){	
												for(int i = 0;i<usrlist.size();i++){
													org.svnadmin.entity.Usr usr = usrlist.get(i);
												%>
												<option value="<%=usr.getUsr()%>"><%=usr.getUsr()%></option>
												<%}}%>
										</select>
					</div>
					<div class="dual-control" style="margin:30px 1px;left:45%;width:32px;">
							<button id="user_add" type="button" style="width:30px;" class="btn">&gt;</button><br/>
							<button id="user_add_all" type="button" style="width:30px;" class="btn">&gt;&gt;</button><br/>
							<button id="user_del" type="button" style="width:30px;" class="btn">&lt;</button><br/>
							<button id="user_del_all" type="button" style="width:30px;" class="btn">&lt;&lt;</button>
					</div>
					<div class="right-box">
										<select id="select2" name="usrs" multiple="multiple" class="multiple" style="height:180px;margin-top:0;">
										</select>
					</div>
					<div class="clearfix"></div>
					</div>
			</div>
			</div>			
			<div class="form-actions align-center">	
					    <input type="hidden" name="act" value="save">
						<input type="hidden" name="pj" value="<%=request.getParameter("pj")%>">
						<button type="submit" class="btn btn-primary"><%=I18N.getLbl(request,"pjauth.btn.submit","保存") %></button>
						<button type="button" class="btn" onclick="onSetting(0)">取消</button>
				</div>			
			</form>
		</div>
		
		<div id="role_list" class="span6 well block">
			<div class="navbar">
	        	<div class="navbar-inner">
	            	<h5><i class="font-table"></i>权限列表</h5>
	            	<div class="nav pull-right">
                           <a href="javascript:;" onclick="onSetting(1)" class="just-icon"><i class="font-cog"></i></a>                               
                    </div>
	            </div>
	        </div>
			<div class="table-overflow">
				<table class="table table-striped">
				<thead>
					<tr>
						<th><%=I18N.getLbl(request,"sys.lbl.no","NO.") %></th>
						<th><%=I18N.getLbl(request,"pjauth.res","资源") %></th>
						<th><%=I18N.getLbl(request,"pj_gr.gr","用户组") %>/<%=I18N.getLbl(request,"usr.usr","用户") %></td>
						<th><%=I18N.getLbl(request,"pjauth.rw","权限") %></th>
						<th width="30"><%=I18N.getLbl(request,"pjauth.op.delete","删除") %></th>
					</tr>
				</thead>
				<tbody>
				<%
				java.util.List<org.svnadmin.entity.PjAuth> list = (java.util.List<org.svnadmin.entity.PjAuth>)request.getAttribute("list");
			
				if(list!=null){
				  for(int i = 0;i<list.size();i++){
					  org.svnadmin.entity.PjAuth pjAuth = list.get(i);
					%>
					<tr>
					<td><%=(i+1) %></td>
					<td><%=pjAuth.getRes() %></td>
					<td><%=pjAuth.getGr()==null?"":pjAuth.getGr() %><%=pjAuth.getUsr()==null?"":pjAuth.getUsr() %></td>
					<td>
						<% if("r".equals(pjAuth.getRw())){ %>
							<span class="text-info"><%=I18N.getLbl(request,"pjauth.rw.r","可读") %></span>
						<%}else if("rw".equals(pjAuth.getRw())){%>
							<span class="text-success"><%=I18N.getLbl(request,"pjauth.rw.rw","可读可写") %></span>
						<%}else{%>
							<span class="text-error"><%=I18N.getLbl(request,"pjauth.rw.none","没有权限") %></span>
						<%}%>
					</td>
					<td>
					<ul class="table-controls">
                          <li><a href="javascript:if(confirm('<%=I18N.getLbl(request,"pjauth.op.delete.confirm","确认删除?") %>')){del('<%=ctx%>/pjauth?pj=<%=pjAuth.getPj()%>&res=<%=pjAuth.getRes()%>&gr=<%=pjAuth.getGr()%>&usr=<%=pjAuth.getUsr()%>')}" class="btn red hovertip" title="删除"><i class="icon-remove-sign"></i></a></li>
                    </ul>
					</td>
				</tr>
					<%	
				}}
				%>
				</tbody>
				</table>
			</div>
	</div>
		</div>
	</div>
</body>
</html>