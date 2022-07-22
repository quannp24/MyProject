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
import model.Bill;
import model.Import;

/**
 *
 * @author Quan
 */
public class ExpenseDBContext extends DBContext {

    public ArrayList<Bill> getBills(int pageindex, int pagesize, String bid, int year, int month, int day) { //
        ArrayList<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM (SELECT *, ROW_NUMBER() OVER (ORDER BY time desc) as row_index FROM Bill where bid=? ";
        PreparedStatement stm = null;
        try {
            if (year != 0 && month != 0 && day != 0) {
                sql += "and year(time)=? and month(time)=? and day(time)=?) tb WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";
            } else {
                sql += "and month(time)=month(getdate()) and year(time)=year(getdate())) tb WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";
            }

            stm = connection.prepareStatement(sql);
            if (year != 0 && month != 0 && day != 0) {
                stm.setString(1, bid);
                stm.setInt(2, year);
                stm.setInt(3, month);
                stm.setInt(4, day);
                stm.setInt(5, pageindex);
                stm.setInt(6, pagesize);
                stm.setInt(7, pageindex);
                stm.setInt(8, pagesize);
            } else {
                stm.setString(1, bid);
                stm.setInt(2, pageindex);
                stm.setInt(3, pagesize);
                stm.setInt(4, pageindex);
                stm.setInt(5, pagesize);
            }
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Bill m = new Bill();
                Account acc = new Account();
                acc.setBid(rs.getString("bid"));
                m.setBid(acc);
                m.setId(rs.getInt("id"));
                m.setBillcode(rs.getString("billcode"));
                m.setName(rs.getString("name"));
                m.setPhone(rs.getString("phone"));
                m.setAddress(rs.getString("address"));
                m.setPayment(rs.getInt("payment"));
                m.setPaytype(rs.getString("paytype"));
                m.setDebt(rs.getInt("debt"));
                m.setTotal(rs.getInt("total"));
                m.setTime(rs.getString("time") == null ? "" : rs.getString("time").substring(0, 19));
                bills.add(m);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return bills;
    }

    public ArrayList<Import> getImports(int pageindex, int pagesize, String bid, int year, int month, int day) { //
        ArrayList<Import> imports = new ArrayList<>();
        String sql = "SELECT * FROM (SELECT *, ROW_NUMBER() OVER (ORDER BY time desc) as row_index FROM Import where bid=? ";
        PreparedStatement stm = null;
        try {
            if (year != 0 && month != 0 && day != 0) {
                sql += "and year(time)=? and month(time)=? and day(time)=?) tb WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";
            } else {
                sql += "and month(time)=month(getdate()) and year(time)=year(getdate())) tb WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";
            }

            stm = connection.prepareStatement(sql);
            if (year != 0 && month != 0 && day != 0) {
                stm.setString(1, bid);
                stm.setInt(2, year);
                stm.setInt(3, month);
                stm.setInt(4, day);
                stm.setInt(5, pageindex);
                stm.setInt(6, pagesize);
                stm.setInt(7, pageindex);
                stm.setInt(8, pagesize);
            } else {
                stm.setString(1, bid);
                stm.setInt(2, pageindex);
                stm.setInt(3, pagesize);
                stm.setInt(4, pageindex);
                stm.setInt(5, pagesize);
            }
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Import m = new Import();
                Account acc = new Account();
                acc.setBid(rs.getString("bid"));
                m.setBid(acc);
                m.setIid(rs.getInt("iid"));
                m.setIname(rs.getString("iname"));
                m.setIphone(rs.getString("iphone"));
                m.setIaddress(rs.getString("iaddress"));
                m.setPayment(rs.getInt("payment"));
                m.setIconfirm(rs.getString("iconfirm"));
                m.setIdebt(rs.getInt("idebt"));
                m.setItotal(rs.getInt("itotal"));
                m.setTime(rs.getString("time") == null ? "" : rs.getString("time").substring(0, 19));
                imports.add(m);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return imports;
    }

    public int count(String bid, int year, int month, int day) {
        String sql = "SELECT count(*) as total FROM Bill where bid=? ";
        PreparedStatement stm = null;
        try {
            if (year != 0 && month != 0 && day != 0) {
                sql += "and year(time)=? and month(time)=? and day(time)=?";
            } else {
                sql += "and month(time)=month(getdate()) and year(time)=year(getdate())";
            }
            stm = connection.prepareStatement(sql);
            if (year != 0 && month != 0 && day != 0) {
                stm.setString(1, bid);
                stm.setInt(2, year);
                stm.setInt(3, month);
                stm.setInt(4, day);
            } else {
                stm.setString(1, bid);
            }
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return -1;
    }

    public int countI(String bid, int year, int month, int day) {
        String sql = "SELECT count(*) as total FROM Import where bid=? ";
        PreparedStatement stm = null;
        try {
            if (year != 0 && month != 0 && day != 0) {
                sql += "and year(time)=? and month(time)=? and day(time)=?";
            } else {
                sql += "and month(time)=month(getdate()) and year(time)=year(getdate())";
            }
            stm = connection.prepareStatement(sql);
            if (year != 0 && month != 0 && day != 0) {
                stm.setString(1, bid);
                stm.setInt(2, year);
                stm.setInt(3, month);
                stm.setInt(4, day);
            } else {
                stm.setString(1, bid);
            }
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return -1;
    }

    public int sum(String bid, int year, int month, int day) {
        String sql = "SELECT sum(total) as total FROM Bill where bid=? ";
        PreparedStatement stm = null;
        try {
            if (year != 0 && month != 0 && day != 0) {
                sql += "and year(time)=? and month(time)=? and day(time)=?";
            } else {
                sql += "and month(time)=month(getdate()) and year(time)=year(getdate())";
            }
            stm = connection.prepareStatement(sql);
            if (year != 0 && month != 0 && day != 0) {
                stm.setString(1, bid);
                stm.setInt(2, year);
                stm.setInt(3, month);
                stm.setInt(4, day);
            } else {
                stm.setString(1, bid);
            }
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return 0;
    }

    public int sumI(String bid, int year, int month, int day) {
        String sql = "SELECT sum(itotal) as total FROM Import where bid=? ";
        PreparedStatement stm = null;
        try {
            if (year != 0 && month != 0 && day != 0) {
                sql += "and year(time)=? and month(time)=? and day(time)=?";
            } else {
                sql += "and month(time)=month(getdate()) and year(time)=year(getdate())";
            }
            stm = connection.prepareStatement(sql);
            if (year != 0 && month != 0 && day != 0) {
                stm.setString(1, bid);
                stm.setInt(2, year);
                stm.setInt(3, month);
                stm.setInt(4, day);
            } else {
                stm.setString(1, bid);
            }
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ExpenseDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return 0;
    }
}
