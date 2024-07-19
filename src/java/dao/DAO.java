package dao;

import dto.Cart;
import dto.Mobile;
import dto.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.DBUtils;

public class DAO {
    
    Connection connection;
    PreparedStatement ps;
    ResultSet rs;
    
    public boolean deleteMobile(String mobileId) {
        String sql = "DELETE FROM tbl_Mobile WHERE mobileId = ?;";
        boolean response = true;
        
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, mobileId);
            response = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception ex) {
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException se) {
                se.printStackTrace(); // or log it
            }
        }
        
        return response;
    }
    
    public boolean createMobile(Mobile mobile) {
        String sql = "INSERT INTO tbl_Mobile VALUES (?, ?, ?, ?, ?, ?, ?,?);";
        boolean response = true;
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, mobile.getMobileId());
            ps.setString(2, mobile.getDescription());
            ps.setFloat(3, mobile.getPrice());
            ps.setString(4, mobile.getMobileName());
            ps.setInt(5, mobile.getYearOfProduction());
            ps.setInt(6, mobile.getQuantity());
            ps.setInt(7, mobile.getNotSale());
            ps.setString(8, mobile.getImage());
            response = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception ex) {
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException se) {
                se.printStackTrace(); // or log it
            }
        }
        return response;
    }
    
    public boolean updateMobile(String mobileId, float price, String description, int quantity, int notSaleInt, String image) {
        String sql = "UPDATE tbl_Mobile SET price = ?, description = ?, quantity = ?, notSale = ?, image = ? WHERE mobileId = ?;";
        boolean response = true;
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setFloat(1, price);
            ps.setString(2, description);
            ps.setInt(3, quantity);
            ps.setInt(4, notSaleInt);
            ps.setString(5, image);
            ps.setString(6, mobileId);
            response = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception ex) {
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException se) {
                se.printStackTrace(); // or log it
            }
        }
        return response;
    }
    
    public User getUser(String userId, Integer password) {
        User user = null;
        String sql = "SELECT * FROM tbl_User WHERE userId = ? AND password = ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, userId);
            ps.setInt(2, password);
            rs = ps.executeQuery();
            while (rs.next()) {
                user = new User(rs.getString("userId"), rs.getInt("password"), rs.getString("fullName"), rs.getInt("role"));
                return user;
            }
        } catch (Exception ex) {
        }
        
        return user;
    }
    
    public List<Mobile> getAllMobiles() {
        List<Mobile> mobileList = new ArrayList<Mobile>();
        Mobile mobile;
        String sql = "SELECT * FROM tbl_Mobile;";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                mobile = new Mobile(
                        rs.getString("mobileId"),
                        rs.getString("description"),
                        rs.getFloat("price"),
                        rs.getString("mobileName"),
                        rs.getInt("yearOfProduction"),
                        rs.getInt("quantity"),
                        rs.getInt("notSale"),
                        rs.getString("image")
                );
                mobileList.add(mobile);
            }
        } catch (Exception ex) {
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        
        return mobileList;
    }
    
    public List<Mobile> getAllMobilesWithCondition(float minPrice, float maxPrice) {
        List<Mobile> mobileList = new ArrayList<Mobile>();
        Mobile mobile;
        
        try {
            connection = DBUtils.getConnection();
            String sql = "";
            if (minPrice == -1 && maxPrice != -1) {
                sql = "SELECT * FROM tbl_Mobile WHERE price <= ?;";
            } else if (minPrice != -1 && maxPrice == -1) {
                sql = "SELECT * FROM tbl_Mobile WHERE price >= ?;";
            } else if (minPrice == -1 && maxPrice == -1) {
                sql = "SELECT * FROM tbl_Mobile;";
            } else {
                sql = "SELECT * FROM tbl_Mobile WHERE price >= ? AND price <= ?;";
            }
            ps = connection.prepareStatement(sql);
            
            if (minPrice == -1 && maxPrice != -1) {
                ps.setFloat(1, maxPrice);
            } else if (minPrice != -1 && maxPrice == -1) {
                ps.setFloat(1, minPrice);
            } else if (minPrice == -1 && maxPrice == -1) {
            } else {
                ps.setFloat(1, minPrice);
                ps.setFloat(2, maxPrice);
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                mobile = new Mobile(
                        rs.getString("mobileId"),
                        rs.getString("description"),
                        rs.getFloat("price"),
                        rs.getString("mobileName"),
                        rs.getInt("yearOfProduction"),
                        rs.getInt("quantity"),
                        rs.getInt("notSale"),
                        rs.getString("image")
                );
                mobileList.add(mobile);
            }
        } catch (Exception ex) {
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException se) {
                se.printStackTrace(); // or log it
            }
        }
        
        return mobileList;
    }
    
    public List<Mobile> getAllByIdAndName(String id, String name) {
        List<Mobile> mobileList = new ArrayList<Mobile>();
        Mobile mobile;
        String sql = "SELECT * FROM tbl_Mobile WHERE mobileId LIKE ? OR mobileName LIKE ?;";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, '%' + id + '%');
            ps.setString(2, '%' + name + '%');
            rs = ps.executeQuery();
            while (rs.next()) {
                mobile = new Mobile(
                        rs.getString("mobileId"),
                        rs.getString("description"),
                        rs.getFloat("price"),
                        rs.getString("mobileName"),
                        rs.getInt("yearOfProduction"),
                        rs.getInt("quantity"),
                        rs.getInt("notSale"),
                        rs.getString("image")
                );
                mobileList.add(mobile);
            }
        } catch (Exception ex) {
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException se) {
                se.printStackTrace(); // or log it
            }
        }
        
        return mobileList;
    }
    
    public List<Mobile> getBySearch(String SearchValue) {
        List<Mobile> mobileList = new ArrayList<Mobile>();
        String sql = "SELECT mobileId,description,price, mobileName,yearOfProduction,quantity, notSale,image FROM tbl_Mobile WHERE mobileName LIKE ? OR description LIKE ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, '%' + SearchValue + '%');
            ps.setString(2, '%' + SearchValue + '%');
            rs = ps.executeQuery();
            while (rs.next()) {
                Mobile mobile = new Mobile(
                        rs.getString("mobileId"),
                        rs.getString("description"),
                        rs.getFloat("price"),
                        rs.getString("mobileName"),
                        rs.getInt("yearOfProduction"),
                        rs.getInt("quantity"),
                        rs.getInt("notSale"),
                        rs.getString("image")
                );
                mobileList.add(mobile);
            }
        } catch (Exception ex) {
            ex.printStackTrace(); // or log it using a logger
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException se) {
                se.printStackTrace(); // or log it
            }
        }
        return mobileList;
    }
//cart related method

    public float getTotalCartValue(String userId) {
        float total = 0;
        String sql = "SELECT M.price, C.quantity FROM tbl_Cart C JOIN tbl_Mobile M ON C.mobileId = M.mobileId WHERE C.userId = ?;";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                float price = rs.getFloat("price");
                int quantity = rs.getInt("quantity");
                total += price * quantity;
            }
        } catch (Exception ex) {
        }
        return total;
    }
    
    public List<Cart> getCart(String userId) throws SQLException, ClassNotFoundException {
        List<Cart> cartList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtils.getConnection();
            
            String sql = "SELECT * FROM tbl_Cart WHERE [userId] = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, userId);
            rs = stm.executeQuery();
            
            while (rs.next()) {
                Cart cart = new Cart();
                cart.setCartId(rs.getInt("cartId"));
                cart.setUserId(rs.getString("userId"));
                cart.setMobileId(rs.getString("mobileId"));
                cart.setQuantity(rs.getInt("quantity"));
                cart.setName(getMobileName(cart.getMobileId()));
                cartList.add(cart);
            }
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            
            if (conn != null) {
                conn.close();
            }
            
        }
        return cartList;
    }
    
    public boolean addToCart(String userId, String mobileId) {
        String sqlCheck = "SELECT quantity FROM tbl_Cart WHERE userId = ? AND mobileId = ?;";
        String sqlUpdate = "UPDATE tbl_Cart SET quantity = quantity + 1 WHERE userId = ? AND mobileId = ?;";
        String sqlInsert = "INSERT INTO tbl_Cart (userId, mobileId, quantity) VALUES (?, ?, 1);";
        boolean response = true;
        try {
            connection = DBUtils.getConnection();
            // Check if the product is already in the cart
            ps = connection.prepareStatement(sqlCheck);
            ps.setString(1, userId);
            ps.setString(2, mobileId);
            rs = ps.executeQuery();
            if (rs.next()) {
                // If the product is in the cart, increment the quantity
                ps = connection.prepareStatement(sqlUpdate);
                ps.setString(1, userId);
                ps.setString(2, mobileId);
                response = ps.executeUpdate() > 0 ? true : false;
            } else {
                // If the product is not in the cart, add a new entry
                ps = connection.prepareStatement(sqlInsert);
                ps.setString(1, userId);
                ps.setString(2, mobileId);
                response = ps.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception ex) {
            // Handle exception
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException se) {
                se.printStackTrace(); // or log it
            }
        }
        return response;
    }
    
    public boolean removeFromCart(String userId, String mobileId) {
        String sql = "DELETE FROM tbl_Cart WHERE userId = ? AND mobileId = ?;";
        boolean response = true;
        
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, userId);
            ps.setString(2, mobileId);
            response = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception ex) {
            
            response = false;
        } finally {
            
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        
        return response;
    }
    
    public boolean updateQuantityInCart(String userId, String mobileId, int quantity) {
        String sql = "UPDATE tbl_Cart SET quantity = ? WHERE userId = ? AND mobileId = ?;";
        boolean response = false;
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setString(2, userId);
            ps.setString(3, mobileId);
            response = ps.executeUpdate() > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        return response;
    }
    
    public int getMobileQuantity(String mobileId) {
        int quantity = -1;
        String sql = "SELECT quantity FROM tbl_Mobile WHERE mobileId = ?;";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            
            ps.setString(1, mobileId);
            rs = ps.executeQuery();
            if (rs.next()) {
                quantity = rs.getInt("quantity");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        return quantity;
    }
    
    public String getMobileName(String mobileId) throws ClassNotFoundException, SQLException {
        String sql = "SELECT [mobileName] FROM [tbl_Mobile] WHERE [mobileId] = ?";
        String name = "";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            
            ps.setString(1, mobileId);
            rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("mobileName");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
            return name;
        }
    }
}
