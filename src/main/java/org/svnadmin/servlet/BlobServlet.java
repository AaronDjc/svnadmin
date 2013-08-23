package org.svnadmin.servlet;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.svnadmin.service.PjService;
import org.svnadmin.service.RepositoryService;
import org.svnadmin.util.MimeutilsWrapper;
import org.svnadmin.util.SpringUtils;
import org.svnadmin.util.TranCharset;
import org.svnadmin.util.UsrProvider;
import org.tmatesoft.svn.core.SVNDirEntry;

/**
 * Servlet implementation class BlobServlet
 */
public class BlobServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected RepositoryService repositoryService = SpringUtils.getBean(RepositoryService.BEAN_NAME);
	protected PjService pjService = SpringUtils.getBean(PjService.BEAN_NAME);

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UsrProvider.setUsr(BaseServlet.getUsrFromSession(request));
		
		String pj = request.getParameter("pj");
		String path = request.getParameter("path")==null?"":URLDecoder.decode(request.getParameter("path"),"UTF-8");	
		if(path.endsWith("/"))path=path.substring(0,path.length()-1);
		
		String raw = request.getParameter("raw");
			

		if(StringUtils.isBlank(pj)){
			return;
		}		
		
		ByteArrayOutputStream contents =  new ByteArrayOutputStream();		

		if("true".equals(raw)){
			repositoryService.getFile(pj, path, -1, contents);
			response.getOutputStream().write(contents.toByteArray());
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}else{
			String file = path.substring(path.lastIndexOf("/"));			
			String mime = MimeutilsWrapper.getMime(file);
			SVNDirEntry dirEntry = repositoryService.getDirEntry(pj, path, -1);					
			
			if (mime.startsWith("text/") || mime == "application/xml"){
				repositoryService.getFile(pj, path, -1, contents);					
				contents.flush();			
				byte[] arr = contents.toByteArray();
				String txt   = new String(arr);				
	            String strEncode = TranCharset.getEncoding(txt);            
	            String temp = new String(contents.toByteArray(),strEncode);
	            String text = new String(temp.getBytes(strEncode),"UTF-8");
	            request.setAttribute("txtfile", text);
			}
			
			request.setAttribute("mime", mime);
			request.setAttribute("entity",pjService.get(pj));
			request.setAttribute("DirEntry",dirEntry);
			request.getRequestDispatcher("blob.jsp").forward(request, response);
		}
		
	}

}
