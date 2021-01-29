package com.exam.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JdbcUtils {
	
	public static Connection getConnection() throws Exception {
		Connection con = null;
		
		// DB 접속정보
		String url = "jdbc:mysql://localhost:3306/myjspdb?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul";
		String user = "myjspid"; // DB계정 아이디
		String password = "myjsppass"; // DB계정 패스워드	
		
		// 1단계. DB 드라이버 클래스 강제 로딩
		Class.forName("com.mysql.jdbc.Driver");
		// 2단계. 로딩된 드라이버 클래스를 이용해서
		// 특정 DB에 DB 사용자계정으로 로그인해서 연결하기
		con = DriverManager.getConnection(url, user, password);	
	
		return con;		
	}// getConnection
	
	
	public static void close(Connection con, PreparedStatement pstmt) {
		close(con, pstmt, null);
	}// close
	
	
	public static void close(Connection con, PreparedStatement pstmt, ResultSet rs) {
		// 사용한 JDBC 객체는 사용이 끝나면 닫아줘야 함.
		// 사용의 역순으로 닫아줌
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	} // close
	
	
}
