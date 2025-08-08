package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Util;

import java.io.IOException;

import dao.MemberDAO;
import dto.MemberDTO;

@WebServlet("*.member")
public class MemberController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd= request.getRequestURI();
		
		MemberDAO dao = MemberDAO.getInstance();
		
		
		try {
			if(cmd.equals("/login.member")) {
				String id = request.getParameter("id");
				String pw = Util.encrypt(request.getParameter("pw"));
				
				if(dao.searchMemberByIDandPW(id, pw)) {
					System.out.println("로그인 성공");
//					request.setAttribute("loginId", id);
//					request.getRequestDispatcher("/index.jsp").forward(request, response);
					request.getSession().setAttribute("loginId", id); //이제 이값은 전역변수로서 아무데서나 꺼낼 수 있음.
					
				}else {
					System.out.println("로그인 실패");
					response.sendRedirect("/");
				}
				
			}
			else if(cmd.equals("/join.member")) {
				response.sendRedirect("/member/joinform.jsp");
			}else if(cmd.equals("/idcheck.member")) {
				String id = request.getParameter("id");
				System.out.println("전달 받은 아이디: " + id);
				
				//dao에게 아이디 중복 확인
				
				
				boolean isIdExist = dao.idCheck(id);
				//boolean isIdExist = false;
				request.setAttribute("isIdExist", isIdExist);
				request.setAttribute("id", id);
				request.getRequestDispatcher("/member/idcheck.jsp").forward(request, response);
				
			}else if(cmd.equals("/login.member")) {
				
				
				String id = request.getParameter("id");
				String pw = Util.encrypt(request.getParameter("pw"));
				String name = request.getParameter("name");
				String phone = request.getParameter("phone");
				String email = request.getParameter("email");
				String zoneCode = request.getParameter("zoneCode");
				String address = request.getParameter("address");
				String addressDetail  = request.getParameter("addressDetail");
				
				//이과정에서 암호화되어 DTO로 넘김
				MemberDTO dto = new MemberDTO(id, 
											pw, 
											  name, 
											  phone,
											  email, 
											  zoneCode, 
											  address, 
											  addressDetail);
	
				if(dao.insertMember(dto) > 0) {
					System.out.println("DB 삽입 성공");
					response.sendRedirect("/");
					
				}
				
				
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("응. 오류임");
			response.sendRedirect("/error.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
