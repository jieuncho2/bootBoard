package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO(){
		try {
			Context init = new InitialContext();
			DataSource ds =(DataSource) init.lookup("java:comp/env/jdbc/bbsDB");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void connClose(){
		try {
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userId, String userPassword) {
		String sql = "select userPassword from user where userId=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if(rs.getString(1).equals(userPassword)) {
				return 1;
			} else {
				return 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public int join(User user) {
		String sql="insert into user values(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserId());
			pstmt.setString(1, user.getUserPassword());
			pstmt.setString(1, user.getUserName());
			pstmt.setString(1, user.getUserGender());
			pstmt.setString(1, user.getUserEmail());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}
}
