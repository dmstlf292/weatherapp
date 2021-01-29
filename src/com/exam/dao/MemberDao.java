package com.exam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import com.exam.vo.MemberVo;

public class MemberDao {

	public int countAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";
		int count = 0;

		
		try {
			con = JdbcUtils.getConnection(); //1~2단계

			// 3단계. SQL문을 가지는 문장객체 준비
			sql = "SELECT COUNT(*) FROM member";
			pstmt = con.prepareStatement(sql);
			// 4단계. 문장객체로 SQL문 실행
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
			
		}

	return count;

	} // countAll


	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			con = JdbcUtils.getConnection(); //1~2단계
			// 3단계. SQL문을 가지는 문장객체 준비
			sql = "DELETE FROM member";
			pstmt = con.prepareStatement(sql);
			// 4단계. 문장객체로 SQL문 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // deleteAll
	
	
	public void addMember(MemberVo memberVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			con = JdbcUtils.getConnection(); //1~2단계
			// 3단계. SQL문을 가지는 문장객체 준비
			sql ="INSERT INTO member (id, passwd, name, age, gender, email, reg_date, address, tel) ";
			sql +="VALUES (?,?,?,?,?,?,?,?,?)"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberVo.getId());
			pstmt.setString(2, memberVo.getPasswd());
			pstmt.setString(3, memberVo.getName());
			pstmt.setInt(4, memberVo.getAge());
			pstmt.setString(5, memberVo.getGender());
			pstmt.setString(6, memberVo.getEmail());
			pstmt.setTimestamp(7, memberVo.getRegDate());
			pstmt.setString(8, memberVo.getAddress());
			pstmt.setString(9, memberVo.getTel());
			
			// 4단계. 문장객체로 SQL문 실행
			pstmt.executeUpdate();
			System.out.println("insert 성공!");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

		
	} //addMember
	
	
	public List<MemberVo> getMembers() {
		List<MemberVo> list = new ArrayList<>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "SELECT * FROM member ORDER BY id";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				MemberVo memberVo = new MemberVo();
				memberVo.setId(rs.getString("id"));
				memberVo.setPasswd(rs.getString("passwd"));
				memberVo.setName(rs.getString("name"));
				memberVo.setAge(rs.getInt("age"));
				memberVo.setGender(rs.getString("gender"));
				memberVo.setEmail(rs.getString("email"));
				memberVo.setRegDate(rs.getTimestamp("reg_date"));
				
				list.add(memberVo);
			}// while
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}	
		
		return list;
		
		
	} // getMembers
	
	
	public MemberVo getMemberById(String id) {
		MemberVo memberVo = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "SELECT * FROM member WHERE id = ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				memberVo = new MemberVo();
				memberVo.setId(rs.getString("id"));
				memberVo.setPasswd(rs.getString("passwd"));
				memberVo.setName(rs.getString("name"));
				memberVo.setAge(rs.getInt("age"));
				memberVo.setGender(rs.getString("gender"));
				memberVo.setEmail(rs.getString("email"));
				memberVo.setRegDate(rs.getTimestamp("reg_date"));				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		
		return memberVo;
	}// getMemberById
	
	
	public int getCountById(String id) {		
		int count=0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "SELECT COUNT(*) FROM member WHERE id = ? ";			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		
		return count;
	}// getCountById
	
	
	
	public void updateMember(MemberVo memberVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "UPDATE member ";
			sql += "SET name = ?, passwd = ?, age = ?, gender = ?, email = ? ";
			sql += "WHERE id = ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberVo.getName());
			pstmt.setString(2, memberVo.getPasswd());
			pstmt.setInt(3, memberVo.getAge());
			pstmt.setString(4, memberVo.getGender());
			pstmt.setString(5, memberVo.getEmail());
			pstmt.setString(6, memberVo.getId());
			
			pstmt.executeUpdate();
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, null);
		}	
	}// updateMember
	
	
	
	public void deleteById(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "DELETE FROM member WHERE id = ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}	
	}// deleteById
	
	

	public static void main(String[] args) {
		
		MemberDao memberDao = new MemberDao();
		Random random = new Random();
		
		memberDao.deleteAll();
			
				
		for (int i=0; i<1000; i++) {
			MemberVo memberVo = new MemberVo();
			memberVo.setId("user" + i);
			memberVo.setPasswd("1234");
			memberVo.setName("유저" + i);
			
			// 나이값은 8세 이상 100세 이하의 임의의 정수로 설정
			int age = random.nextInt(93) + 8; // (0 ~ 92) + 8 -> (8 ~ 100)
			memberVo.setAge(age);
			
			//true면 남성, false면 여성
			boolean isMale = random.nextBoolean();
			if (isMale) {
				memberVo.setGender("남");
			} else {
				memberVo.setGender("여");				
			}
			
			memberVo.setEmail("user" + i + "@naver.com");			
			memberVo.setRegDate(new Timestamp(System.currentTimeMillis()));
						
			memberDao.addMember(memberVo);
						
		}// for
		
		
		List<MemberVo> list = memberDao.getMembers();
		for (MemberVo memberVo : list) {
			System.out.println(memberVo.toString());
		}// for		
		
		int count = memberDao.countAll();
		System.out.println("count = " + count); 

		String testId = "user0";
		MemberVo memberVo = memberDao.getMemberById(testId);
		System.out.println("getMemberById("+ testId + ") : " + memberVo);
		
		// update 메소드 테스트
		memberVo.setName("성춘향");
		memberVo.setGender("여");
		memberVo.setAge(33);
		memberDao.updateMember(memberVo);
		
		MemberVo memberVo2 = memberDao.getMemberById(testId);
		System.out.println("memberVo2 : " + memberVo2);
		
		//delete 메서드 테스트
		memberDao.deleteById(testId);
		
		MemberVo memberVo3 = memberDao.getMemberById(testId);
		System.out.println("testId " + testId + " 삭제 후 : " + memberVo3);
		

	} // main
}
