<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.svnadmin.util.I18N"%>
<%@include file="header.jsp"%>
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
             <li class="active">项目组用户管理</li>
        </ul>
		<div class="body">
<script>
$(function(){
	$("#frm").submit(function(){
		var f = $(this).get(0);
		if(f.elements["usrs"].value==""){
			alert("<%=I18N.getLbl(request,"pjgrusr.error.usr","用户不可以为空") %>");
			f.elements["usrs"].focus();
			return false;
		}
		return true;
	});
});
</script>

<form id="frm" name="pjgrusr" action="<%=ctx%>/pjgrusr" method="post" onsubmit="return checkForm(this);">	
	<div class="well span6">	
		    <div class="navbar"><div class="navbar-inner"><h5><%=I18N.getLbl(request,"usr.usr","用户") %></h5></div></div>
			<div class="body">
				<div class="control-group">
					<div class="left-box">
							<input type="text" id="box1Filter" class="box-filter" placeholder="Filter entries...">
							<button type="button" id="box1Clear" class="filter">x</button>
							<br/>							
							<select id="box1View" multiple="multiple" class="multiple" style="height:180px;">
									<%
									java.util.List<org.svnadmin.entity.Usr> usrlist = (java.util.List<org.svnadmin.entity.Usr>)request.getAttribute("usrList");
									if(usrlist!=null){	
									for(int i = 0;i<usrlist.size();i++){
										org.svnadmin.entity.Usr usr = usrlist.get(i);
									%>
									<option value="<%=usr.getUsr()%>"><%=usr.getUsr()%></option>
									<%}}%>
							</select>
							<span id="box1Counter" class="countLabel"></span >
							<select id="box1Storage"></select >
					</div>
					<div class="dual-control" style="margin:60px 1px;left:45%;width:132px;">
							<button id="to2" type="button" style="width:30px;" class="btn">&gt;</button><br/>
							<button id="allTo2" type="button" style="width:30px;" class="btn">&gt;&gt;</button><br/>
							<button id="to1" type="button" style="width:30px;" class="btn">&lt;</button><br/>
							<button id="allTo1" type="button" style="width:30px;" class="btn">&lt;&lt;</button>
					</div>
					<div class="right-box">
							<input type="text" id="box2Filter" class="box-filter" placeholder="Filter entries...">
							<button type="button" id="box2Clear" class="filter">x</button>
							<br/>
							<select id="box2View" name="usrs" multiple="multiple" class="multiple" style="height:180px;">
							</select>
							<span id="box2Counter" class="countLabel"></span >
							<select id="box2Storage"></select >
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="form-actions align-center">	
						    <input type="hidden" name="act" value="save">
							<input type="hidden" name="pj" value="<%=request.getParameter("pj")%>">
							<input type="hidden" name="gr" value="<%=request.getParameter("gr")%>">
							<button type="submit" class="btn btn-primary"><%=I18N.getLbl(request,"pjgrusr.op.submit","增加用户") %></button>
				</div>
			</div>			
		</div>	
</form>
			
			<div class="table-overflow block">				
				<table class="table table-striped table-hover table-bordered">	
					<thead>
						<td><%=I18N.getLbl(request,"sys.lbl.no","NO.") %></td>
						<td><%=I18N.getLbl(request,"pj.pj","项目") %></td>
						<td><%=I18N.getLbl(request,"pj_gr.gr","项目组") %></td>
						<td><%=I18N.getLbl(request,"usr.usr","用户") %></td>
						<td><%=I18N.getLbl(request,"pjgrusr.op.delete","删除") %></td>
					</thead>
					<%
					java.util.List<org.svnadmin.entity.PjGrUsr> list = (java.util.List<org.svnadmin.entity.PjGrUsr>)request.getAttribute("list");
				
					if(list!=null){
					  for(int i = 0;i<list.size();i++){
						  org.svnadmin.entity.PjGrUsr pjGrUsr = list.get(i);
						%>
						<tr>
						<td><%=(i+1) %></td>
						<td><%=pjGrUsr.getPj() %></td>
						<td><%=pjGrUsr.getGr() %></td>
						<td><%=pjGrUsr.getUsr() %></td>
						<td><a href="javascript:if(confirm('<%=I18N.getLbl(request,"pjgrusr.op.delete.confirm","确认删除?") %>')){del('<%=ctx%>/pjgrusr?&pj=<%=pjGrUsr.getPj()%>&gr=<%=pjGrUsr.getGr()%>&usr=<%=pjGrUsr.getUsr()%>')}"><%=I18N.getLbl(request,"pjgrusr.op.delete","删除") %></a></td>
					</tr>
						<%	
					}}
					%>
				</table>
			</div>	
				
		</div>
	</div>
</div>
