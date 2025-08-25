package controller;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import dto.MemberDTO;
import service.Util;

@WebServlet("*.member")
public class MemberController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String cmd = uri.substring(contextPath.length());

		MemberDAO dao = MemberDAO.getInstance();

		
		response.setContentType("text/html; charset=UTF-8");
		
		Gson g = new Gson();

		request.setCharacterEncoding("UTF-8");


		try {

			if(cmd.equals("/login.member")) {
				String id = request.getParameter("id");
				String pw = Util.encrypt(request.getParameter("pw"));

				if(dao.searchMemberByIDandPW(id, pw)) {
					System.out.println("로그인 성공");
//					request.setAttribute("loginId", id);
//					request.getRequestDispatcher("/index.jsp").forward(request, response);
					request.getSession().setAttribute("loginId", id); //이제 이값은 전역변수로서 아무데서나 꺼낼 수 있음.
					response.sendRedirect("/");
				}else {
					System.out.println("로그인 실패");
					response.sendRedirect("/");
				}

			}else if(cmd.equals("/mypage.member")) {



//				MemberDTO dto =  dao.searchMemberinfoById(id);
//
//				request.setAttribute("dto", dto);
//
//				System.out.println("마이페이지 조회 아이디 :"+id);
//				System.out.println("Db 조회 체크:"+ dto.getName());


				request.getRequestDispatcher("/member/myPage.jsp").forward(request, response);
			
			}else if(cmd.equals("/mypageInfo.member")) {
			String id = (String) request.getSession().getAttribute("loginId");
		
			MemberDTO dto =  dao.searchMemberinfoById(id);
		
						
				PrintWriter pw = response.getWriter();
				String result = g.toJson(dto);
				pw.append(result);
				
				
			}

			else if(cmd.equals("/logout.member")) {

				System.out.println("로그아웃");

				request.getSession().invalidate();
				//request.removeAttribute("loginId"); //특정 키값만 세션에서 제거
				response.sendRedirect("/index.jsp");

			}else if(cmd.equals("/deleteCheck.member")) {
				System.out.println("회원 탈퇴 체크");
				request.getRequestDispatcher("/member/deleteCheck.jsp").forward(request, response);

			}else if(cmd.equals("/delete.member")) {
				System.out.println("회원 탈퇴");

				String id= request.getParameter("userId");
				System.out.println("탈퇴하려는 아이디: "+id);

				dao.deleteMember(id);
				request.getSession().invalidate();
				response.sendRedirect("/");


			}else if(cmd.equals("/update.member")){

				System.out.println("마이페이지 수정 정보");
				String id = (String) request.getSession().getAttribute("loginId");
				String phone = request.getParameter("phone");
				String email = request.getParameter("email");
				String zoneCode = request.getParameter("zoneCode");
				String address = request.getParameter("address");
				String addressDetail  = request.getParameter("addressDetail");


				MemberDTO dto = new MemberDTO(id,
						null,
						  null,
						  phone,
						  email,
						  zoneCode,
						  address,
						  addressDetail);
				dao.updateMember(dto);


				response.sendRedirect("/mypage.member");

			}else if(cmd.equals("/join.member")) {


				System.out.println("회원가입 폼 이동");
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

			}else if(cmd.equals("/insert.member")) {

				System.out.println("회원가입 정보");


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
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}