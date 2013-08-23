package org.svnadmin.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.svnadmin.Constants;
import org.svnadmin.entity.Usr;
import org.svnadmin.service.UsrService;
import org.svnadmin.util.EncryptUtil;
import org.svnadmin.util.SpringUtils;

public class PasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected static UsrService usrService = SpringUtils.getBean(UsrService.BEAN_NAME);

    public PasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("entity",BaseServlet.getUsrFromSession(request));		
		request.getRequestDispatcher("password.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String oldpwd = request.getParameter("oldpwd");
		String newpwd = request.getParameter("newpwd");
		String repwd = request.getParameter("repwd");
		
		Usr entity = BaseServlet.getUsrFromSession(request);
		
		try{			
			if (StringUtils.isBlank(oldpwd)) {
				throw new RuntimeException("旧密码不能为空!");				
			}
			if(!EncryptUtil.encrypt(oldpwd).equals(entity.getPsw())){
				throw new RuntimeException("旧密码不正确!");		
			}
			if (StringUtils.isBlank(newpwd)) {
				throw new RuntimeException("新密码不能为空!");				
			}
			if (!newpwd.equals(repwd)) {
				throw new RuntimeException("新密码和确认密码不一致!");				
			}
			
			entity.setPsw(EncryptUtil.encrypt(newpwd));
			
			usrService.updatePwd(entity);
	
			if (entity.getUsr().equals(BaseServlet.getUsrFromSession(request).getUsr())) {// 当前用户
				request.getSession().setAttribute(Constants.SESSION_KEY_USER, entity);
			}			
			response.sendRedirect("password.jsp");
		}
		catch(RuntimeException ex){
			request.setAttribute("entity",entity);	
			request.setAttribute(Constants.ERROR, ex.getMessage());
			request.getRequestDispatcher("password.jsp").forward(request, response);
		}
	}
}
