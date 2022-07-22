/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;

/**
 *
 * @author Quan
 */
public class CartDAO extends DBContext {

    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;
    private String query;

    public ArrayList<Cart> getMyOrderByName(int accId, int pageIndex) {
        ArrayList<Cart> cartList = new ArrayList<>();
        try {
            /*Set up connection and Sql statement for Query*/

            query = "SELECT * FROM ( SELECT *, ROW_NUMBER() OVER (ORDER BY cartId desc) AS Seq\n"
                    + "FROM Cart where accountId = ?)t WHERE Seq BETWEEN ? AND ?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, accId);
            ps.setInt(2, (pageIndex - 1) * 5 + 1);
            ps.setInt(3, (pageIndex - 1) * 5 + 5);
            /*Query and save in ResultSet*/
            rs = ps.executeQuery();

            /*Assign data to an arraylist of Account*/
            while (rs.next()) {
                cartList.add(new Cart(
                        rs.getInt("CartId"),
                        rs.getInt("AccountId"),
                        rs.getFloat("TotalPrice"),
                        rs.getString("Status"),
                        rs.getDate("OrderDate"),
                        rs.getString("QRcode")
                ));
            }
        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return cartList;
    }

    public ArrayList<Cart> getCartByStatus(int status, int accId, int pageIndex) {
        ArrayList<Cart> cartList = new ArrayList<>();
        try {
            /*Set up connection and Sql statement for Query*/
            if (status > 1) {
                query = "SELECT * FROM ( SELECT *, ROW_NUMBER() OVER (ORDER BY cartId desc) AS Seq\n"
                        + "FROM Cart where accountId = ? )t WHERE Seq BETWEEN ? AND ?";
            } else {
                query = "SELECT * FROM ( SELECT *, ROW_NUMBER() OVER (ORDER BY cartId desc) AS Seq\n"
                        + "FROM Cart where accountId = ? and status=?)t WHERE Seq BETWEEN ? AND ?";
            }
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            if (status > 1) {
                ps.setInt(1, accId);
                ps.setInt(2, (pageIndex - 1) * 5 + 1);
                ps.setInt(3, (pageIndex - 1) * 5 + 5);
            } else {
                ps.setInt(1, accId);
                ps.setInt(2, status);
                ps.setInt(3, (pageIndex - 1) * 5 + 1);
                ps.setInt(4, (pageIndex - 1) * 5 + 5);
            }

            /*Query and save in ResultSet*/
            rs = ps.executeQuery();

            /*Assign data to an arraylist of Account*/
            while (rs.next()) {
                cartList.add(new Cart(
                        rs.getInt("CartId"),
                        rs.getInt("AccountId"),
                        rs.getFloat("TotalPrice"),
                        rs.getString("Status"),
                        rs.getDate("OrderDate"),
                        rs.getString("QRcode")
                ));
            }
        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return cartList;
    }

    public ArrayList<Cart> getMyOrderByDate(String date, int accId, int pageIndex) {
        ArrayList<Cart> cartList = new ArrayList<>();
        try {
            /*Set up connection and Sql statement for Query*/

            query = "SELECT * FROM ( SELECT *, ROW_NUMBER() OVER (ORDER BY cartId desc) AS Seq\n"
                    + "FROM Cart where accountId = ? and OrderDate=? )t WHERE Seq BETWEEN ? AND ?";

            con = new DBContext().connection;
            ps = con.prepareStatement(query);

            ps.setInt(1, accId);
            ps.setString(2, date);
            ps.setInt(3, (pageIndex - 1) * 5 + 1);
            ps.setInt(4, (pageIndex - 1) * 5 + 5);


            /*Query and save in ResultSet*/
            rs = ps.executeQuery();

            /*Assign data to an arraylist of Account*/
            while (rs.next()) {
                cartList.add(new Cart(
                        rs.getInt("CartId"),
                        rs.getInt("AccountId"),
                        rs.getFloat("TotalPrice"),
                        rs.getString("Status"),
                        rs.getDate("OrderDate"),
                        rs.getString("QRcode")
                ));
            }
        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return cartList;
    }

    public int getTotalOrder(int accId) {
        try {
            /*Set up connection and Sql statement for Query*/
            query = "select count(*) from Cart where accountId = ?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, accId);
            /*Excute query and store it to check*/
            rs = ps.executeQuery();

            while (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return 0;
    }

    public int getCartID() {
        try {
            /*Set up connection and Sql statement for Query*/
            query = "select top(1) CartId from Cart order by CartId desc";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            /*Excute query and store it to check*/
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return 0;
    }

    public int getTotalOrderByDate(String date, int accId) {
        try {
            /*Set up connection and Sql statement for Query*/
            query = "select count(*) from Cart where accountId = ? and OrderDate=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, accId);
            ps.setString(2, date);
            /*Excute query and store it to check*/
            rs = ps.executeQuery();

            while (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return 0;
    }
    
    public Cart getCartById(int cartId,int accId) {
        try {
            /*Set up connection and Sql statement for Query*/
            query = "select * from Cart where accountId = ? and cartId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, cartId);
            ps.setInt(2, accId);
            /*Excute query and store it to check*/
            rs = ps.executeQuery();
            Cart c = new Cart();
            if (rs.next()) {
                
                c.setCartId(rs.getInt("CartId"));
                c.setAccountId(rs.getInt("AccountId"));
                c.setOrderDate(rs.getDate("OrderDate"));
                c.setTotalPrice(rs.getInt("TotalPrice"));
                c.setStatus(rs.getString("Status"));
                c.setQRcode(rs.getString("QRcode"));
            }
            return c;

        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return null;
    }

    public int getTotalOrderByStatus(int accId, int status) {
        try {
            /*Set up connection and Sql statement for Query*/
            if (status > 1) {
                query = "select count(*) from Cart where accountId = ? ";
            } else {
                query = "select count(*) from Cart where accountId = ? and status=?";
            }
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            if (status > 1) {
                ps.setInt(1, accId);
            } else {
                ps.setInt(1, accId);
                ps.setInt(2, status);
            }
            /*Excute query and store it to check*/
            rs = ps.executeQuery();

            while (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return 0;
    }

    public ArrayList<Integer> getCartExpired(int accId) {
        ArrayList<Integer> list = new ArrayList<>();
        try {
            /*Set up connection and Sql statement for Query*/

            query = "select DISTINCT  c.*from cart c join SeatRoomCart sc on c.CartId=sc.CartId\n"
                    + "                    					join SeatRoom s on sc.SeatRoomId=s.SeatRoomId\n"
                    + "                   				join TimeRoom t on t.TimeRoomId=s.TimeRoomId\n"
                    + "                    					join MovieTime m on t.MovieTimeId=m.MovieTimeId\n"
                    + "                    					join DateRoom d on d.DateRoomID=m.DateRoomID\n"
                    + "                    					where c.status=1 and AccountId=? and \n"
                    + "										year(DateRoom)<= year (CURRENT_TIMESTAMp) and month(DateRoom)<= month (CURRENT_TIMESTAMp)\n"
                    + "										and day(DateRoom)<= day (CURRENT_TIMESTAMp)\n"
                    + "                    	                 and datepart(hh,finish)<=datepart(hh,CURRENT_TIMESTAMp)\n"
                    + "                    					and datepart(mi,finish)<=datepart(mi,CURRENT_TIMESTAMp)";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, accId);
            /*Query and save in ResultSet*/
            rs = ps.executeQuery();

            /*Assign data to an arraylist of Account*/
            while (rs.next()) {
                list.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return list;
    }

    public ArrayList<Integer> getCartByStatus(int accId) {
        ArrayList<Integer> list = new ArrayList<>();
        try {
            /*Set up connection and Sql statement for Query*/

            query = "select DISTINCT CartId from cart where status=1 and AccountId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, accId);
            /*Query and save in ResultSet*/
            rs = ps.executeQuery();

            /*Assign data to an arraylist of Account*/
            while (rs.next()) {
                list.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return list;
    }

    public int updateStatusByCartId(int cartId) {
        try {
            /*Set up connection and Sql statement for Query*/

            query = "UPDATE [dbo].[Cart]\n"
                    + "   SET [Status] = 0\n"
                    + " WHERE CartId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, cartId);
            return ps.executeUpdate();

        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return 0;
    }

    public Cart getOrderByCartId(int cartId, int accId) {
        try {

            query = "select * from cart where cartId=? and AccountId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, cartId);
            ps.setInt(2, accId);

            /*Query and save in ResultSet*/
            rs = ps.executeQuery();

            /*Assign data to an arraylist of Account*/
            if (rs.next()) {
                Cart c = (new Cart(
                        rs.getInt("CartId"),
                        rs.getInt("AccountId"),
                        rs.getFloat("TotalPrice"),
                        rs.getString("Status"),
                        rs.getDate("OrderDate"),
                        rs.getString("QRcode")
                ));
                return c;
            }

        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return null;
    }

    public int AddCart(int accId, double total, String img) {
        try {
            /*Set up connection and Sql statement for Query*/

            query = "INSERT INTO [dbo].[Cart]\n"
                    + "           ([AccountId]\n"
                    + "           ,[OrderDate]\n"
                    + "           ,[TotalPrice]\n"
                    + "           ,[Status]\n"
                    + "           ,[QRcode])\n"
                    + "     VALUES (?,CURRENT_TIMESTAMP,?,1,?)";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, accId);
            ps.setDouble(2, total);
            ps.setString(3, img);
            int check = ps.executeUpdate();
            if (check != 0) {
                query = "select top(1) CartId from Cart where AccountId=? order by CartId desc\n";
                ps = con.prepareStatement(query);
                ps.setInt(1, accId);
                rs = ps.executeQuery();
                if (rs.next()) {
                    return rs.getInt("CartId");
                }
            }

        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return 0;
    }
}
