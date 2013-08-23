package org.svnadmin.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.svnadmin.Constants;
import org.svnadmin.entity.Pj;
import org.svnadmin.service.PjService;
import org.svnadmin.util.SpringUtils;
import org.tmatesoft.svn.core.SVNException;

/**
 * Servlet implementation class ProjectNewServlet
 */
public class ProjectNewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	
	protected PjService pjService = SpringUtils.getBean(PjService.BEAN_NAME);
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProjectNewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//PjBaseServlet.validateManager(request, response);//检查权限
		request.setAttribute("entity",pjService.get(request.getParameter("pj")));
		request.getRequestDispatcher("project_create.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		String base_path = Constants.Repository_Path;
		String base_url  = Constants.Repostory_Url;
		
		String repository_owner = request.getParameter("repository_owner");
		String repository_name  = request.getParameter("repository_name");
		String repository_desc = request.getParameter("repository_desc");
		boolean  repository_init = true;				
		String path = base_path + repository_owner + "\\" +repository_name;
		String url = base_url + repository_owner + "/" +repository_name;
		
		Pj entity = new Pj();
		entity.setPj(repository_name);
		entity.setPath(path);
		entity.setUrl(url);
		entity.setDes(repository_desc);
		entity.setType("http");
		request.setAttribute("entity", entity);
		try {
			pjService.save(entity,repository_init);
		} catch (SVNException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.getOutputStream().println(e.getStackTrace().toString());
		}		
		response.sendRedirect("project");
	}

}
