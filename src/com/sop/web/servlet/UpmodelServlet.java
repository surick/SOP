package com.sop.web.servlet;

import com.sop.web.dao.DBDao;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpmodelServlet
  extends HttpServlet
{
  private static final long serialVersionUID = 1L;
  
  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    String message = "";
    try
    {
      String MODEL_NAME = request.getParameter("MODEL_NAME");
      String GROUP_ID = request.getParameter("GROUP_ID");
      String MODEL_ID = request.getParameter("MODEL_ID");
      Connection con = null;
      PreparedStatement pstmt = null;
      con = DBDao.getConnection();
      String sql = "UPDATE model set MODEL_NAME=?,GROUP_ID=? where MODEL_ID =? ";
      pstmt = con.prepareStatement(sql);
      pstmt.setString(1, MODEL_NAME);
      pstmt.setString(2, GROUP_ID);
      pstmt.setString(3, MODEL_ID);
      pstmt.executeUpdate();
      System.out.println(sql);
      message = "更新成功!";
      DBDao.close(null, pstmt, con);
    }
    catch (Exception e)
    {
      message = "更新失败!";
      e.printStackTrace();
    }
    request.setAttribute("message", message);
    request.getRequestDispatcher("admin/mod_message.jsp").forward(request, response);
  }
  
  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    doGet(request, response);
  }
}
