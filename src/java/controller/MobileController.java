
package controller;

import dao.DAO;
import dto.Mobile;
import dto.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MobileController extends HttpServlet {

    protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User session = (User) req.getSession().getAttribute("user");
        if (session == null) {
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
        
        String action = req.getParameter("action");
        if (action == null) {
            req.getRequestDispatcher("mobile.jsp").forward(req, resp);
        }
        
        if (action != null) {
            if (action.equalsIgnoreCase("search")) {
                DAO dao = new DAO();
                String query = req.getParameter("query");
                List<Mobile> mobileList;
                if (query == null || query.isEmpty()) {
                    mobileList = dao.getAllMobiles();
                } else {
                    mobileList = dao.getAllByIdAndName(query, query);
                }
                req.setAttribute("mobileList", mobileList);
                req.getRequestDispatcher("mobile.jsp").forward(req, resp);
            }

            if (action.equalsIgnoreCase("add")) {
                DAO dao = new DAO();
                String mobileId = req.getParameter("mobileId");
                String price = req.getParameter("price");
                String description = req.getParameter("description");
                String mobileName = req.getParameter("mobileName");
                String yearOfProduction = req.getParameter("yearOfProduction");
                String quantity = req.getParameter("quantity");
                String notSale = req.getParameter("notSale");
                int notSaleInt = 0;
                String image = req.getParameter("image");
                if (notSale != null && "true".equals(notSale)) {
                    notSaleInt = 1;
                }

                boolean response = dao.createMobile(new Mobile(mobileId, description, Float.parseFloat(price), mobileName, Integer.parseInt(yearOfProduction), Integer.parseInt(quantity), notSaleInt,image));
                if (response == true) {
                    req.setAttribute("message", "Mobile created successfully.");
                } else {
                    req.setAttribute("message", "Failed to create mobile.");
                }
                req.getRequestDispatcher("mobile.jsp").forward(req, resp);
            }

            if ("delete".equalsIgnoreCase(action)) {
                DAO dao = new DAO();
                String mobileId = req.getParameter("mobileId");
                boolean response = dao.deleteMobile(mobileId);
                if (response == true) {
                    req.setAttribute("message", "Delete mobile successfully.");
                } else {
                    req.setAttribute("message", "Failed to delete mobile.");
                }
                req.getRequestDispatcher("mobile.jsp").forward(req, resp);
            }
            
            if ("update".equalsIgnoreCase(action)) {
                DAO dao = new DAO();
                String mobileId = req.getParameter("mobileId");
                String price = req.getParameter("price");
                String description = req.getParameter("description");
                String quantity = req.getParameter("quantity");
                String notSale = req.getParameter("notSale");
                String image = req.getParameter("image");
                int notSaleInt = 0;

                if (notSale != null && "true".equals(notSale)) {
                    notSaleInt = 1;
                }

                boolean response = dao.updateMobile(mobileId, Float.parseFloat(price), description, Integer.parseInt(quantity), notSaleInt,image);
                if (response == true) {
                    req.setAttribute("message", "Mobile updated successfully.");
                } else {
                    req.setAttribute("message", "Failed to update mobile.");
                }
                req.getRequestDispatcher("mobile.jsp").forward(req, resp);
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
