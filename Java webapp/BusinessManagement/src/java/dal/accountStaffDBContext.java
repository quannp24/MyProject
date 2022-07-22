/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.AccountStaff;

/**
 *
 * @author Quan
 */
public class accountStaffDBContext extends DBContext {

    public AccountStaff getAccountStaff(String userStaff, String passStaff, String bid) {
        try {
            String sql = "select s.userStaff,s.passStaff,s.bid,s.displayname from Account_Staff s inner join Account a on a.bid=s.bid\n"
                    + "where userStaff=? and passStaff=? and a.bid=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, userStaff);
            stm.setString(2, passStaff);
            stm.setString(3, bid);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                AccountStaff accStaff = new AccountStaff();
                accStaff.setUserStaff(rs.getString("userStaff"));
                accStaff.setPassStaff(rs.getString("passStaff"));
                accStaff.setDisplayname(rs.getString("displayname"));
                Account acc = new Account();
                acc.setBid(rs.getString("bid"));
                accStaff.setBid(acc);
                return accStaff;
            }

        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
