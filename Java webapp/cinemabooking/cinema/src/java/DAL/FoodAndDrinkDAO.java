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
import model.FoodAndDrink;

/**
 *
 * @author MSI
 */
public class FoodAndDrinkDAO extends DBContext{

    Connection conn = null;
    PreparedStatement pre = null;
    ResultSet rs = null;

    public ArrayList<FoodAndDrink> listFAD() {
        ArrayList<FoodAndDrink> arr = new ArrayList<>();
        String sql = "select  * from  FastFood";
        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                FoodAndDrink fadList = new FoodAndDrink(rs.getInt(1), rs.getString(2),
                        rs.getString(3), rs.getFloat(4), rs.getString(5));
                arr.add(fadList);
            }
        } catch (Exception e) {
        }
        return arr;
    }

    public void addFoodAndDrink(FoodAndDrink fad) {
        String sql = "insert into FastFood (Category,FastFoodName,Price,[Image])\n"
                + "values (?,?,?,'image/FoodAndDrink/'+?)";
        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            pre.setString(1, fad.getCategory());
            pre.setString(2, fad.getFadName());
            pre.setFloat(3, fad.getPrice());
            pre.setString(4, fad.getImage());
            pre.executeUpdate();
        } catch (Exception e) {
            Logger.getLogger(FoodAndDrinkDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public FoodAndDrink getFoodAndDrink(int id) {
        try {
            /*Set up connection and Sql statement for Querry*/
            String sql = "SELECT * FROM FastFood where FastFoodId=?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            /*Querry and save in ResultSet*/
            rs = pre.executeQuery();
            while (rs.next()) {
                FoodAndDrink fd = new FoodAndDrink();
                fd.setFadId(rs.getInt(1));
                fd.setCategory(rs.getString(2));
                fd.setFadName(rs.getString(3));
                fd.setPrice(rs.getFloat(4));
                fd.setImage(rs.getString(5));
                return fd;
            }
        } catch (Exception e) {
            Logger.getLogger(FoodAndDrinkDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }

    public void updateFoodAndDrink(FoodAndDrink fad) {
        try {
            /*Set up connection and Sql statement for Query*/
            String sql = "UPDATE FastFood SET Category = ?,\n"
                    + " FastFoodName=?, Price=?, [Image]=?  \n"
                    + " WHERE FastFoodId=?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            pre.setString(1, fad.getCategory());
            pre.setString(2, fad.getFadName());
            pre.setFloat(3, fad.getPrice());
            pre.setString(4, fad.getImage());
            pre.setInt(5, fad.getFadId());
            /*Excute query and store it to check*/
            pre.executeQuery();
        } catch (Exception e) {
            Logger.getLogger(FoodAndDrinkDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void deleteFoodAndDrink(String id) {
        try {
            /*Set up connection and Sql statement for Query*/
            String sql = "DELETE FROM FastFood WHERE FastFoodId=?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            pre.setInt(1, Integer.parseInt(id));
            pre.executeQuery();
        } catch (Exception e) {
            Logger.getLogger(FoodAndDrinkDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public int totalFood() {
        String sql = "SELECT COUNT(*) as totalrow FROM FastFood ";
        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getInt("totalrow");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public ArrayList<FoodAndDrink> pagingFAD(int pageIndex) {
        ArrayList<FoodAndDrink> arr = new ArrayList<>();
        try {
            String sql = "SELECT * FROM\n"
                    + "(SELECT *, ROW_NUMBER() OVER (ORDER BY FastFoodId ASC) AS Seq\n"
                    + "FROM dbo.Fastfood)\n"
                    + "t WHERE Seq BETWEEN ? AND ?";

            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            pre.setInt(1, (pageIndex - 1) * 5 + 1);
            pre.setInt(2, (pageIndex - 1) * 5 + 5);
            rs = pre.executeQuery();
            while (rs.next()) {
                arr.add(new FoodAndDrink(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getFloat(4),
                        rs.getString(5)));
            }
        } catch (SQLException e) {
            Logger.getLogger(FoodAndDrinkDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return arr;
    }

    public String getImgFoodById(int id) {
        String query = "";
        try {
            /*Set up connection and Sql statement for Query*/
            query = "select image from FastFood where FastFoodId=?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setInt(1, id);

            rs = pre.executeQuery();

            if (rs.next()) {

                return rs.getString("image");
            }
        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(FoodAndDrinkDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return null;
    }

}
