package com.sop.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserDao {
	public String findUsername(String username){
		String psw = null;
		Connection con =null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		try {
			con = DBDao.getConnection();
			String sql = "select * from user where USER_NAME=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, username);
			rs = pstmt.executeQuery();
			if(rs==null){
				return null;
			}
			if(rs.next()){
				psw=rs.getString("USER_PWD");
			}else{
				psw=null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBDao.close(rs, pstmt, con);
		}
		return psw;
	}
	
}
