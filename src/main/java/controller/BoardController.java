package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import commons.Config;
import dao.BoardDAO;
import dao.ReplyDAO;
import dto.BoardDTO;
import dto.ReplyDTO;

@WebServlet("*.board")
public class BoardController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	

		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String cmd = uri.substring(contextPath.length());
		
		BoardDAO boardDao = BoardDAO.getInstance();
		ReplyDAO replyDao = ReplyDAO.getInstance();
		
		try {
			
			
			if(cmd.equals("/list.board")) {
				System.out.println("게시판 진입");
				
				
				int cpage = 0;

				String cpageStr = request.getParameter("cpage");
				
				if(cpageStr != null) {
					cpage = Integer.parseInt(cpageStr);
				}else {
					cpage = 1;
				}
				
				
				List<BoardDTO> result = boardDao.selectFromTo(
						cpage* Config.RECORD_COUNT_PER_PAGE -(Config.RECORD_COUNT_PER_PAGE-1) , 
						cpage * Config.RECORD_COUNT_PER_PAGE);
				

				request.setAttribute("list", result);
				
				request.setAttribute("recordTotalCount",boardDao.getRecordTotalCount());
				request.setAttribute("recordCountPerPage", Config.RECORD_COUNT_PER_PAGE);
				request.setAttribute("naviCountPerPage", Config.NAVI_COUNT_PER_PAGE);
				request.setAttribute("currentPage", cpage);
				
				
				
				if(result.size() < 10) {
					request.setAttribute("emptySize", 10-result.size());
				}
				
				request.getRequestDispatcher("/board/list.jsp").forward(request, response);
		
			}else if(cmd.equals("/detail.board")) {
				
				System.out.println("게시물 상세보기 진입");
			
				String seqnum = request.getParameter("seqnum");
				
				BoardDTO board = boardDao.getDetailBoard(seqnum);
				List<ReplyDTO> replyList = replyDao.getReplysBySeqnum(seqnum);
				
				
				boardDao.viewCountIncrease(seqnum);
				request.setAttribute("board", board);
				request.setAttribute("replyList", replyList);
				request.getRequestDispatcher("/board/detail.jsp").forward(request, response);
				
				
			}else if(cmd.equals("/write.board")) {
				System.out.println("글 작성 페이지");
				
				response.sendRedirect("/board/write.jsp");
				//글 삽입
			}else if(cmd.equals("/insert.board")) {
				
				String id = (String) request.getSession().getAttribute("loginId");
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				
				if(boardDao.insertBoard(new BoardDTO(0,id, title, content, null, 0)) > 0) {
					System.out.println("게시글 db삽입 성공");
					response.sendRedirect("/list.board?cpage=1");
				}
				//글 조회
			}
			else if(cmd.equals("/delete.board")) {
				
				System.out.println("게시글 삭제 시도");
				String seq = request.getParameter("seq");
				String id = (String) request.getSession().getAttribute("loginId");
				
				if(!id.equals(boardDao.getDetailBoard(seq).getWriter())) {
					System.out.println("본인이 아닌 아이디를 가진 사용자로 부터의 삭제요청");
					response.sendRedirect("/error.jsp");
					
				}
				
				
				if(boardDao.deleteBoard(seq) > 0) {
					System.out.println("삭제 성공");
					response.sendRedirect("/list.board?cpage=1");
					
				}else {
					System.out.println("삭제 실패");
					response.sendRedirect("/error.jsp");
				}
			
				//글 수정
			}else if(cmd.equals("/update.board")){
				System.out.println("게시글 수정 시도");
				
				String seq = request.getParameter("seq");
				String title= request.getParameter("title");
				String content = request.getParameter("content");
				System.out.println("건네받은 파라미터들:" +seq + title + content);
				
				if(boardDao.updateBoard(new BoardDTO(Integer.parseInt(seq),null, title, content, null, 0)) > 0) {
					System.out.println("수정 성공");
					response.sendRedirect("/detail.board?seqnum="+seq);
				}
				
			}
		}catch(Exception e) {
			e.printStackTrace();
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
