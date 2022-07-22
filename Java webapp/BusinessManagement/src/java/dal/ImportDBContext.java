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
import model.Import;
import model.ImportDebt;
import model.ImportDetail;

/**
 *
 * @author Quan
 */
public class ImportDBContext extends DBContext {

    public void insertImport(Import a, ArrayList<ImportDetail> m,ImportDebt d) {
        String sql = "INSERT INTO [dbo].[Import]\n"
                + "           ([iid]\n"
                + "           ,[bid]\n"
                + "           ,[iname]\n"
                + "           ,[iphone]\n"
                + "           ,[iaddress]\n"
                + "           ,[iconfirm]\n"
                + "           ,[itotal]\n"
                + "           ,[idebt]\n"
                + "           ,[payment]\n"
                + "           ,[time])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,CURRENT_TIMESTAMP)";
        PreparedStatement stm = null;
        try {
            connection.setAutoCommit(false);
            stm = connection.prepareStatement(sql);
            stm.setInt(1, a.getIid());
            stm.setString(2, a.getBid().getBid().trim());
            stm.setString(3, a.getIname());
            stm.setString(4, a.getIphone());
            stm.setString(5, a.getIaddress());
            stm.setString(6, a.getIconfirm());
            stm.setInt(7, a.getItotal());
            stm.setInt(8, a.getIdebt());
            stm.setInt(9, a.getPayment());
            stm.executeUpdate(); //INSERT UPDATE DELETE
            for (ImportDetail detail : m) {
                String insert_detail = "insert into ImportDetail(iid,product,quantity,unitprice,price,describe) values(?,?,?,?,?,?)";
                PreparedStatement stm_insert_detail
                        = connection.prepareStatement(insert_detail);
                stm_insert_detail.setInt(1, detail.getIid().getIid());
                stm_insert_detail.setString(2, detail.getIproduct());
                stm_insert_detail.setInt(3, detail.getIquantity());
                stm_insert_detail.setInt(4, detail.getIunitprice());
                stm_insert_detail.setInt(5, detail.getIprice());
                stm_insert_detail.setString(6, detail.getIdescribe());
                stm_insert_detail.executeUpdate();
            }
            String add = "INSERT INTO [dbo].[ImportDebt]\n"
                    + "           ([iid]\n"
                    + "           ,[status]\n"
                    + "           ,[time])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,CURRENT_TIMESTAMP)";
            PreparedStatement stm_add = connection.prepareStatement(add);
            stm_add.setInt(1, d.getIid().getIid());
            stm_add.setBoolean(2, d.isStatus());
            stm_add.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    public int getIid() {
        int count = 0;
        try {
            String sql = "SELECT top(1) iid FROM Import order by iid desc";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                count = rs.getInt("iid");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count + 1;
    }

    public ArrayList<Import> getImports(int pageindex, int pagesize, String bid, String name, int filter) { //
        ArrayList<Import> imports = new ArrayList<>();
        String sql = "SELECT * FROM (SELECT *, ROW_NUMBER() OVER (ORDER BY time desc) as row_index FROM import where bid=? ";
        try {
            if (name.trim().length() < 1) {
                switch (filter) {
                    case 1:
                        sql += "and not idebt=0) tb WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";
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
                        sql += "and iname like ? and not idebt=0) tb WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";
                        break;
                    case 2:
                        sql += "and iname like ? and month(time)=month(getdate())) tb WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";
                        break;
                    default:
                        sql += "and iname like ?) tb WHERE row_index >=(?-1)* ? +1 AND row_index <= ? * ?";
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
                Import m = new Import();
                Account acc = new Account();
                acc.setBid(rs.getString("bid"));
                m.setBid(acc);
                m.setIid(rs.getInt("iid"));
                m.setIname(rs.getString("iname"));
                m.setIphone(rs.getString("iphone"));
                m.setIaddress(rs.getString("iaddress"));
                m.setIconfirm(rs.getString("iconfirm"));
                m.setPayment(rs.getInt("payment"));
                m.setIdebt(rs.getInt("idebt"));
                m.setItotal(rs.getInt("itotal"));
                m.setTime(rs.getString("time") == null ? "" : rs.getString("time").substring(0, 19));
                imports.add(m);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return imports;
    }

    public int count(String bid, String name, int filter) {
        try {
            String sql = "SELECT count(*) as total FROM Import where bid=? ";
            if (name.trim().length() < 1) {
                switch (filter) {
                    case 1:
                        sql += "and NOT idebt=0";
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
                        sql += "and iname like ? and not idebt=0";
                        break;
                    case 2:
                        sql += "and iname like ? and month(time)=month(getdate())";
                        break;
                    default:
                        sql += "and iname like ?";
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
            Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public ArrayList<ImportDetail> getImportDetail(int iid) {
        ArrayList<ImportDetail> detail = new ArrayList<>();
        try {
            String sql = "select iid,product,quantity,unitprice,price,describe,num from ImportDetail where iid=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, iid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                ImportDetail d = new ImportDetail();
                Import i = new Import();
                i.setIid(rs.getInt("iid"));
                d.setIid(i);
                d.setIproduct(rs.getString("product"));
                d.setIquantity(rs.getInt("quantity"));
                d.setIunitprice(rs.getInt("unitprice"));
                d.setIprice(rs.getInt("price"));
                d.setIdescribe(rs.getString("describe"));
                d.setNum(rs.getInt("num"));

                detail.add(d);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return detail;
    }

    public Import getImport(int iid) {

        try {
            String sql = "select iid,bid,iname,iphone,iaddress,iconfirm,itotal,idebt,payment,time from Import where iid=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, iid);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Import b = new Import();
                Account acc = new Account();
                acc.setBid(rs.getString("bid").trim());
                b.setBid(acc);
                b.setIid(rs.getInt("iid"));
                b.setIname(rs.getString("iname"));
                b.setIphone(rs.getString("iphone").trim());
                b.setIaddress(rs.getString("iaddress"));
                b.setPayment(rs.getInt("payment"));
                b.setIconfirm(rs.getString("iconfirm"));
                b.setIdebt(rs.getInt("idebt"));
                b.setItotal(rs.getInt("itotal"));
                b.setTime(rs.getString("time") == null ? "" : rs.getString("time").substring(0, 19));
                return b;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ImportDebt getImportDebt(int iid) {

        try {
            String sql = "select iid,status,time from ImportDebt where iid=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, iid);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                ImportDebt bd = new ImportDebt();
                Import b = new Import();
                b.setIid(rs.getInt("iid"));
                bd.setIid(b);
                bd.setStatus(rs.getBoolean("status"));
                bd.setTime(rs.getString("time") == null ? "" : rs.getString("time").substring(0, 19));
                return bd;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void updateImport(Import i, ArrayList<ImportDetail> d, int iid) {
        String sql = "UPDATE [dbo].[Import]\n"
                + "   SET [iname] = ?\n"
                + "      ,[iphone] = ?\n"
                + "      ,[iaddress] = ?\n"
                + "      ,[iconfirm] = ?\n"
                + "      ,[itotal] = ?\n"
                + "      ,[idebt] = ?\n"
                + "      ,[payment] = ?\n"
                + " WHERE iid=?";
        PreparedStatement stm = null;
        try {
            connection.setAutoCommit(false);
            stm = connection.prepareStatement(sql);
            stm.setString(1, i.getIname());
            stm.setString(2, i.getIphone());
            stm.setString(3, i.getIaddress());
            stm.setString(4, i.getIconfirm());
            stm.setInt(5, i.getItotal());
            stm.setInt(6, i.getIdebt());
            stm.setInt(7, i.getPayment());
            stm.setInt(8, iid);
            stm.executeUpdate(); //INSERT UPDATE DELETE

            for (ImportDetail detail : d) {
                String up = "UPDATE [dbo].[ImportDetail]\n"
                        + "   SET [product] = ?\n"
                        + "      ,[quantity] = ?\n"
                        + "      ,[unitprice] = ?\n"
                        + "      ,[price] = ?\n"
                        + "      ,[describe] = ?\n"
                        + " WHERE iid=? and num=?";
                PreparedStatement stm_update = connection.prepareStatement(up);
                stm_update.setString(1, detail.getIproduct());
                stm_update.setInt(2, detail.getIquantity());
                stm_update.setInt(3, detail.getIunitprice());
                stm_update.setInt(4, detail.getIprice());
                stm_update.setString(5, detail.getIdescribe());
                stm_update.setInt(6, iid);
                stm_update.setInt(7, detail.getNum());
                stm_update.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

        }
    }

    public ArrayList<Integer> getNum(int iid) {
        ArrayList<Integer> list = new ArrayList<>();
        try {
            String sql = "select num from ImportDetail where iid=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, iid);
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

    public void deleteImport(int iid) {
        String sql = "DELETE FROM [dbo].[Import]\n"
                + " WHERE [iid] = ? ";
        PreparedStatement stm = null;
        try {
            connection.setAutoCommit(false);
            stm = connection.prepareStatement(sql);
            stm.setInt(1, iid);
            String del = "DELETE FROM [dbo].[ImportDetail]\n"
                    + " WHERE [iid] = ?";
            PreparedStatement stm_del = connection.prepareStatement(del);
            stm_del.setInt(1, iid);
            stm_del.executeUpdate();
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }
    
    public void setDebt(int iid, int payment) {
        String sql = "UPDATE [dbo].[Import]\n"
                + "   SET [payment] = ?\n"
                + "      ,[idebt] = ?\n"
                + " WHERE iid=?";
        PreparedStatement stm = null;
        try {
            connection.setAutoCommit(false);
            stm = connection.prepareStatement(sql);
            stm.setInt(1, payment);
            stm.setInt(2, 0);
            stm.setInt(3, iid);
            stm.executeUpdate(); //INSERT UPDATE DELETE
            String up = "UPDATE [dbo].[ImportDebt]\n"
                    + "   SET [time] = CURRENT_TIMESTAMP\n"
                    + "   ,[status] = 0\n"
                    + " WHERE iid=?";
            PreparedStatement stm_update = connection.prepareStatement(up);
            stm_update.setInt(1, iid);
            stm_update.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ImportDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

        }
    }
}
