<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.svnadmin.Constants"%>
<%@page import="org.svnadmin.util.I18N"%>
<%@include file="header.jsp"%>
<script type="text/javascript" src="<%=ctx%>/resources/treeview/treeview.js"></script>
<link type="text/css" rel="stylesheet" href="<%=ctx%>/resources/treeview/treeview.css"></link>
<script type="text/javascript">
<!--
AjaxTreeView.config.onclick=function(o,a){
	var p=o.getAttribute("param");
	if(p==null)p="";
	var url="<%=ctx%>/pjauth";
	if(url!=""){
	  if(p!=""){
		  if(url.indexOf("?")>0){
		  	url=url+"&"+p;
		  }else{
		  	url=url+"?"+p;
		  }
	   }
	   //alert(url);
	   go(url,"pjauthWindow");
	   return false;
	}
};
$(document).ready(function (){
	AjaxTreeView.open(document.getElementById("svnroot"));
	//回车事件
	$('#path').bind('keyup', function(event){
	   if (event.keyCode=="13"){
		   freshTree();
	   }
	});
});
function freshTree(){
	var $p = $("#path");
	var p = $p.val();
	if(p==""){
		p="/";
		$p.val(p);
	}else if(p.substring(0,1)!="/"){
		p = "/"+p;
		$p.val(p);
	}
	var $r = $("#svnroot");
	$r.children("ul").first().remove();
	$("#rootlink").text("<%=request.getAttribute("root")%>"+p);
	AjaxTreeView.close($r[0]);
	$r.attr("param","pj=<%=request.getParameter("pj")%>&path="+p);
	$r[0].loading = false;
	$r[0].loaded = false;
	AjaxTreeView.open($r[0]);
}
//-->
</script>
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
             <li class="active">权限管理</li>
        </ul>
		<div class="ui-helper-clearfix elfinder elfinder-ltr ui-resizable" style="width: auto; height: 600px;">
			<div class="elfinder-toolbar">
				<div class="input-append">
					<input type="text" id="path" placeholder=".input-append" value="<%=request.getAttribute("path")%>">
					<button class="btn" type="button" onclick="freshTree()">刷新</button>
				</div>
			</div>
			<div class="elfinder-workzone" style="height: 568px;">
				<div class="elfinder-navbar" style="display: block; height: 546px;">
					<div style="z-index: 10; top: 0px; left: 216px;"></div>
					<div class="filetree treeview">
						<ul>
							<li id="svnroot" class="closed lastclosed" treeId="rep" param="pj=<%=request.getParameter("pj")%>&path=<%=request.getAttribute("path")%>">
								<div class="hit closed-hit lastclosed-hit" onclick='$att(this);'></div>
								<span class="folder" onclick='$att(this);'>
									<a id="rootlink" href='javascript:void(0);' onclick='$atc(this)'><%=request.getAttribute("root")%><%=request.getAttribute("path")%></a>
								</span>
							</li>
						</ul>
					</div>
				</div>
				<div class="elfinder-cwd-wrapper" style="height:560px;padding:0;">
					<iframe height="550" width="100%" style="border:0px;" frameBorder="0" name="pjauthWindow" src="<%=ctx%>/pjauth?pj=<%=request.getParameter("pj")%>"></iframe>
				</div>		
			</div>	
	    </div>	
			<div class="ui-widget-header ui-helper-clearfix ui-corner-bottom elfinder-statusbar"></div>
		</div>
	</div>
</div>