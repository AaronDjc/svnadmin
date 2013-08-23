<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.svnadmin.util.I18N"%>
<%@page import="org.svnadmin.entity.*"%>
<%@page import="org.svnadmin.Constants"%>
<%@page import="org.svnadmin.util.list.PagedList" %>
<%@page import="java.util.*" %>
<%@include file="header.jsp"%>

<%
boolean hasAdminRight = (Boolean)request.getAttribute("hasAdminRight");
boolean hasManagerRight = (Boolean)request.getAttribute("hasManagerRight");
%>
<%
if(hasManagerRight){
	Pj entity = (Pj)request.getAttribute("entity");
	if("add".equals(request.getParameter("act"))){
		entity=new Pj();
	}
	if(entity!=null){//entity=new Pj();
%>
	<div class="content-box">
		<div class="content-box-header">
			<h3><%=I18N.getLbl(request,"pj.title","项目管理") %></h3>
		</div>
		<div class="content-box-content">
			<script type="text/javascript">
			function checkForm(f){
				if(f.elements["pj"].value==""){
					alert("<%=I18N.getLbl(request,"pj.error.pj","项目不可以为空") %>");
					f.elements["pj"].focus();
					return false;
				}
				if(f.elements["path"].value==""){
					alert("<%=I18N.getLbl(request,"pj.error.path","路径不可以为空") %>");
					f.elements["path"].focus();
					return false;
				}
				if(f.elements["url"].value==""){
					alert("<%=I18N.getLbl(request,"pj.error.url","URL不可以为空") %>");
					f.elements["url"].focus();
					return false;
				}
				return true;
			}
			</script>
			<form name="pj" action="<%=ctx%>/project" method="post" onsubmit="return checkForm(this);">
				<p>
			           <label class="label"><%=I18N.getLbl(request,"pj.pj","项目名称") %>：</label>
			           <%if(hasAdminRight){ %>
			           <input type="text" name="pj" id="producttitle" class="text-input small-input" value="<%=entity.getPj()==null?"":entity.getPj()%>" onkeyup="value=value.replace(/[^_\-A-Za-z0-9]/g,'')"/>
			           <%}else{ %>
			           <%=entity.getPj()==null?"":entity.getPj()%>
					   <%} %>
			    </p>
			    <p>
			           <label class="label"><%=I18N.getLbl(request,"pj.type","访问类型") %>：</label>
			           <input type="radio" name="type" value="<%=Constants.SVN%>" <%=Constants.SVN.equals(entity.getType())?"checked='checked'":""%>><%=I18N.getLbl(request,"pj.type.svn","svn") %>
			           <input type="radio" name="type" value="<%=Constants.HTTP%>" <%=Constants.HTTP.equals(entity.getType())?"checked='checked'":""%>><%=I18N.getLbl(request,"pj.type.http","http") %>
			           <input type="radio" name="type" value="<%=Constants.HTTP_MUTIL%>" <%=Constants.HTTP_MUTIL.equals(entity.getType())?"checked='checked'":""%>><%=I18N.getLbl(request,"pj.type.http.mutil","http(多库)") %>
			    </p>
			    <p>
			           <label class="label"><%=I18N.getLbl(request,"pj.path","数据路径") %>：</label>
			           <input type="text" name="path" id="producttitle" class="text-input small-input" value="<%=entity.getPath()==null?"":entity.getPath()%>"/>
			    </p>
			    <p>
			           <label class="label"><%=I18N.getLbl(request,"pj.url","访问地址") %>：</label>
			           <input type="text" name="url" id="producttitle" class="text-input small-input" value="<%=entity.getUrl()==null?"":entity.getUrl()%>"/>
			    </p>
			    <p>
			           <label class="label"><%=I18N.getLbl(request,"pj.des","项目描述") %>：</label>
			           <textarea rows="5" name="des"><%=entity.getDes()==null?"":entity.getDes()%></textarea>
			    </p>
			    <p style="padding-left:42px;">            
			           <input type="submit" class="button" value="<%=I18N.getLbl(request,"pj.btn.submit","保存") %>"/>
			           <input type="hidden" name="act" value="save"/>
			    </p>
			</form>
		</div>
	</div>
	<%}%>
<%}%>

<div class="outer">
<div class="inner">

<div class="well">
			<div class="navbar">
	        	<div class="navbar-inner">
	            	<h5><i class="font-align-justify"></i>项目列表</h5>
	            	<div class="nav pull-right">
                               <a href="#" class="dropdown-toggle just-icon" data-toggle="dropdown"><i class="font-cog"></i></a>
                               <ul class="dropdown-menu pull-right">
                                   <li><a href="<%=ctx%>/project?act=add"><i class="font-plus"></i>添加项目</a></li>
                                   <li><a href="<%=ctx%>/project"><i class="font-refresh"></i>刷新</a></li>
                               </ul>
                    </div>
	            </div>
	        </div>
			<div class="table-overflow">
			<table class="table table-striped">
				<thead>
					<tr>
						<th width="40"><center>#</center></th>
						<th>Project</th>
						<th>Description</th>
						<th>URL</th>
						<th width="50">Type</th>					
						<th width="150">Actions</th>
					</tr>
				</thead>
				<%  PagedList<Pj> paged = (PagedList<Pj>)request.getAttribute("paged"); %>
				<tfoot>
									<tr>
										<td colspan="6" class="table-footer">
											<div class="pagination pull-right">
			                                    <ul>
			                                    	<%if(paged.getCurrentPageIndex()>1){ %>
			                                        <li><a href="<%=ctx%>/project?page=<%=paged.getCurrentPageIndex()-1%>">上一页</a></li>
			                                        <%}%>
			                                        <% for(int i:(List<Integer>)paged.getPageList()){%>
			                                        <%if(i==paged.getCurrentPageIndex()) {%>
			                                        <li class="active"><span><%=i %></span></li>
			                                        <%}else{ %>
			                                        <li><a href="<%=ctx%>/project?page=<%=i %>"><%=i %></a></li>			                                        
			                                        <%}%>
			                                        <%}%>
			                                        <%if(paged.getCurrentPageIndex()<paged.getTotalPageCount()){ %>
			                                        <li><a href="<%=ctx%>/project?page=<%=paged.getCurrentPageIndex()+ 1%>">下一页</a></li>
			                                        <%}%>
			                                    </ul>
			                                </div>
										</td>
									</tr>
				</tfoot>
				<tbody>
				<%
				List<Pj> list = paged.getList();
				int start = paged.getStartRecordIndex();
				if(list!=null){
				  for(int i = 0;i<list.size();i++){
					  Pj pj = list.get(i);
					%>
					<tr>
					<td class="align-center"><%=(i+start) %></td>
					<td><%=pj.getPj() %></td>
					<td><%=pj.getDes() %></td>					
					<td><%=pj.getUrl() %></td>
					<td><%=pj.getType()%></td>				
					<td>	
						<ul class="table-controls">    
						<%if(hasAdminRight || pj.isManager()){%>
						<li><a class="btn" href="<%=ctx%>/project?act=get&pj=<%=pj.getPj()%>" title="编辑项目"><b class="font-edit"></b></a></li>
						<%}%>                                           			
						<%if(Constants.SVN.equals(pj.getType()) || Constants.HTTP.equals(pj.getType())){%>
						<li><a class="btn" href="<%=ctx%>/pjusr?pj=<%=pj.getPj()%>" title="设置用户"><b class="font-user"></b></a></li>
						<%}%>
						<%if(hasAdminRight || pj.isManager()){%>
						<li><a class="btn" href="<%=ctx%>/pjgr?pj=<%=pj.getPj()%>" title="设置用户组"><b class="font-group"></b></a></li>
						<li><a class="btn" href="<%=ctx%>/rep?pj=<%=pj.getPj()%>" title="设置权限"><b class="font-lock"></b></a></li>
						<li><a class="btn" title="删除" href="javascript:if(confirm('确认删除?')){del('<%=ctx%>/pj?pj=<%=pj.getPj()%>')}"><b class="font-minus-sign"></b></a></li>
						<%} %>
						</ul>
					</td>
				</tr>
				<%}}%>
				</tbody>
			</table>
			</div>
		</div>

</div>
</div>
<%@include file="footer.jsp"%>