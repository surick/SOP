package com.sop.web.servlet;

import com.sop.web.dao.DBDao;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class UploadHandleServlet
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
        System.out.println("总大小:" + pContentLength + ",已上传:" + pBytesRead);
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
      String Model_ID = ((FileItem)list.get(0)).getString("utf-8");
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
      ResultSet rs = null;
      con = DBDao.getConnection();
      String sql1 = "SELECT FILE_NAME FROM file where FILE_NAME='" + FILE_NAME + "'";
      Statement stmt = con.createStatement();
      rs = stmt.executeQuery(sql1);
      if (rs.first()) {
        message = "数据库已有同名文件，请检查是否重复发布！";
      } else {
        try
        {
          String sql = "INSERT INTO file (MODEL_ID,FILE_NUM,FILE_NAME,FILE_VER,USER_ID,FILE_TIME,FILE_URL,FILE_PATH) VALUES (?,?,?,?,?,?,?,?)";
          pstmt = con.prepareStatement(sql);
          pstmt.setString(1, Model_ID);
          pstmt.setString(2, FILE_NUM);
          pstmt.setString(3, FILE_NAME);
          pstmt.setString(4, FILE_VER);
          pstmt.setString(5, USER_ID);
          pstmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
          pstmt.setBinaryStream(7, is, size);
          pstmt.setString(8, FILE_PATH);
          pstmt.executeUpdate();
          System.out.println("name:" + FILE_NAME + "ver:" + FILE_VER);
          message = "文件发布成功！";
          DBDao.close(null, pstmt, con);
        }
        catch (Exception e)
        {
          message = "error:" + e;
          e.printStackTrace();
        }
      }
      request.setAttribute("message", message);
    }
    catch (FileUploadBase.FileSizeLimitExceededException e)
    {
      e.printStackTrace();
      request.setAttribute("message", "单个文件超出最大值！！！");
      request.getRequestDispatcher("admin/file_message.jsp").forward(request, response);
      return;
    }
    catch (FileUploadBase.SizeLimitExceededException e)
    {
      e.printStackTrace();
      request.setAttribute("message", "上传文件的总的大小超出限制的最大值！！！");
      request.getRequestDispatcher("admin/file_message.jsp").forward(request, response);
      return;
    }
    catch (Exception e)
    {
      message = "文件发布失败！";
      e.printStackTrace();
    }
    request.getRequestDispatcher("admin/file_message.jsp").forward(request, response);
  }
  
  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    doGet(request, response);
  }
}
