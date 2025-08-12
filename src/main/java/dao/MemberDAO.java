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
import java.sql.Timestamp;

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
	
	public int updateMember(MemberDTO dto) throws Exception {
		
String sql  = "update members set phone=?, email = ?, zipcode=?, address1=?, address2=?  where id = ?";
		
		try(Connection con =  getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			
			pstat.setString(1, dto.getPhoneNumber());
			pstat.setString(2, dto.getEmail());
			pstat.setString(3, dto.getZonecode());
			pstat.setString(4, dto.getAddress());
			pstat.setString(5, dto.getAddressDetail());
			pstat.setString(6, dto.getId());
			
			
			return pstat.executeUpdate();
		}
	}
	
	
	public MemberDTO searchMemberinfoById(String id) throws Exception {
		String sql  = "select * from members where id = ?";
		
		try(	Connection con =  getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			
					pstat.setString(1, id);
			try(
					ResultSet rs = pstat.executeQuery();
					
					){
				if(rs.next()) {
					String Id =  rs.getString("id");
					String Name = rs.getString("name");
					String phone= rs.getString("phone");
					String email = rs.getString("email");
					String zonecode = rs.getString("zipcode");
					
					String address=  rs.getString("address1");
					String addressDetail = rs.getString("address2");
					Timestamp createdAt = rs.getTimestamp("join_date");
					
					MemberDTO dto = new MemberDTO(Id, null, Name, phone, email, zonecode, address, addressDetail,createdAt );
					return dto;
				}else {
					return null;
				}
				
			}
			
			
			
		}
		
	}
	
	public int deleteMember(String id) throws Exception{
		String sql  ="delete from members where id = ? ";
		try(	Connection con =  getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			
			pstat.setString(1, id);
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
