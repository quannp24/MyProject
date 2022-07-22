/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.FastFoodCart;
import model.FoodAndDrink;

/**
 *
 * @author Quan
 */
public class FastFoodCartDAO extends DBContext {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String query = null;

    public ArrayList<FastFoodCart> getFoodByCartId(int cartId, int accId) {
        ArrayList<FastFoodCart> list = new ArrayList<>();
        try {
            /*Set up connection and Sql statement for Query*/

            query = "select f.*  from cart c join FastFoodCart f on c.CartId=f.CartId\n"
                    + "where c.CartId=? and AccountId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, cartId);
            ps.setInt(2, accId);

            /*Query and save in ResultSet*/
            rs = ps.executeQuery();

            /*Assign data to an arraylist of Account*/
            while (rs.next()) {
                list.add(new FastFoodCart(rs.getInt("FastFoodCartId"), rs.getInt("FastFoodId"), rs.getInt("Quantity"), rs.getInt("CartId")));
            }
        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(SeatDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return list;
    }

    public FoodAndDrink getFoodByFastFoodId(int fastfoodId) {

        try {
            /*Set up connection and Sql statement for Query*/

            query = "select *  from FastFood where FastFoodId=? ";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, fastfoodId);


            /*Query and save in ResultSet*/
            rs = ps.executeQuery();

            /*Assign data to an arraylist of Account*/
            if (rs.next()) {
                FoodAndDrink fd = new FoodAndDrink(rs.getInt("FastFoodId"), rs.getString("Category"), rs.getString("FastFoodName"), rs.getFloat("Price"), rs.getString("Image"));
                return fd;
            }
        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(SeatDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return null;
    }

    public void AddFastFoodCart(int cartId, ArrayList<FastFoodCart> listFood) {
        try {
            /*Set up connection and Sql statement for Query*/

            query = "INSERT INTO [dbo].[FastFoodCart]\n"
                    + "           ([FastFoodId]\n"
                    + "           ,[Quantity]\n"
                    + "           ,[CartId])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?)";
            con = new DBContext().connection;
            connection.setAutoCommit(false);
            for (FastFoodCart food : listFood) {
                ps = con.prepareStatement(query);
                ps.setInt(1, food.getFastfoodId());
                ps.setInt(2, food.getQuantity());
                ps.setInt(3, cartId);
                ps.executeUpdate();
            }

        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        try {
            connection.setAutoCommit(true);
        } catch (SQLException ex) {
            Logger.getLogger(FastFoodCartDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
    }
}
