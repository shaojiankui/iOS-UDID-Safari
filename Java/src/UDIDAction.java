
import java.io.*;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;


import org.dom4j.*;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

public class UDIDAction  extends HttpServlet implements Servlet {

 public void execute(HttpServletRequest request, HttpServletResponse response) {
  System.out.println("hahahah");


 }

 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  this.doPost(request, response);



 }


 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

//		response.setStatus(302);//设置302状态码，等同于response.setStatus(302);
//		response.sendRedirect("http://192.168.1.106:8080/udid?UDID=2123");
//		response.setStatus(HttpServletResponse.SC_FOUND);
  response.setHeader("Location", "http://192.168.1.106:8080/udid.jsp?UDID=2123");
  response.setStatus(301);


 }


}
