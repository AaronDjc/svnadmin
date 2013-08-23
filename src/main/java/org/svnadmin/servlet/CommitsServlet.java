package org.svnadmin.servlet;

import java.io.IOException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.svnadmin.service.PjService;
import org.svnadmin.service.RepositoryService;
import org.svnadmin.util.SpringUtils;
import org.svnadmin.util.UsrProvider;
import org.tmatesoft.svn.core.SVNLogEntry;

/**
 * Servlet implementation class CommitsServlet
 */
public class CommitsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected RepositoryService repositoryService = SpringUtils.getBean(RepositoryService.BEAN_NAME);
	protected PjService pjService = SpringUtils.getBean(PjService.BEAN_NAME);
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		UsrProvider.setUsr(BaseServlet.getUsrFromSession(request));
		
		String pj = request.getParameter("pj");
		
		if(StringUtils.isBlank(pj)){
			return;
		}		
		
		Collection<SVNLogEntry> entries = repositoryService.getCommits(pj,-1);
		request.setAttribute("entity",pjService.get(pj));
		request.setAttribute("data",entries);
		request.getRequestDispatcher("commits.jsp").forward(request, response);
	}
}
