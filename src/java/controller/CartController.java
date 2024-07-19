package controller;

import dao.DAO;
import dto.Cart;
import dto.Mobile;
import dto.User;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CartController extends HttpServlet {

    protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User session = (User) req.getSession().getAttribute("user");
        if (session == null) {
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            req.getRequestDispatcher("cart.jsp").forward(req, resp);
        }
        if ("SEARCH".equalsIgnoreCase(action)) {
            String minPrice = req.getParameter("minPrice");
            String maxPrice = req.getParameter("maxPrice");

            if (minPrice.equalsIgnoreCase("") || maxPrice.equalsIgnoreCase("")) {//35
                List<Mobile> mobiles = new ArrayList<>();
                if (minPrice.equalsIgnoreCase("") && !maxPrice.equalsIgnoreCase("")) {
                    mobiles.addAll(new DAO().getAllMobilesWithCondition(-1, Float.parseFloat(maxPrice)));
                } else if (!minPrice.equalsIgnoreCase("") && maxPrice.equalsIgnoreCase("")) {
                    mobiles.addAll(new DAO().getAllMobilesWithCondition(Float.parseFloat(minPrice), -1));
                } else {
                    mobiles.addAll(new DAO().getAllMobilesWithCondition(-1, -1));
                }
                req.setAttribute("mobiles", mobiles);
                req.getRequestDispatcher("cart.jsp").forward(req, resp);
            } else {
                List<Mobile> mobiles = new DAO().getAllMobilesWithCondition(Float.parseFloat(minPrice), Float.parseFloat(maxPrice));
                req.setAttribute("mobiles", mobiles);
                req.getRequestDispatcher("cart.jsp").forward(req, resp);
            }
        }
        if ("viewCart".equalsIgnoreCase(action)) {
            try {
                DAO dao = new DAO();
                String userID = req.getParameter("userID");
                List<Cart> carts = dao.getCart(userID);
                if (carts != null) {
                    req.setAttribute("carts", carts);

                    float total = dao.getTotalCartValue(userID);
                    req.setAttribute("total", total);
                    req.getRequestDispatcher("insideCart.jsp").forward(req, resp);
                }
            } catch (SQLException ex) {
                Logger.getLogger(CartController.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(CartController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        if ("removeFromCart".equalsIgnoreCase(action)) {
            String mobileId = req.getParameter("mobileId");
            String userID = req.getParameter("userId");
            try {

                DAO dao = new DAO();
                dao.removeFromCart(userID, mobileId);
                List<Cart> carts = dao.getCart(userID);

                if (carts != null) {
                    req.setAttribute("carts", carts);

                    float total = dao.getTotalCartValue(userID);
                    req.setAttribute("total", total);
                    req.getRequestDispatcher("insideCart.jsp").forward(req, resp);
                }
            } catch (SQLException ex) {
                Logger.getLogger(CartController.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(CartController.class.getName()).log(Level.SEVERE, null, ex);
            }

        }

        if ("addToCart".equalsIgnoreCase(action)) {
            DAO dao = new DAO();
            String mobileId = req.getParameter("mobileId");
            boolean response = dao.addToCart(session.getUserId(), mobileId);
            if (response == true) {
                req.setAttribute("message", "Add to cart successfully.");
            } else {
                req.setAttribute("message", "Failed to add to cart.");
            }
            req.getRequestDispatcher("cart.jsp").forward(req, resp);//100
        }

        if ("SEARCH2".equalsIgnoreCase(action)) {
            DAO dao = new DAO();
            String searchValue = req.getParameter("SearchValue");
            List<Mobile> mobiles = dao.getBySearch(searchValue);
            req.setAttribute("mobiles", mobiles);
            req.getRequestDispatcher("cart.jsp").forward(req, resp);
        }

        if ("updateQuantity".equalsIgnoreCase(action)) {

            String mobileId = req.getParameter("mobileId");
            String quantityParam = req.getParameter("quantity");
            String userId = req.getParameter("userId");

            if (quantityParam != null && !quantityParam.isEmpty()) {

                try {
                    int newQuantity = Integer.parseInt(quantityParam);

                    DAO dao = new DAO();
                    if (newQuantity > dao.getMobileQuantity(mobileId)) {
                        req.setAttribute("message", "Insufficient quantity to update, remaining: "+dao.getMobileQuantity(mobileId));
                    } else {
                        boolean result = dao.updateQuantityInCart(userId, mobileId, newQuantity); // Call the updateQuantity method

                        if (result) {
                            req.setAttribute("message", "Quantity updated successfully.");
                        } else {
                            req.setAttribute("message", "Failed to update quantity.");
                        }
                    }
                } catch (NumberFormatException e) {
                    req.setAttribute("message", "Invalid quantity format."); // Handle invalid quantity format
                }
            } else {
                req.setAttribute("message", "Quantity parameter is missing."); // Handle missing quantity parameter
            }

            req.getRequestDispatcher("CartController?userID=" + userId + "&action=VIEWCART").forward(req, resp);
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
