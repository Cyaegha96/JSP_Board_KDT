package dto;

import java.sql.Timestamp;
import java.time.LocalDateTime;


public class MemberDTO {
	
	private String id;
	private String pw;
	private String name;
	private String phoneNumber;
	private String email;
	private String zonecode;
	private String address;
	private String addressDetail;
	private Timestamp createdAt;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getZonecode() {
		return zonecode;
	}
	public void setZonecode(String zonecode) {
		this.zonecode = zonecode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddressDetail() {
		return addressDetail;
	}
	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}
	
	
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp localDateTime) {
		this.createdAt = localDateTime;
	}
	public MemberDTO() {
		
	}
	public MemberDTO(String id, String pw, String name, String phoneNumber, String email, String zonecode,
			String address, String addressDetail) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.zonecode = zonecode;
		this.address = address;
		this.addressDetail = addressDetail;
		this.createdAt = Timestamp.valueOf(LocalDateTime.now());
	}
	
	
	
	
	

}
