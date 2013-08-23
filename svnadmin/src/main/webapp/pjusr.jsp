<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="org.svnadmin.util.I18N"%>
<%@include file="header.jsp"%>

<div class="notice outer">
	<div class="note">
		<strong>注意:</strong>这里设置的用户密码只对这个项目有效
	</div>
</div>

<div class="outer">
	<div class="inner">
		<ul class="breadcrumb">
             <li>
             <a href="<%=ctx%>/"><i class="font-home"></i>Home</a>
             <span class="divider">/</span> 
             <a href="<%=ctx%>/project"><%=I18N.getLbl(request,"pj.title","项目") %></a>
             <span class="divider">/</span> 
             <%=request.getParameter("pj")%>
             <span class="divider">/</span> 
             </li>
             <li class="active">用户管理</li>
        </ul>
		<div class="body">
		<%
		boolean hasManagerRight = (Boolean)request.getAttribute("hasManagerRight");
		org.svnadmin.entity.PjUsr entity = (org.svnadmin.entity.PjUsr)request.getAttribute("entity");
		if(entity==null)entity=new org.svnadmin.entity.PjUsr();
		%>
		<script>
		function checkForm(f){
			if(f.elements["pj"].value==""){
				alert("<%=I18N.getLbl(request,"pjusr.error.pj","项目不可以为空") %>");
				f.elements["pj"].focus();
				return false;
			}
			if(f.elements["usr"].value==""){
				alert("<%=I18N.getLbl(request,"pjusr.error.usr","用户不可以为空") %>");
				f.elements["usr"].focus();
				return false;
			}
			if(f.elements["psw"].value==""  && f.elements["newPsw"]!=null && f.elements["newPsw"].value==""){
				alert("<%=I18N.getLbl(request,"pjusr.error.psw","项目新密码不可以为空") %>");
				f.elements["psw"].focus();
				return false;
			}
			return true;
		}
		</script>
		
		<div class="row-fluid">
		<div class="span4 well form-horizontal">
		<div class="navbar"><div class="navbar-inner"><h5>设置独立密码</h5></div></div>
		<form name="pjusr" action="<%=ctx%>/pjusr" method="post" onsubmit="return checkForm(this);">
			<div class="control-group">
				<span class="control-label align-right">用户:</span>
                <div class="control">       
                	<%if(hasManagerRight){ %>         	
					<select name="usr" class="style">					
						 <option value=""><%=I18N.getLbl(request,"pjusr.usr.select","选择用户") %></option>
						 <%
						 List<Usr> usrList = (List<Usr>)request.getAttribute("usrList");
						 for(int i=0;i<usrList.size();i++){
							 Usr usr = usrList.get(i);
						 %>
						 <option value="<%=usr.getUsr()%>" <%=(usr.getUsr().equals(entity.getUsr()))?"selected='selected'":"" %>><%=usr.getUsr()%></option>
						 <%
						 }
						 %>	
					</select>
					 <%}else{ %>
					 <input type="hidden" name="usr" value="<%=entity.getUsr()==null?"":entity.getUsr()%>">
					 <%=entity.getUsr()==null?"":entity.getUsr()%>
					 <%} %>
                </div>                
            </div>
            <div class="control-group">
            	<span class="control-label align-right"><%=I18N.getLbl(request,"pjusr.psw.psw","项目新密码") %>:</span>
            	<div class="control">    
            		<input type="password" name="newPsw" value="">
            	</div>
            </div>
            <div class="form-actions align-center">	
					    <input type="hidden" name="act" value="save">
						<input type="hidden" name="pj" value="<%=request.getParameter("pj")%>">
						<input type="hidden" name="psw" value="<%=entity.getPsw()==null?"":entity.getPsw()%>">
						<button type="submit" class="btn btn-primary"><%=I18N.getLbl(request,"pjauth.btn.submit","保存") %></button>
						<button type="button" class="btn" onclick="onSetting(0)">取消</button>
			</div>	
		</form>
		</div>
		
		
		<%if(hasManagerRight){ %>
		<div class="span8">		
			<div class="navbar">
	        	<div class="navbar-inner">
	            	<h5><i class="font-table"></i>独立密码用户列表</h5>	            	
	            </div>
	        </div>
			<div class="table-overflow well">				
				<table class="table table-striped">		
					<thead>
						<tr>
							<th>NO.</th>
							<th><%=I18N.getLbl(request,"pj.pj","项目") %></th>
							<th><%=I18N.getLbl(request,"usr.usr","用户") %></th>
							<th><%=I18N.getLbl(request,"pjusr.psw.psw","项目新密码") %></th>
							<th><%=I18N.getLbl(request,"pjusr.op.delete","删除") %></th>
						</tr>
					</thead>
					<%
					java.util.List<org.svnadmin.entity.PjUsr> list = (java.util.List<org.svnadmin.entity.PjUsr>)request.getAttribute("list");
					%>
					<tfoot>
						<tr>
							<td colspan="5" class="table-footer">共<%=list.size() %>条记录</td>
						</tr>
					</tfoot>
					<tbody>
					<%
					if(list!=null){
					  for(int i = 0;i<list.size();i++){
						  org.svnadmin.entity.PjUsr pjUsr = list.get(i);
						%>
						<tr>
							<td><%=(i+1) %></td>
							<td><%=pjUsr.getPj() %></td>					
							<td><a href="<%=ctx%>/pjusr?act=get&pj=<%=pjUsr.getPj()%>&usr=<%=pjUsr.getUsr()%>"><%=pjUsr.getUsr() %></a></td>
							<td><%=pjUsr.getPsw() %></td>
							<td><a href="javascript:if(confirm('<%=I18N.getLbl(request,"pjusr.op.delete.confirm","确认删除?") %>')){del('<%=ctx%>/pjusr?&pj=<%=pjUsr.getPj()%>&usr=<%=pjUsr.getUsr()%>')}"><%=I18N.getLbl(request,"pjusr.op.delete","删除") %></a></td>
						</tr>
						<%	
					}}
					%>
					</tbody>
				</table>
			</div>
		</div>
		<%} %>
		</div>
		</div>
	</div>
</div>