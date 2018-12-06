package org.skyfox.udid;
import org.dom4j.*;
import org.dom4j.io.SAXReader;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UDIDAction
 */
@WebServlet("/UDIDAction")
public class UDIDAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UDIDAction() {
        super();
        // TODO Auto-generated constructor stub
    }
    public void execute(HttpServletRequest request, HttpServletResponse response) {
    	  System.out.println("hahahah");
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setContentType("text/html;charset=UTF-8");
	  request.setCharacterEncoding("UTF-8");

	  //获取HTTP请求的输入流
	  InputStream is = request.getInputStream();
	  //已HTTP请求输入流建立一个BufferedReader对象
	  BufferedReader br = new BufferedReader(new InputStreamReader(is,"UTF-8"));
	  StringBuilder sb = new StringBuilder();

	  //读取HTTP请求内容
	  String buffer = null;
	  while ((buffer = br.readLine()) != null) {
	   sb.append(buffer);
	  }
	  String content = sb.toString().substring(sb.toString().indexOf("<?xml"), sb.toString().indexOf("</plist>")+8);
	  System.out.println(content);


	     // 创建xml解析对象
	     SAXReader reader = new SAXReader();
	     // 定义一个文档
	     Document document = null;
	     //将字符串转换为
	     try {
	         document = reader.read(new ByteArrayInputStream(content.getBytes("GBK")));
	     } catch (DocumentException e) {
	         e.printStackTrace();
	     }

//				response.setStatus(302);//设置302状态码，等同于response.setStatus(302);
//				response.sendRedirect("http://192.168.1.106:8080/udid?UDID=2123");
//				response.setStatus(HttpServletResponse.SC_FOUND);
	  response.setHeader("Location", "http://192.168.203.123:8080/UDID/udid.jsp?UDID=2123");
	  response.setStatus(301);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	

		  doGet(request, response);
	}

}
