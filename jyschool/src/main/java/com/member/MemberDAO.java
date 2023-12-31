package com.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.util.DBConn;
import com.util.DBUtil;

public class MemberDAO {
	private Connection conn = DBConn.getConnection();
	
	public MemberDTO loginMember(String userId, String userPwd) {
		MemberDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT userId, userName, userPwd"
					+ " FROM member"
					+ " WHERE userId = ? AND userPwd = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new MemberDTO();
				
				dto.setUserId(rs.getString("userId"));
				dto.setUserPwd(rs.getString("userPwd"));
				dto.setUserName(rs.getString("userName"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return dto;
	}	

	public void insertMember(MemberDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			conn.setAutoCommit(false);
			
			sql = "INSERT INTO member(userId, userPwd, userName, userbirth, tel, zip, add1, add2, useremail, emailchk, teachchk ) "
					+ "VALUES (?, ?, ?, TO_DATE(?,'YY-MM-DD'), ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getUserPwd());
			pstmt.setString(3, dto.getUserName());
			pstmt.setString(4, dto.getUserBirth());
			pstmt.setString(5, dto.getTel());
			pstmt.setString(6, dto.getZip());
			pstmt.setString(7, dto.getAddr1());
			pstmt.setString(8, dto.getAddr2());
			pstmt.setString(9, dto.getEmail());
			pstmt.setInt(10, dto.getEmailChk());
			pstmt.setInt(11, dto.getTeachChk());
			pstmt.executeUpdate();
			
			pstmt.close();
			pstmt = null;
			
			if(dto.getTeachChk() == 1) {
			sql = "INSERT INTO teacher (userId, edu, TECRECORD, tecimg) VALUES (?, ?, ?, ?)";
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getEdu());
			pstmt.setString(3, dto.getTecRecord());
			pstmt.setString(4, dto.getTecImg());
			
			pstmt.executeUpdate();
			}
			
			conn.commit(); // 오토 커밋 껐으니까 수동으로 돌려야함

		} catch (SQLException e) {
			DBUtil.rollback(conn);
			
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
			
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e2) {
			}
		}
		
	}

	public MemberDTO findById(String userId) {
		MemberDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		try {
			sb.append("SELECT m.userId, userName, userPwd,");
			sb.append("     TO_CHAR(userbirth, 'YYYY-MM-DD') userbirth, ");
			sb.append("   tel,    ");
			sb.append("    zip, add1, add2, useremail, ");
			sb.append("     emailchk, teachchk, tecRecord, tecImg ");
			sb.append("  FROM member m");
			sb.append("  LEFT OUTER JOIN teacher t ON m.userId=t.userId ");
			sb.append("  WHERE m.userId = ?");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new MemberDTO();
				
				dto.setUserId(rs.getString("userId"));
				dto.setUserPwd(rs.getString("userPwd"));
				dto.setUserName(rs.getString("userName"));
				dto.setUserBirth(rs.getString("userbirth"));
				dto.setTel(rs.getString("tel"));
				if(dto.getTel() != null) { // 전화번호가 없는 경우가 있기에
					String[] ss = dto.getTel().split("-");
					if(ss.length == 3) {
						dto.setTel1(ss[0]);
						dto.setTel2(ss[1]);
						dto.setTel3(ss[2]);
					}
				}
				dto.setEmail(rs.getString("useremail"));
				if(dto.getEmail() != null) { // 이메일이 없는 경우가 있기에
					String[] ss = dto.getEmail().split("@");
					if(ss.length == 2) {
						dto.setEmail1(ss[0]);
						dto.setEmail2(ss[1]);
					}
				}
				dto.setZip(rs.getString("zip"));
				dto.setAddr1(rs.getString("add1"));
				dto.setAddr2(rs.getString("add2"));
				dto.setTeachChk(rs.getInt("teachchk"));
				dto.setEmailChk(rs.getInt("emailchk"));
				dto.setTecImg(rs.getString("tecImg"));
				dto.setTecRecord(rs.getString("tecRecord"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return dto;
	}	
	
	public void updateMember(MemberDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {// 원래 오토커밋 끄고 다 해야함
			conn.setAutoCommit(false);
			sql = "UPDATE member SET userPwd=?, userName=?, userbirth=TO_DATE(?,'YYYY-MM-DD'), tel=?, zip=?,"
					+ " add1=?, add2=?, useremail=?, emailchk=?  WHERE userId=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserPwd());
			pstmt.setString(2, dto.getUserName());
			pstmt.setString(3, dto.getUserBirth());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getZip());
			pstmt.setString(6, dto.getAddr1());
			pstmt.setString(7, dto.getAddr2());
			pstmt.setString(8, dto.getEmail());
			pstmt.setInt(9, dto.getEmailChk());
			pstmt.setString(10, dto.getUserId());
			pstmt.executeUpdate();
			
			pstmt.close();
			pstmt = null;
			
			if(dto.getTeachChk() == 1) {
			sql = "update teacher set  edu=?, TECRECORD=?, tecimg=? where userId=?";
			pstmt=conn.prepareStatement(sql);
			
			
			pstmt.setString(1, dto.getEdu());
			pstmt.setString(2, dto.getTecRecord());
			pstmt.setString(3, dto.getTecImg());
			pstmt.setString(4, dto.getUserId());
			pstmt.executeUpdate();
			}

			conn.commit(); // 오토 커밋 껐으니까 수동으로 돌려야함

		} catch (SQLException e) {
			DBUtil.rollback(conn);
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
			
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e2) {
			}
		}

	}
	
	public void deleteMember(String userId) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try { // 정지 탈퇴 재가입을 막기위해 멤버1은 남김ㄴ
			sql = "UPDATE member1 SET enabled=0 WHERE userId=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			pstmt = null;
			
			sql = "DELETE FROM member2 WHERE userId=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}

	}
	
}
