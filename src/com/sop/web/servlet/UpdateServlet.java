package com.sop.web.servlet;

import com.sop.web.dao.DBDao;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class UpdateServlet
  extends HttpServlet
{
  private static final long serialVersionUID = 1L;
  
  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    String message = "";
    DiskFileItemFactory factory = new DiskFileItemFactory();
    factory.setSizeThreshold(102400);
    ServletFileUpload upload = new ServletFileUpload(factory);
    upload.setProgressListener(new ProgressListener()
    {
      public void update(long pBytesRead, long pContentLength, int arg2)
      {
        System.out.println("文件大小为：" + pContentLength + ",当前已处理：" + pBytesRead);
      }
    });
    upload.setHeaderEncoding("UTF-8");
    if (!ServletFileUpload.isMultipartContent(request)) {
      return;
    }
    upload.setFileSizeMax(104857600L);
    
    upload.setSizeMax(1073741824L);
    try
    {
      List<FileItem> list = upload.parseRequest(request);
      String FILE_ID = ((FileItem)list.get(0)).getString("utf-8");
      String FILE_NUM = ((FileItem)list.get(1)).getString("utf-8");
      String FILE_NAME = ((FileItem)list.get(2)).getString("utf-8");
      String FILE_VER = ((FileItem)list.get(3)).getString("utf-8");
      String USER_ID = ((FileItem)list.get(4)).getString("utf-8");
      String FILE_PATH = ((FileItem)list.get(5)).getName();
      Long uu = Long.valueOf(((FileItem)list.get(5)).getSize());
      int size = new Long(uu.longValue()).intValue();
      InputStream is = ((FileItem)list.get(5)).getInputStream();
      Connection con = null;
      PreparedStatement pstmt = null;
      con = DBDao.getConnection();
      String sql1 = "UPDATE file set FILE_NUM=?,FILE_NAME=?,FILE_VER=?,USER_ID=?,FILE_TIME=? where FILE_ID =? ";
      String sql = "UPDATE file set FILE_NUM=?,FILE_NAME=?,FILE_VER=?,USER_ID=?,FILE_TIME=?,FILE_URL=?,FILE_PATH=? where FILE_ID =? ";
      if (FILE_PATH.isEmpty())
      {
        pstmt = con.prepareStatement(sql1);
        pstmt.setString(1, FILE_NUM);
        pstmt.setString(2, FILE_NAME);
        pstmt.setString(3, FILE_VER);
        pstmt.setString(4, USER_ID);
        pstmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
        pstmt.setString(6, FILE_ID);
      }
      else
      {
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, FILE_NUM);
        pstmt.setString(2, FILE_NAME);
        pstmt.setString(3, FILE_VER);
        pstmt.setString(4, USER_ID);
        pstmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
        pstmt.setBinaryStream(6, is, size);
        pstmt.setString(7, FILE_PATH);
        pstmt.setString(8, FILE_ID);
      }
      pstmt.executeUpdate();
      System.out.println(sql);
      System.out.println("name:" + FILE_NAME + "ver:" + FILE_VER);
      message = "文件更新成功！";
      DBDao.close(null, pstmt, con);
    }
    catch (Exception e)
    {
      message = "文件更新失败！";
      e.printStackTrace();
    }
    request.setAttribute("message", message);
    request.getRequestDispatcher("admin/file_message.jsp").forward(request, response);
  }
  
  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    doGet(request, response);
  }
}
