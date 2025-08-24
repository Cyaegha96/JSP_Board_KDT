package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class PointDAO {

	private static PointDAO instance;

	public synchronized static PointDAO getInstance(){
		if(instance == null) {
			instance = new PointDAO();
		}
		return instance;
	}


	public Connection getConnection() throws Exception {

		
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)  ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();

	}

	public void updatePoint(String userId, int add) throws Exception{
		  String sql = "UPDATE MEMBERS SET point = point + ? WHERE id = ?";
		  try (Connection conn = getConnection();
		             PreparedStatement pstmt = conn.prepareStatement(sql)) {
		            pstmt.setInt(1, add);
		            pstmt.setString(2, userId);
		            pstmt.executeUpdate();
		        } catch (Exception e) {
		            e.printStackTrace();
		        }

	}
	
	public int getPoint(String userId) throws Exception{
		
		String sql = "SELECT point FROM MEMBERS WHERE id = ?";
		
		try (Connection conn = getConnection();
		PreparedStatement pstmt2 = conn.prepareStatement(sql);){
			pstmt2.setString(1, userId);
			try(ResultSet rs = pstmt2.executeQuery();){
				int currentPoint = 0;
				if (rs.next()) {
				    return currentPoint = rs.getInt("point");
				}
			}

			
		}
		return 0;
		
		
	}

}