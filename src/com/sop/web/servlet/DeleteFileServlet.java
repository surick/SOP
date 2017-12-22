package com.sop.web.servlet;

import com.sop.web.dao.DBDao;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteFileServlet
  extends HttpServlet
{
  private static final long serialVersionUID = 1L;
  
  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    String user = (String)request.getSession().getAttribute("username");
    if (user != null) {
      try
      {
        Connection conn = DBDao.getConnection();
        String sql = "delete from file where FILE_ID = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, request.getParameter("fileid"));
        int count = ps.executeUpdate();
        if (count >= 1) {
          response.sendRedirect("admin/file_search.jsp");
        }
        DBDao.close(null, ps, conn);
      }
      catch (Exception e)
      {
        e.printStackTrace();
      }
    } else {
      response.sendRedirect("login.jsp");
    }
  }
  
  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    doGet(request, response);
  }
}
