package org.svnadmin.servlet;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jspsmart.upload.File;
import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

public class avatarServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public avatarServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
			
			String action = request.getParameter("act");			
			String path = request.getContextPath();
			
			if("view".equals(action)){	
				String name = request.getParameter("name")==null ? "avatar":request.getParameter("name");
				
				String imagepath=path+"/avatar/"+name+"_middle.jpg";				
				System.out.println(imagepath);
				
//				FileInputStream hFile = new FileInputStream(imagepath); 
//		        int i=hFile.available(); //得到文件大小   
//		        byte data[]=new byte[i];   
//		        hFile.read(data);  
//		        
//		        response.setContentType("image/*");
//				ServletOutputStream output = response.getOutputStream();
//				output.write(data);				
//				output.flush();  
//				output.close();   
//		        hFile.close(); 
		        
			}else{
				request.setAttribute("entity",BaseServlet.getUsrFromSession(request));					
				String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
				request.setAttribute("basePath",basePath);
				request.getRequestDispatcher("avatar.jsp").forward(request, response);
			}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("deprecation")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("a");		
			
		PrintWriter out = response.getWriter();
		ServletConfig config=this.getServletConfig();
		
		if("uploadavatar".equals(action)){			
			SmartUpload su =new SmartUpload();		
			su.initialize(config,request,response);
			try {		
				su.upload();
			} catch (SmartUploadException e) {
				e.printStackTrace();
			}	
			
			File file=su.getFiles().getFile(0);
	        java.util.Date d =new java.util.Date();
	        Long l = d.getTime();
			String realPath="upload/" + l.toString()+ "."+file.getFileExt();
			System.out.println(realPath);
			try {
				file.saveAs(realPath,SmartUpload.SAVE_VIRTUAL);
			} catch (SmartUploadException e) {
				e.printStackTrace();
			}
			String path = request.getContextPath();
			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
			System.out.println(basePath+realPath);
			out.println(basePath+realPath);
		}
		else if("rectavatar".equals(action)){
			
			String avatar1 = request.getParameter("avatar1");//大
			String avatar2 = request.getParameter("avatar2");//中
			String avatar3 = request.getParameter("avatar3");//小
			
			String output ="";
			try {
				output = URLDecoder.decode(request.getParameter("input"),"UTF-8");
			} catch (Exception e)
			{
				System.out.println("解码错误!");
			}
			
			String[] tmp_input=output.split("@");
			String imgfilepath=request.getRealPath(tmp_input[0]);
			
			String imagepath1="";
			String imagepath2="";
			String imagepath3="";
			
			imagepath1=imgfilepath+"/"+tmp_input[1]+"_big.jpg";
			imagepath2=imgfilepath+"/"+tmp_input[1]+"_middle.jpg";
			imagepath3=imgfilepath+"/"+tmp_input[1]+"_small.jpg";

			System.out.println(imagepath1);
			System.out.println(imagepath2);
			System.out.println(imagepath3);
			
			boolean a1=saveFile(imagepath1,getFlashDataDecode(avatar1));
			boolean a2=saveFile(imagepath2,getFlashDataDecode(avatar2));
			boolean a3=saveFile(imagepath3,getFlashDataDecode(avatar3));
			
			if(a1&&a2&&a3){
				out.print("<?xml version=\"1.0\" ?><root><face success=\"0\"/></root>");
			}else{
				out.print("<?xml version=\"1.0\" ?><root><face success=\"1\"/></root>");
			}
		}
	}
	
	public boolean saveFile(String path,byte[]b){
		try{
			FileOutputStream fs = new FileOutputStream(path);
		    fs.write(b, 0, b.length);
		    fs.close();
			return false;
		}catch(Exception e){
		    return true;
		}
	}
	
	private byte[] getFlashDataDecode(String src)
	{
		char []s=src.toCharArray();
		int len=s.length;
	    byte[] r = new byte[len / 2];
	    for (int i = 0; i < len; i = i + 2)
	    {
	        int k1 = s[i] - 48;
	        k1 -= k1 > 9 ? 7 : 0;
	        int k2 = s[i + 1] - 48;
	        k2 -= k2 > 9 ? 7 : 0;
	        r[i / 2] = (byte)(k1 << 4 | k2);
	    }
	    return r;
	}

}
