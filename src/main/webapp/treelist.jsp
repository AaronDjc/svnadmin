<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.tmatesoft.svn.core.SVNDirEntry"  %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.svnadmin.entity.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.*" %>
<%@ include file="header.jsp"%>
<%
Pj entity = (Pj)request.getAttribute("entity");
%>
<div class="outer">
	<div class="inner">	
			<div class="tabbable">
				<div class="body">
        		<ul class="nav nav-tabs">
                     <li class="active"><a href="<%=ctx %>/treelist?pj=<%=request.getParameter("pj")%>">源代码</a></li>
                     <li><a href="">Wiki</a></li>
                </ul>
                <div class="tab-content" style="padding:0;">
                	<div class="control-group">
                		<%=entity.getDes() %>
                	</div>
               		<div class="control-group">
		                <div class="input-prepend input-append">
		                	<span class="add-on">HTTP</span>
							<input type="text" value="<%=entity.getUrl() %>"  class="input-block-level">
							<button class="btn" type="button"><span class="font-copy"></span>COPY</button>
		                </div>
               		</div>
                </div>
                </div>
            </div>
			<div class="tabbable">
				<div class="body">
        		<ul class="nav nav-tabs">
                     <li class="active"><a href="<%=ctx %>/treelist?pj=<%=request.getParameter("pj")%>">浏览</a></li>
                     <li><a href="<%=ctx %>/commits?pj=<%=request.getParameter("pj")%>">日志</a></li>
                </ul>
                <div class="tab-content">
					<%
					Collection<SVNDirEntry> data = (Collection<SVNDirEntry>)request.getAttribute("data");
					SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");	//2012-12-28T23:07:13-08:00
					SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");			//2012-12-28 23:07:13
					SimpleDateFormat sdf3=new SimpleDateFormat("MMM dd,yyyy");					//December 28, 2012
					String path = StringUtils.isBlank(request.getParameter("path"))?"/":request.getParameter("path");			
					String before="/";
					if(!"/".equals(path)){
						before = path.substring(0, path.lastIndexOf("/"));
						before = StringUtils.isBlank(before)?"/":before;
					}
					if(!path.endsWith("/"))path=path+"/";
					%>
					<ul class="breadcrumb">
			             <li><a href="<%=ctx %>/treelist?pj=<%=request.getParameter("pj")%>&path=/"><i class="font-home"></i><%=request.getParameter("pj")%></a> <span class="divider">/</span></li>
			             <%
			             	if(path.length()>1){ 
			                String[] dirs = path.substring(1).split("/");
			                String subPath = "/";
			                if(dirs.length>1){
			                for(int i =0;i<dirs.length-1;i++){
			                	subPath = subPath+dirs[i]+"/";
			             %>
			             <li><a href="<%=ctx %>/treelist?pj=<%=request.getParameter("pj")%>&path=<%=subPath %>"><%=dirs[i]%></a> <span class="divider">/</span></li>
			             <% }}%>
			             <li class="active"><%=dirs[dirs.length-1] %></li>   
			             <% }%>
			        </ul>	
			        <%SVNDirEntry svndir = (SVNDirEntry)request.getAttribute("DirEntry");%>
			        <div class="block well">
			        	<div class="navbar">
			        		<div class="navbar-inner">			        			
			        			<h5>最新更新</h5>
		        			</div>
		        		</div>
			        	<div class="body">      		
			        		  <div class="message" style="border-bottom:none;padding:0;">
			        		  		<a class="message-img" href="#"><img src="<%=ctx%>/avatar?act=view&name=<%=svndir.getAuthor() %>" height="24"></a>			        		  		
			        		  		<div class="message-body">
                                            <div class="text"><%=StringUtils.isBlank(svndir.getCommitMessage())?"没有填写日志":svndir.getCommitMessage()%></div>
                                            <p class="attribution">
	                                            <a href="#non"><%=svndir.getAuthor() %></a> 修改于
	                                            <i class="icon-time"></i>
	                                            <time class="js-relative-date" datetime="<%=sdf1.format(svndir.getDate())%>" title="<%=sdf2.format(svndir.getDate()) %>"><%=sdf3.format(svndir.getDate())%></time>
                                            </p>
                                    </div>
			        		  </div>						  
						</div>
					</div>	
					
					<div class="block well">		
						<table class="table table-gradient table-hover">
							<thead>
								<tr>
									<td width="16">#</td>
									<td width="240">名称</td>
									<td width="150">最后提交时间</td>
									<td>最后提交信息</td>
								</tr>
							</thead>
							<tbody>					
								<%if(!"/".equals(path)){%>
								<tr>
									<td><i class="icon-arrow-up"></i></td>
									<td colspan="3"><a href="<%=ctx %>/treelist?pj=<%=request.getParameter("pj")%>&path=<%=before %>">..</a></td>
								</tr>
								<% 
								}
								for(SVNDirEntry item:data){
								%>
								<tr>
									<td><i class="icon-<%="file".equals(item.getKind().toString())?"file":"folder-close" %>"></i></td>
									<td><a href="<%=ctx %>/<%="file".equals(item.getKind().toString())?"blob":"treelist" %>?pj=<%=request.getParameter("pj")%>&path=<%=path+item.getPath() %>"><%=item.getPath() %></a></td>
									<td><i class="icon-time"></i><time class="js-relative-date" datetime="<%=sdf1.format(item.getDate())%>" title="<%=sdf2.format(item.getDate()) %>"><%=sdf3.format(item.getDate())%></time></td>
									<td><%=(StringUtils.isBlank(item.getCommitMessage())?"没有填写日志":item.getCommitMessage())%> [<%=item.getAuthor() %>]</td>
								</tr>
								<%} %>
							</tbody>
						</table>
					</div>
				</div>
				</div>
			</div>
				
	</div>
</div>
<%@include file="footer.jsp"%>