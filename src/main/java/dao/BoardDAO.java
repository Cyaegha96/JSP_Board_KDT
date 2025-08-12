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
	
	private int getRecordTotalCount() throws Exception{
		String sql = "select count(*) from board";
		int count =0;
		try(	Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery();
				){
		
			 if (rs.next()) {
			        count = rs.getInt(1);  // 첫 번째 컬럼 값 읽기
			       
			    }
			 
			 return count;
		
		}
	}
	
	public String getPageNavi() throws Exception {
	//페이지네이션
		
		
		//1. 전체 레코드 수가 몇개인지?
		int recordTotalCount = 147;
		
		//2. 한페이지 안에 몇개의 게시글을 보여줄지?
		int recordCountPerPage = 10;
		
		//3. 한번에 네비게이터를 몇개씩 보여줄 것인지?
		
		int naviCountPerPage = 10;
		
		//4. 전체 몇 페이지가 생성될 것인지?
		
		int pageTotalCount = 0 ;
		if(recordTotalCount%recordCountPerPage > 0) {
			pageTotalCount  = recordTotalCount/recordCountPerPage + 1;
		}else {
			pageTotalCount  = recordTotalCount/recordCountPerPage;
		}
		
		//5. 내가 현재 있는 페이지 설정
		
		int currentPage = 1;
		
		if(currentPage <1) {
			currentPage = 1;
		}else if(currentPage > pageTotalCount) {
			currentPage  =pageTotalCount;
		}
		
		
		//내비게이터의 시작값과 끝값
		
		int startNavi = ((currentPage - 1)/ naviCountPerPage) * naviCountPerPage  +1;
		int endNavi = startNavi + naviCountPerPage-1;
		
		if(endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}
		
		System.out.println("현재 위치: "+currentPage);
		System.out.println("네비 시작: "+startNavi);
		System.out.println("네비 종료:" +endNavi);
		
		
		boolean needPrev = true;
		boolean needNext = true;
		
		if(startNavi == 1) {
			
			needPrev = false;
		}
		
		if(endNavi == pageTotalCount){
			needNext=false;
		}
		
		StringBuilder sb  = new StringBuilder();
		
		//ui
		if(needPrev) {
			sb.append("<");
		}
		for(int i=startNavi;i<=endNavi;i++) {
			sb.append(i + " ");
		}
		if(needNext) {
			sb.append(">");
		}
		return sb.toString();
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
