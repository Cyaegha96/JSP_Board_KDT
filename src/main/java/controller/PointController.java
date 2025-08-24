package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PointDAO;

@WebServlet("/api/point/*") // /api/point/뒤에 뭐가 오든 매핑됨
public class PointController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        // CORS 방지
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");

        String path = request.getPathInfo(); // "/add1", "/add3", "/add5"

        String userId = request.getParameter("userId");
        int add = 0;

        if ("/add1".equals(path)) {
            add = 1;
        } else if ("/add3".equals(path)) {
            add = 3;
        } else if ("/add5".equals(path)) {
            add = 5;
        }

        if (add > 0 && userId != null) {
            try {
            	new PointDAO().updatePoint(userId, add);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            int currentPoint = 0;
			try {
				currentPoint = new PointDAO().getPoint(userId);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            
            response.setContentType("application/json");
            response.getWriter().write("{\"currentPoint\":" + currentPoint  + "}");
            
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"error\": \"Invalid request\"}");
        }
    }
}