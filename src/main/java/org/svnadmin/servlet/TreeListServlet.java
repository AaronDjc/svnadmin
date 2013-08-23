package org.svnadmin.servlet;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.Collection;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.svnadmin.service.PjGrUsrService;
import org.svnadmin.service.PjService;
import org.svnadmin.service.RepositoryService;
import org.svnadmin.util.SpringUtils;
import org.svnadmin.util.UsrProvider;
import org.tmatesoft.svn.core.SVNDirEntry;

/**
 * Servlet implementation class treelist
 */
public class TreeListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected RepositoryService repositoryService = SpringUtils.getBean(RepositoryService.BEAN_NAME);
	protected PjService pjService = SpringUtils.getBean(PjService.BEAN_NAME);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TreeListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("deprecation")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		UsrProvider.setUsr(BaseServlet.getUsrFromSession(request));
		
		String pj = request.getParameter("pj");
		String _path = request.getParameter("path");
		String path = URLDecoder.decode(_path==null?"":_path,"utf-8");
		
		if(StringUtils.isBlank(pj)){
			return;
		}		
		
		System.out.println(path);
		
		Collection<SVNDirEntry> entries = repositoryService.getTree(pj, path,-1);
		SVNDirEntry dirEntry = repositoryService.getDirEntry(pj, path, -1);
		request.setAttribute("entity",pjService.get(pj));
		request.setAttribute("DirEntry",dirEntry);
		request.setAttribute("data",entries);
		request.getRequestDispatcher("treelist.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}
