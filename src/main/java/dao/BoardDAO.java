package dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;

import javax.sql.DataSource;

import dto.BoardDTO;


public class BoardDAO {
	
	private static BoardDAO instance;
	
	public static BoardDAO getInstance() {
		if(instance == null) {
			instance = new BoardDAO();
			
		}
		
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		
		Context ctx = new InitialContext();
		DataSource ds =   (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();	
		
	}
	
	
	public int viewCountIncrease(String seqnum) throws Exception {
		String sql  = "UPDATE board SET view_count = view_count + 1 WHERE seq = ?";
		try(	Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)
				){
			pstmt.setString(1, seqnum);
			return pstmt.executeUpdate();
			
		}
	}
	
	public int deleteBoard(String seq) throws Exception {
		
		String sql = "delete from board where seq = ?";
		
		try( Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, seq);
			return pstmt.executeUpdate();
		}
		
	}
	
	public BoardDTO getDetailBoard(String seqnum) throws Exception {
		
		String sql = "select * from board where seq=?";
		
		try(	Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)
				){
			
			pstmt.setString(1, seqnum);
			
			try(	
					ResultSet rs = pstmt.executeQuery();
					
					){
				
					rs.next();
					BoardDTO dto = new BoardDTO();
					
					dto.setSeq(rs.getInt("seq"));
					dto.setContents(rs.getString("contents"));
					dto.setWriter(rs.getString("writer"));
					dto.setTitle(rs.getString("title"));
					dto.setView_count(rs.getInt("view_count"));
					dto.setWrite_date(rs.getTimestamp("write_date"));

					return dto;

				}
				
				
			}
			
		}
	public int updateBoard(BoardDTO dto)  throws Exception{
		String sql = "update board set title= ?, contents=? where seq= ?";
		try(
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)
				
				){
			
			String title = dto.getTitle();
			String content = dto.getContents();
			int seqNum = dto.getSeq();
		
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, seqNum);
			
			return pstmt.executeUpdate();
			
		}
	}
	
	
	public int insertBoard(BoardDTO dto) throws Exception, Exception {
		
		String sql = "insert into board values( board_seq.nextval, ?,  ? , ?, SYSDATE, default )";

		try(
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)
				
				){
			String id = dto.getWriter();
			String title = dto.getTitle();
			String content = dto.getContents();
			
			pstmt.setString(1, id);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			
			return pstmt.executeUpdate();
			
		}
		
	}
	
	
	public List<BoardDTO> getAllBoard() throws Exception{
		
		List<BoardDTO> result = new ArrayList<BoardDTO>();
		
		String sql = "select * from board order by seq desc";
		
		try(	Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)
				){
			
			try(
					ResultSet rs = pstmt.executeQuery();
					
					){
				
				while(rs.next()) {
					BoardDTO dto = new BoardDTO();
					
					dto.setSeq(rs.getInt("seq"));
					dto.setWriter(rs.getString("writer"));
					dto.setTitle(rs.getString("title"));
					dto.setWrite_date(rs.getTimestamp("write_date"));
					dto.setView_count(rs.getInt("view_count"));
					
					result.add(dto);

				}
				return result;
				
			}
			
		}

	}

}
