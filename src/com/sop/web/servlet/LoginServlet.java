package com.sop.web.servlet;

import com.sop.web.dao.UserDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginServlet
  extends HttpServlet
{
  private static final long serialVersionUID = 1L;
  
  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    request.setCharacterEncoding("utf-8");
    response.setContentType("text/html;charset=utf-8");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String psw = new UserDao().findUsername(username);
    if ((username == "") || (password == ""))
    {
      response.getWriter().write("<script>alert('��ʾ:������˺Ų���Ϊ��!');history.go(-1);</script>");
    }
    else if (psw == null)
    {
      response.getWriter().write("<script>alert('��ʾ:������˺Ŵ���!');history.go(-1);</script>");
    }
    else if (psw.equals(password))
    {
      request.setAttribute("msg", "�û���" + username + ",��ӭ����");
      request.getSession().setAttribute("username", username);
      
      response.setHeader("Refresh", "1;url=admin/index.jsp");
    }
    else
    {
      response.getWriter().write("<script>alert('��ʾ:������˺Ŵ���!');history.go(-1);</script>");
    }
  }
}
