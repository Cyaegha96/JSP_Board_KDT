package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.ReplyDTO;

public class ReplyDAO {
	
	private static ReplyDAO instance;
	
	public static ReplyDAO getInstance() {
		if(instance == null) {
			instance = new ReplyDAO();
		}
		return instance;
		
	}
	
	public Connection getConnection() throws Exception {
		
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)  ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
		
	}
	
	public int insertReply(String writer, String contents, String parent_seq) throws Exception{
		String sql = "insert into reply (seq, writer, contents, write_date, parent_seq)"
				+ " values(reply_seq.nextval, ?, ?, default, ?)";
		
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			pstmt.setString(1, writer);
			pstmt.setString(2, contents);
			pstmt.setString(3, parent_seq);
			return pstmt.executeUpdate();
		}
		
		
		
	}
	
	public int deleteReply(String replyseq) throws Exception{
		String sql  = "delete from reply where seq = ?";
		
		try(Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				
				){
			
			pstmt.setString(1, replyseq);
			return pstmt.executeUpdate();
			
		}
	}
	
	public int updateReply(String seq, String userId, String contents)  throws Exception{
		String sql = "update reply set contents=? where seq = ? and writer = ?";
		
		try(Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
				pstmt.setString(1, contents);
				pstmt.setString(2, seq);
				pstmt.setString(3, userId);
				
				return pstmt.executeUpdate();
		}
	}
	
	public List<ReplyDTO> getReplysBySeqnum(String seqnum) throws Exception{
		
		String sql  = "select * from reply where parent_seq = ?";
		
		List<ReplyDTO> result = new ArrayList<ReplyDTO>();
		
		try(Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
					pstmt.setString(1, seqnum);
			
			try(
					ResultSet rs = pstmt.executeQuery();
					){
				
				while(rs.next()) {
					int seq = rs.getInt("seq");
					String writer = rs.getString("writer");
					String contents = rs.getString("contents");
					String ts = new SimpleDateFormat("yyyy년 MM월 dd일 hh:mm").format(rs.getTimestamp("write_date"));
					int parent_seq = rs.getInt("parent_seq");
					
					ReplyDTO dto = new ReplyDTO(seq, writer, contents, ts, parent_seq);
					
					result.add(dto);
				}
				
				return result;
				
			}
		}
		
	}

}
