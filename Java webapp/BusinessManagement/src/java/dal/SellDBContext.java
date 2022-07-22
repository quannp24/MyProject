/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import controller.sell.listBillController;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Bill;
import model.BillDebt;
import model.BillDetail;
import model.Import;

/**
 *
 * @author Quan
 */
public class SellDBContext extends DBContext {

    public void insertBill(Bill b, ArrayList<BillDetail> list, BillDebt d) {
        String sql = "INSERT INTO [dbo].[Bill]\n"
                + "           ([billcode]\n"
                + "           ,[bid]\n"
                + "           ,[name]\n"
                + "           ,[phone]\n"
                + "           ,[address]\n"
                + "           ,[payment]\n"
                + "		   ,[debt]\n"
                + "		   ,[total]\n"
                + "		   ,[time]\n"
                + "           ,[paytype])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "		   ,?\n"
                + "		   ,?\n"
                + "		   ,CURRENT_TIMESTAMP\n"
                + "           ,?)";
        PreparedStatement stm = null;
        try {
            connection.setAutoCommit(false);
            stm = connection.prepareStatement(sql);
            stm.setString(1, b.getBillcode());
            stm.setString(2, b.getBid().getBid());
            stm.setString(3, b.getName());
            stm.setString(4, b.getPhone());
            stm.setString(5, b.getAddress());
            stm.setInt(6, b.getPayment());
            stm.setInt(7, b.getDebt());
            stm.setInt(8, b.getTotal());
            stm.setString(9, b.getPaytype());
            stm.executeUpdate(); //INSERT UPDATE DELETE
            for (BillDetail detail : list) {
                String insert_detail = "INSERT INTO [dbo].[BillDetail]\n"
                        + "           ([bid]\n"
                        + "           ,[billcode]\n"
                        + "           ,[product]\n"
                        + "           ,[quantity]\n"
                        + "           ,[unitprice]\n"
                        + "           ,[price]\n"
                        + "           ,[idbill]\n"
                        + "           ,[describe])\n"
                        + "     VALUES\n"
                        + "           (?\n"
                        + "           ,?\n"
                        + "           ,?\n"
                        + "           ,?\n"
                        + "           ,?\n"
                        + "           ,?\n"
                        + "           ,?\n"
                        + "           ,?)";
                PreparedStatement stm_detail = connection.prepareStatement(insert_detail);
                stm_detail.setString(1, detail.getBid().getBid());
                stm_detail.setString(2, detail.getBillcode().getBillcode());
                stm_detail.setString(3, detail.getProduct());
                stm_detail.setInt(4, detail.getQuantity());
                stm_detail.setInt(5, detail.getUnitprice());
                stm_detail.setInt(6, detail.getPrice());
                stm_detail.setInt(7, detail.getIdbill().getId());
                stm_detail.setString(8, detail.getDescribe());
                stm_detail.executeUpdate();
            }
            String add = "INSERT INTO [dbo].[BillDebt]\n"
                    + "           ([idbill]\n"
                    + "           ,[status]\n"
                    + "           ,[time])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,CURRENT_TIMESTAMP)";
            PreparedStatement stm_add = connection.prepareStatement(add);
            stm_add.setInt(1, d.getIdbill().getId());
            stm_add.setBoolean(2, d.isStatus());
            stm_add.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    public String getBillcode(String bid) {
        String re = "";
        try {
            String sql = "select top(1) billcode from Bill where bid=? order by billcode desc";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, bid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                re = rs.getString("billcode");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return re;
    }

    public int getIdbill(String bid) {
        int re;
        try {
            String sql = "select top(1) id from Bill where bid=? order by time desc";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, bid);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                re = rs.getInt("id");
                return re;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public ArrayList<Bill> getBills(int pageindex, int pagesize, String bid, String name, int filter) { //
        ArrayList<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM (SELECT *, ROW_NUMBER() OVER (ORDER BY time desc) as row_index FROM Bill where bid=? ";
        try {
            if (name.trim().length() < 1) {
                switch (filter) {
                    case 1:
                        sql += "and not debt=0) tb WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";
                        break;
                    case 2:
                        sql += "and month(time)=month(getdate())) tb WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";
                        break;
                    default:
                        sql += ") tb WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";
                        break;
                }
            } else {
                switch (filter) {
                    case 1:
                        sql += "and name like ? and not debt=0) tb WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";
                        break;
                    case 2:
                        sql += "and name like ? and month(time)=month(getdate())) tb WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";
                        break;
                    default:
                        sql += "and name like ?) tb WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";
                        break;
                }
            }
            PreparedStatement stm = connection.prepareStatement(sql);
            if (name.trim().length() < 1) {
                stm.setString(1, bid);
                stm.setInt(2, pageindex);
                stm.setInt(3, pagesize);
                stm.setInt(4, pageindex);
                stm.setInt(5, pagesize);
            } else {
                stm.setString(1, bid);
                stm.setString(2, "%" + name + "%");
                stm.setInt(3, pageindex);
                stm.setInt(4, pagesize);
                stm.setInt(5, pageindex);
                stm.setInt(6, pagesize);
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
            Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return bills;
    }

    public int count(String bid, String name, int filter) {
        try {
            String sql = "SELECT count(*) as total FROM Bill where bid=? ";
            if (name.trim().length() < 1) {
                switch (filter) {
                    case 1:
                        sql += "and NOT debt=0";
                        break;
                    case 2:
                        sql += "and month(time)=month(getdate())";
                        break;
                    default:
                        break;
                }
            } else {
                switch (filter) {
                    case 1:
                        sql += "and name like ? and not debt=0";
                        break;
                    case 2:
                        sql += "and name like ? and month(time)=month(getdate())";
                        break;
                    default:
                        sql += "and name like ?";
                }
            }
            PreparedStatement stm = connection.prepareStatement(sql);
            if (name.trim().length() < 1) {
                stm.setString(1, bid);
            } else {
                stm.setString(1, bid);
                stm.setString(2, "%" + name + "%");
            }
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public ArrayList<BillDetail> getBillDetail(String billcode, String bid) {
        ArrayList<BillDetail> detail = new ArrayList<>();
        try {
            String sql = "select bid,billcode,product,quantity,unitprice,price,describe,num,idbill from BillDetail where billcode=? and bid=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, billcode);
            stm.setString(2, bid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                BillDetail d = new BillDetail();
                Account acc = new Account();
                acc.setBid(rs.getString("bid"));
                d.setBid(acc);
                Bill b = new Bill();
                b.setId(rs.getInt("idbill"));
                b.setBillcode(rs.getString("billcode"));
                d.setIdbill(b);
                d.setBillcode(b);
                d.setProduct(rs.getString("product"));
                d.setQuantity(rs.getInt("quantity"));
                d.setUnitprice(rs.getInt("unitprice"));
                d.setPrice(rs.getInt("price"));
                d.setDescribe(rs.getString("describe"));
                d.setNum(rs.getInt("num"));
                detail.add(d);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return detail;
    }

    public Bill getBill(String billcode, String bid) {

        try {
            String sql = "select billcode,bid,name,phone,address,payment,paytype,debt,total,time,id from Bill where billcode=? and bid=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, billcode);
            stm.setString(2, bid);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Bill b = new Bill();
                Account acc = new Account();
                acc.setBid(rs.getString("bid").trim());
                b.setBid(acc);
                b.setId(rs.getInt("id"));
                b.setBillcode(rs.getString("billcode").trim());
                b.setName(rs.getString("name"));
                b.setPhone(rs.getString("phone").trim());
                b.setAddress(rs.getString("address"));
                b.setPayment(rs.getInt("payment"));
                b.setPaytype(rs.getString("paytype"));
                b.setDebt(rs.getInt("debt"));
                b.setTotal(rs.getInt("total"));
                b.setTime(rs.getString("time") == null ? "" : rs.getString("time").substring(0, 19));
                return b;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void deleteBill(int id) {
        String sql = "DELETE FROM [dbo].[Bill]\n"
                + " WHERE [id] = ? ";
        PreparedStatement stm = null;
        try {
            connection.setAutoCommit(false);
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);

//            stm.executeUpdate(); //INSERT UPDATE DELETE
            String del = "DELETE FROM [dbo].[BillDetail]\n"
                    + " WHERE [idbill] = ?";
            PreparedStatement stm_del = connection.prepareStatement(del);
            stm_del.setInt(1, id);
            stm_del.executeUpdate();
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    public void updateBill(Bill b, ArrayList<BillDetail> d, String billcode, String bid) {
        String sql = "UPDATE [dbo].[Bill]\n"
                + "   SET [name] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[address] = ?\n"
                + "      ,[payment] = ?\n"
                + "      ,[paytype] = ?\n"
                + "      ,[debt] = ?\n"
                + "      ,[total] = ?\n"
                + " WHERE billcode=? and bid=?";
        PreparedStatement stm = null;
        try {
            connection.setAutoCommit(false);
            stm = connection.prepareStatement(sql);
            stm.setString(1, b.getName());
            stm.setString(2, b.getPhone());
            stm.setString(3, b.getAddress());
            stm.setInt(4, b.getPayment());
            stm.setString(5, b.getPaytype());
            stm.setInt(6, b.getDebt());
            stm.setInt(7, b.getTotal());
            stm.setString(8, billcode);
            stm.setString(9, bid);
            stm.executeUpdate(); //INSERT UPDATE DELETE

            for (BillDetail detail : d) {
                String up = "UPDATE [dbo].[BillDetail]\n"
                        + "   SET [product] = ?\n"
                        + "      ,[quantity] = ?\n"
                        + "      ,[unitprice] = ?\n"
                        + "      ,[price] = ?\n"
                        + "      ,[describe] = ?\n"
                        + " WHERE bid=? and billcode=? and num=?";
                PreparedStatement stm_update = connection.prepareStatement(up);
                stm_update.setString(1, detail.getProduct());
                stm_update.setInt(2, detail.getQuantity());
                stm_update.setInt(3, detail.getUnitprice());
                stm_update.setInt(4, detail.getPrice());
                stm_update.setString(5, detail.getDescribe());
                stm_update.setString(6, bid);
                stm_update.setString(7, billcode);
                stm_update.setInt(8, detail.getNum());
                stm_update.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

        }
    }

    public void setDebt(int id, int payment) {
        String sql = "UPDATE [dbo].[Bill]\n"
                + "   SET [payment] = ?\n"
                + "      ,[debt] = ?\n"
                + " WHERE id=?";
        PreparedStatement stm = null;
        try {
            connection.setAutoCommit(false);
            stm = connection.prepareStatement(sql);
            stm.setInt(1, payment);
            stm.setInt(2, 0);
            stm.setInt(3, id);
            stm.executeUpdate(); //INSERT UPDATE DELETE
            String up = "UPDATE [dbo].[BillDebt]\n"
                    + "   SET [time] = CURRENT_TIMESTAMP\n"
                    + "   ,[status] = 0\n"
                    + " WHERE idbill=?";
            PreparedStatement stm_update = connection.prepareStatement(up);
            stm_update.setInt(1, id);
            stm_update.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

        }
    }

    public BillDebt getBillDebt(int idbill) {

        try {
            String sql = "select idbill,status,time from BillDebt where idbill=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, idbill);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                BillDebt bd = new BillDebt();
                Bill b = new Bill();
                b.setId(rs.getInt("idbill"));
                bd.setIdbill(b);
                bd.setStatus(rs.getBoolean("status"));
                bd.setTime(rs.getString("time").substring(0, 19));
                return bd;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SellDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public ArrayList<Integer> getNum(String bid,String billcode) {
        ArrayList<Integer> list = new ArrayList<>();
        try {
            String sql = "select num from BillDetail where bid=? and billcode=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, bid.trim());
            stm.setString(2, billcode.trim());
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int num = rs.getInt("num");
                list.add(num);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

}
