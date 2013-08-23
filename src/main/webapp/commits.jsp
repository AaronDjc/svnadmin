<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.tmatesoft.svn.core.*"  %>
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
                     <li><a href="<%=ctx %>/treelist?pj=<%=request.getParameter("pj")%>">浏览</a></li>
                     <li class="active"><a href="<%=ctx %>/commits?pj=<%=request.getParameter("pj")%>">日志</a></li>
                </ul>
                <div class="tab-content">
					<%
					Collection<SVNLogEntry> data = (Collection<SVNLogEntry>)request.getAttribute("data");
					
										
					SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");	//2012-12-28T23:07:13-08:00
					SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");			//2012-12-28 23:07:13
					SimpleDateFormat sdf3=new SimpleDateFormat("MMM dd,yyyy");					//December 28, 2012					
					%>
					<ul class="breadcrumb">
			             <li><a href="<%=ctx %>/treelist?pj=<%=request.getParameter("pj")%>&path=/"><i class="font-home"></i><%=request.getParameter("pj")%></a> <span class="divider">/</span></li>
			             <li class="active">commits</li>   
			        </ul>
					
					<div class="body">
							<div class="timeline-messages"> 							
								<% 
								for(SVNLogEntry item:data){
								%>								     		
					        		  <div class="message">
					        		  		<a class="message-img" href="#"><img src="<%=ctx%>/avatar?act=view&name=<%=item.getAuthor() %>" height="24"></a>			        		  		
					        		  		<div class="message-body">
		                                            <div class="text"><%=StringUtils.isBlank(item.getMessage())?"没有填写日志":item.getMessage()%></div>
		                                            <p class="attribution">
			                                            <a href="#non"><%=item.getAuthor() %></a> 修改于
			                                            <i class="icon-time"></i>
			                                            <time class="js-relative-date" datetime="<%=sdf1.format(item.getDate())%>" title="<%=sdf2.format(item.getDate()) %>"><%=sdf3.format(item.getDate())%></time>
		                                            </p>
		                                    </div>
					        		  </div>								
								<%} %>	
							</div>						
					</div>
				</div>
				</div>
			</div>
				
	</div>
</div>
<%@include file="footer.jsp"%>