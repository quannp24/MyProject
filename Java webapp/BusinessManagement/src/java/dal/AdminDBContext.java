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
import model.AccountStaff;

/**
 *
 * @author Quan
 */
public class AdminDBContext extends DBContext {

    public ArrayList<AccountStaff> getStaffs(String bid) {
        ArrayList<AccountStaff> staffs = new ArrayList<>();
        try {
            String sql = "select userStaff,passStaff,displayname,bid from Account_Staff where bid=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, bid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                AccountStaff acc = new AccountStaff();
                Account a = new Account();
                a.setBid(rs.getString("bid"));
                acc.setBid(a);
                acc.setDisplayname(rs.getString("displayname"));
                acc.setUserStaff(rs.getString("userStaff"));
                acc.setPassStaff(rs.getString("passStaff"));
                staffs.add(acc);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return staffs;
    }

    public void insertStaff(AccountStaff a) {
        String sql = "INSERT INTO [dbo].[Account_Staff]\n"
                + "           ([userStaff]\n"
                + "           ,[passStaff]\n"
                + "           ,[bid]\n"
                + "           ,[displayname])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?)";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, a.getUserStaff());
            stm.setString(2, a.getPassStaff());
            stm.setString(3, a.getBid().getBid());
            stm.setString(4, a.getDisplayname());
            stm.executeUpdate(); //INSERT UPDATE DELETE
        } catch (SQLException ex) {
            Logger.getLogger(AdminDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(AdminDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(AdminDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }
    
    public boolean checkUserStaff(String username,String bid) {  //check user đã tồn tại thì true, chưa thì false
        
        try {
            String sql = "SELECT userStaff FROM Account_Staff where userStaff=? and bid=?";
            
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, bid);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AdminDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public void DeleteStaff(String bid, String userstaff) {
        String sql = "DELETE FROM [dbo].[Account_Staff]\n"
                + " WHERE [bid] = ? and userStaff=? ";
        PreparedStatement stm = null;
        try {
            
            stm = connection.prepareStatement(sql);
            stm.setString(1, bid);
            stm.setString(2, userstaff);

            stm.executeUpdate(); //INSERT UPDATE DELETE
        } catch (SQLException ex) {
            Logger.getLogger(AdminDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(AdminDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(AdminDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }
}
