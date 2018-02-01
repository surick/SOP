package com.sop.web.servlet;

import com.sop.web.dao.DBDao;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddModelServlet
  extends HttpServlet
{
  private static final long serialVersionUID = 1L;
  
  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    String message = "";
    try
    {
      ResultSet rs = null;
      String modelname = request.getParameter("model_name");
      String groupid = request.getParameter("group_id");
      Connection con = DBDao.getConnection();
      String sql1 = "select * from model where MODEL_NAME='" + modelname + "' and GROUP_ID='" + groupid + "'";
      Statement stmt = con.createStatement();
      rs = stmt.executeQuery(sql1);
      if (rs.first()) {
        message = "数据库已有同名model，请检查是否重复添加！";
      } else {
        try
        {
          String sql = "insert into model(MODEL_NAME,GROUP_ID) values(?,?)";
          PreparedStatement ps = con.prepareStatement(sql);
          ps.setString(1, request.getParameter("model_name"));
          ps.setString(2, request.getParameter("group_id"));
          int row = ps.executeUpdate();
          if (row > 0) {
            message = "添加成功!";
          }
          DBDao.close(null, ps, con);
        }
        catch (Exception e)
        {
          message = "添加失败!";
          e.printStackTrace();
        }
      }
      request.setAttribute("message", message);
    }
    catch (Exception e)
    {
      message = "error!" + e;
      e.printStackTrace();
    }
    request.getRequestDispatcher("admin/mod_message.jsp").forward(request, response);
  }
  
  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    doGet(request, response);
  }
}
