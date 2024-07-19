
package controller;

import dao.DAO;
import dto.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        resp.setContentType("text/html;charset=UTF-8");

        if (action == null) {
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
        
        if ("login".equalsIgnoreCase(action)) {
            String userId = req.getParameter("userId");
            String password = req.getParameter("password");

            DAO dao = new DAO();
            User user = dao.getUser(userId, Integer.parseInt(password));

            if (user == null) {
                req.setAttribute("message", "Failed to login due to incorrect credentials.");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            } else {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUserId());
                if (user.getRole() == 0) {
                    req.getRequestDispatcher("mobile.jsp").forward(req, resp);
                } else if (user.getRole() == 1) {
                    req.setAttribute("message", "Failed to login due to incorrect role.");
                    req.getRequestDispatcher("login.jsp").forward(req, resp);
                } else {
                    req.getRequestDispatcher("cart.jsp").forward(req, resp);
                }
            }  
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

}
