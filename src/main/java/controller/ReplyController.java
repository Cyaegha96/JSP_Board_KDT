package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.ReplyDAO;

/**
 * Servlet implementation class ReplyController
 */
@WebServlet("*.reply")
public class ReplyController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String cmd = uri.substring(contextPath.length());
		
		
		ReplyDAO replyDao = ReplyDAO.getInstance();
		
		try {
			if(cmd.equals("/insert.reply")) {
				String writer= request.getParameter("writer");
				String comment = request.getParameter("comment");
				String parent_seq = request.getParameter("parent_seq");
				System.out.println("댓글 입력"+ writer + comment +parent_seq);
				if(replyDao.insertReply(writer, comment, parent_seq) > 0) {
					System.out.println("db에 댓글 삽입 성공");
					response.sendRedirect("/detail.board?seqnum="+parent_seq);
				}
			}else if(cmd.equals("/delete.reply")) {
				System.out.println("댓글 삭제 시도");
				String seq = request.getParameter("seq");
				String parent_seq = request.getParameter("parent_seq");
				
				System.out.println("넘겨진 댓글 정보"+ seq +" "+ parent_seq);
				if(replyDao.deleteReply(seq) > 0) {
					System.out.println("db에 댓글 삭제 성공");
					response.sendRedirect("/detail.board?seqnum="+parent_seq);
				}else {
					response.sendRedirect("/error.jsp");
				}
				
			}else if(cmd.equals("/update.reply")) {
				System.out.println("댓글 수정 시도");
				String seq = request.getParameter("seq");
				String parent_seq = request.getParameter("parent_seq");
				String comment=  request.getParameter("comment");
				String id = (String) request.getSession().getAttribute("loginId");
				
				System.out.println("댓글 수정 시도"+seq + comment+id);
				if(replyDao.updateReply(seq,id, comment) > 0) {
					System.out.println("db에 댓글 수정 성공");
					response.sendRedirect("/detail.board?seqnum="+parent_seq);
				}else {
					response.sendRedirect("/error.jsp");
				}
				
			}
		}catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("/error.jsp");
			
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
