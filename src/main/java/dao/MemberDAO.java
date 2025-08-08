package dao;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import dto.MemberDTO;
import service.Util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;

import javax.naming.Context;

public class MemberDAO {

	private static MemberDAO instance = null;
	
	public synchronized static MemberDAO getInstance(){
		if(instance == null) {
			instance = new MemberDAO();
		}
		return instance;
	}

	
	public Connection getConnection() throws Exception {
		
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)  ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
		
	}
	
	public boolean searchMemberByIDandPW(String id, String pw) throws Exception{
		String sql  = "select * from members where id = ? and pw = ?";
		
		try(Connection con =  getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);)
		
		{
			pstat.setString(1, id);
			pstat.setString(2, pw);
			try(
					ResultSet rs = pstat.executeQuery();)
			{
				return rs.next();
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
			
		}
		return false;
	}
	
	public int insertMember(MemberDTO dto) throws Exception {
		String sql  = "insert into members values(?,?,?,?,?,?,?,?,?)";
		
		try(Connection con =  getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			
			pstat.setString(1, dto.getId());
			
			pstat.setString(2, dto.getPw());
			pstat.setString(3, dto.getName());
			pstat.setString(4, dto.getPhoneNumber());
			pstat.setString(5, dto.getEmail());
			pstat.setString(6, dto.getZonecode());
			pstat.setString(7, dto.getAddress());
			pstat.setString(8, dto.getAddressDetail());
			pstat.setTimestamp(9, dto.getCreatedAt());
			
			
			return pstat.executeUpdate();
		}
		
	}
	
	
	public boolean idCheck(String id) throws Exception {
		String sql = "select * from members where id = ?";
		
		try(	Connection con =  getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			
			pstat.setString(1, id);
			ResultSet rs = pstat.executeQuery();
			return rs.next();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
		
	}
	
	
}
