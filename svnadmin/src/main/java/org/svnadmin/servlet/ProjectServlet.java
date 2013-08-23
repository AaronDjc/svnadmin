package org.svnadmin.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.svnadmin.entity.Pj;
import org.svnadmin.service.PjService;
import org.svnadmin.util.SpringUtils;
import org.svnadmin.util.list.PagedList;

/**
 * 项目
 * @author YueXiaoYun
 *
 */
public class ProjectServlet extends PjBaseServlet {

	/**
	 * VersionUID
	 */
	private static final long serialVersionUID = 6996739562959142169L;
	
	/**
	 * 项目服务层
	 */
	protected PjService pjService = SpringUtils.getBean(PjService.BEAN_NAME);

	@Override
	protected void get(HttpServletRequest request, HttpServletResponse response) {
		this.validateManager(request, response);//检查权限
		request.setAttribute("entity",pjService.get(request.getParameter("pj")));
	}

	@Override
	protected void delete(HttpServletRequest request,HttpServletResponse response) {
		this.validateManager(request, response);//检查权限
		pjService.delete(request.getParameter("pj"));
	}

	@Override
	protected void save(HttpServletRequest request, HttpServletResponse response) {
		this.validateManager(request, response);//检查权限
		Pj entity = new Pj();
		entity.setPj(request.getParameter("pj"));
		entity.setPath(request.getParameter("path"));
		entity.setUrl(request.getParameter("url"));
		entity.setDes(request.getParameter("des"));
		entity.setType(request.getParameter("type"));
		request.setAttribute("entity", entity);
		pjService.save(entity);
	}

	@Override
	protected void list(HttpServletRequest request, HttpServletResponse response) {
		boolean hasAdminRight = hasAdminRight(request);
		int page = StringUtils.isBlank(request.getParameter("page"))?1:Integer.parseInt(request.getParameter("page")); 
		PagedList<Pj> paged = null;
		if (hasAdminRight) {
			paged = pjService.list(page,12);// 所有项目
		} else {
			paged = pjService.list(getUsrFromSession(request).getUsr(),page,10);// 登录用户可以看到的项目
		}
		request.setAttribute("paged", paged);
	}

	@Override
	protected void forword(HttpServletRequest request,HttpServletResponse response) 
			throws IOException, ServletException {

		boolean hasAdminRight = hasAdminRight(request);
		request.setAttribute("hasAdminRight", hasAdminRight);

		boolean hasManagerRight = this.hasManagerRight(request, response);
		request.setAttribute("hasManagerRight", hasManagerRight);

		request.getRequestDispatcher("project.jsp").forward(request, response);
	}

}
