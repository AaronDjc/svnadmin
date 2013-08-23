<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.svnadmin.Constants"%>
<%@page import="org.svnadmin.util.I18N"%>
<%@page import="org.svnadmin.util.list.PagedList" %>
<%@page import="java.util.*" %>
<%@include file="header.jsp"%>
<div class="clear"></div>
<%
boolean hasAdminRight = (Boolean)request.getAttribute("hasAdminRight");
org.svnadmin.entity.Usr entity = (org.svnadmin.entity.Usr)request.getAttribute("entity");
if("add".equals(request.getParameter("act"))){
	entity=new org.svnadmin.entity.Usr();
}
if(entity!=null){
%>
<div class="content-box column-r20">
<div class="content-box-header">
	<h3><%=I18N.getLbl(request,"usr.title","用户管理") %></h3>
</div>
<div class="content-box-content">
<script type="text/javascript">
function checkForm(f){
	if(f.elements["usr"].value==""){
		alert("<%=I18N.getLbl(request,"usr.error.usr","用户不可以为空") %>");
		f.elements["usr"].focus();
		return false;
	}
	if(f.elements["psw"].value==""  && f.elements["newPsw"]!=null && f.elements["newPsw"].value==""){
		alert("<%=I18N.getLbl(request,"usr.error.psw","密码不可以为空") %>");
		f.elements["psw"].focus();
		return false;
	}
	return true;
}
</script>
<form name="usr" action="<%=ctx%>/user" method="post" onsubmit="return checkForm(this);">
	<p>
           <label class="label"><%=I18N.getLbl(request,"usr.usr","用户") %>：</label>
           <%if(hasAdminRight){ %>
           <input type="text" name="usr"  class="text-input medium-input" value="<%=entity.getUsr()==null?"":entity.getUsr()%>" onkeyup="value=value.replace(/[^.@_\-A-Za-z0-9*]/g,'')"/>
           <%}else{ %>
           <%=entity.getUsr()==null?"":entity.getUsr()%>
		   <%} %>
    </p>
    <p>
    	<label class="label"><%=I18N.getLbl(request,"usr.psw","密码") %>：</label>
    	<input type="password" name="newPsw" value="" class="text-input medium-input">
		<input type="hidden" name="psw" value="<%=entity.getPsw()==null?"":entity.getPsw()%>">
    </p>
    <%if(hasAdminRight){ %>
    <p>
    	<label class="label"><%=I18N.getLbl(request,"usr.role","角色") %>：</label>
    	<select name="role">
			<option value=""><%=I18N.getLbl(request,"usr.role.select","选择角色") %></option>
			<option value="<%=Constants.USR_ROLE_ADMIN%>" <%=Constants.USR_ROLE_ADMIN.equals(entity.getRole())?"selected='selected'":""%>>admin</option>
		</select>
    </p>
    <%} %>
    <p style="padding-left:42px;">            
           <input type="submit" class="button" value="<%=I18N.getLbl(request,"pj.btn.submit","保存") %>"/>
           <input type="hidden" name="act" value="save"/>
    </p>	
</form>
</div>
</div>
<%} %>
<%if(hasAdminRight){ %>
<div class="outer">
	<div class="inner">	
		<div class="well">
					<div class="navbar">
			        	<div class="navbar-inner">
			            	<h5><i class="font-table"></i>用户列表</h5>
			            	<div class="nav pull-right">
                                        <a href="#" class="dropdown-toggle just-icon" data-toggle="dropdown"><i class="font-cog"></i></a>
                                        <ul class="dropdown-menu pull-right">
                                            <li><a href="<%=ctx%>/user?act=add"><i class="font-plus"></i>添加用户</a></li>
                                            <li><a href="<%=ctx%>/user"><i class="font-refresh"></i>刷新</a></li>
                                        </ul>
                             </div>
			            </div>
			        </div>
					<div class="table-overflow">
						<table class="table table-bordered table-block table-gradient table-hover">
							<thead>
									<tr>
										<th width="40"><center>#</center></th>
										<th width="40">face</th>
										<th>Description</th>
										<th>Group</th>
										<th>Email</th>
										<th width="60">Actions</th>
									</tr>									
							</thead>
							<%  PagedList<Usr> paged = (PagedList<Usr>)request.getAttribute("paged"); %>
							<tfoot>
									<tr>
										<td colspan="6" class="table-footer">
											<div class="pagination">
			                                    <ul>
			                                        <%if(paged.getCurrentPageIndex()>1){ %>
			                                        <li><a href="<%=ctx%>/user?page=<%=paged.getCurrentPageIndex()-1%>">上一页</a></li>
			                                        <%}%>
			                                        <% for(int i:(List<Integer>)paged.getPageList()){%>
			                                        <%if(i==paged.getCurrentPageIndex()) {%>
			                                        <li class="active"><a href="#"><%=i %></a></li>
			                                        <%}else{ %>
			                                        <li><a href="<%=ctx%>/user?page=<%=i %>"><%=i %></a></li>			                                        
			                                        <%}%>
			                                        <%}%>
			                                        <%if(paged.getCurrentPageIndex()<paged.getTotalPageCount()){ %>
			                                        <li><a href="<%=ctx%>/user?page=<%=paged.getCurrentPageIndex()+ 1%>">下一页</a></li>
			                                        <%}%>
			                                    </ul>
			                                </div>
										</td>
									</tr>
							</tfoot>
							<tbody>
							<%
							
							List<org.svnadmin.entity.Usr> list = paged.getList();
							int start = paged.getStartRecordIndex();
							if(list!=null){
								int no = start;	  
								for(int i = 0;i<list.size();i++){
								  org.svnadmin.entity.Usr usr = list.get(i);
								  if("*".equals(usr.getUsr())){
									  continue;
								  }
								%>
								<tr>
										<td class="align-center"><%=no++%></td>
										<td>
											<div class="ds-avatar">
											<img src="<%=ctx%>/avatar?act=view&name=<%=usr.getUsr() %>" alt="">
											</div>
										</td>
										<td class="align-left">
											<strong><%=usr.getUsr() %></strong>
											<br>
											<i><%=(usr.getRole()==null || usr.getRole()=="")?"Developer":usr.getRole() %></i>											
										</td>
										<td>
											作业应用平台
										</td>
										<td>
											<%=usr.getUsr() %>@ciwong.com
										</td>
				                        <td>
				                        	<ul class="table-controls">
                                                    <li><a href="<%=ctx%>/user?act=get&usr=<%=usr.getUsr()%>" class="btn hovertip" title="编辑"><i class="icon-edit"></i></a> </li>
                                                    <li><a href="#" class="btn hovertip" title="删除"><i class="icon-remove-sign"></i></a></li>
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
<%} %>
<div class="clear"></div>
<%@include file="footer.jsp"%>