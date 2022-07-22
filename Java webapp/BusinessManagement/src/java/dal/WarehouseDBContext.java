/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Warehouse;

/**
 *
 * @author Quan
 */
public class WarehouseDBContext extends DBContext {

    public void insertProduct(Warehouse a) {
        String sql = "INSERT INTO [dbo].[Warehouse]\n"
                + "           ([bid]\n"
                + "           ,[product]\n"
                + "           ,[time]\n"
                + "           ,[quantity])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,CURRENT_TIMESTAMP\n"
                + "           ,?)";
        PreparedStatement stm = null;
        try {

            stm = connection.prepareStatement(sql);
            stm.setString(1, a.getBid().getBid());
            stm.setString(2, a.getProduct());
            stm.setInt(3, a.getQuantity());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(WarehouseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(WarehouseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(WarehouseDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(WarehouseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    public void updateProduct(Warehouse s) {
        String sql = "UPDATE [dbo].[Warehouse]\n"
                + "   SET [time] = CURRENT_TIMESTAMP\n"
                + "      ,[quantity] = ?\n"
                + " WHERE bid=? and product=?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, s.getQuantity());
            stm.setString(2, s.getBid().getBid());
            stm.setString(3, s.getProduct().trim());
            stm.executeUpdate(); //INSERT UPDATE DELETE
        } catch (SQLException ex) {
            Logger.getLogger(WarehouseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(WarehouseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(WarehouseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    public Warehouse getProduct(String product, String bid) {
        try {
            String sql = "select * from Warehouse where bid=? and product=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, bid);
            stm.setString(2, product);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                Warehouse s = new Warehouse();
                Account acc = new Account();
                acc.setBid(rs.getString("bid"));
                s.setBid(acc);
                s.setNum(rs.getInt("num"));
                s.setProduct(rs.getString("product"));
                s.setTime(rs.getString("time"));
                s.setQuantity(rs.getInt("quantity"));

                return s;
            }
        } catch (SQLException ex) {
            Logger.getLogger(WarehouseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Warehouse> getProducts(int pageindex, int pagesize, String bid, String product) {
        ArrayList<Warehouse> ware = new ArrayList<>();
        String sql = "SELECT * FROM (SELECT *, ROW_NUMBER() OVER (ORDER BY product ASC) as row_index FROM Warehouse where bid=? and product like ?) tb\n"
                + "                        WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";
        if (product == null || product.trim() == "") {
            sql = "SELECT * FROM (SELECT *, ROW_NUMBER() OVER (ORDER BY product ASC) as row_index FROM Warehouse where bid=?) tb\n"
                    + "                        WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";

        }
        

        try {

            PreparedStatement stm = connection.prepareStatement(sql);
            if (product == null || product.trim() == "") {
                stm.setString(1, bid);
                stm.setInt(2, pageindex);
                stm.setInt(3, pagesize);
                stm.setInt(4, pageindex);
                stm.setInt(5, pagesize);
            } else {
                stm.setString(1, bid);
                stm.setString(2, "%" + product + "%");
                stm.setInt(3, pageindex);
                stm.setInt(4, pagesize);
                stm.setInt(5, pageindex);
                stm.setInt(6, pagesize);
            }
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Warehouse m = new Warehouse();
                Account acc = new Account();
                acc.setBid(rs.getString("bid"));
                m.setBid(acc);
                m.setProduct(rs.getString("product"));
                m.setQuantity(rs.getInt("quantity"));
                m.setNum(rs.getInt("num"));
                m.setTime(rs.getString("time").substring(0, 19));
                ware.add(m);
            }
        } catch (SQLException ex) {
            Logger.getLogger(WarehouseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ware;
    }

    public int count(String bid,String search) {
        try {
            String sql = "SELECT count(*) as total FROM Warehouse where bid=?";
            if(search!=null){
                sql = "SELECT count(*) as total FROM Warehouse where bid=? and product like ?";
            }
            PreparedStatement stm = connection.prepareStatement(sql);
            if(search==null){
            stm.setString(1, bid);
            }else{
                stm.setString(1, bid);
                stm.setString(2, "%"+search+"%");
            }
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(WarehouseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
    
    public int countM(String bid) {
        try {
            String sql = "SELECT count(*) as total FROM Warehouse where bid=? and month(time)=month(getdate())";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, bid);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(WarehouseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public void deleteProduct(int num) {
        String sql = "DELETE FROM [dbo].[Warehouse]\n"
                + " WHERE [num] = ? ";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, num);

            stm.executeUpdate(); //INSERT UPDATE DELETE
        } catch (SQLException ex) {
            Logger.getLogger(WarehouseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(WarehouseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(WarehouseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    public ArrayList<Warehouse> getProductsMonth(int pageindex, int pagesize, String bid) {
        ArrayList<Warehouse> ware = new ArrayList<>();
        String sql = "SELECT * FROM (SELECT *, ROW_NUMBER() OVER (ORDER BY product ASC) as row_index FROM Warehouse where bid=? and month(time)=month(getdate())) tb\n"
                + "                        WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";

        try {

            PreparedStatement stm = connection.prepareStatement(sql);

            stm.setString(1, bid);
            stm.setInt(2, pageindex);
            stm.setInt(3, pagesize);
            stm.setInt(4, pageindex);
            stm.setInt(5, pagesize);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Warehouse m = new Warehouse();
                Account acc = new Account();
                acc.setBid(rs.getString("bid"));
                m.setBid(acc);
                m.setProduct(rs.getString("product"));
                m.setQuantity(rs.getInt("quantity"));
                m.setNum(rs.getInt("num"));
                m.setTime(rs.getString("time").substring(0, 19));
                ware.add(m);
            }
        } catch (SQLException ex) {
            Logger.getLogger(WarehouseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ware;
    }

}
