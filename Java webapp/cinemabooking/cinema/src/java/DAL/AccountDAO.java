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
import model.Account;

/**
 *
 * @author Quan
 */
public class AccountDAO extends DBContext {

    Connection conn = null;
    PreparedStatement pre = null;
    ResultSet rs = null;

    public Account getAccount(String email, String password) {
        String sql = "select AccountId,Email,Password,Fullname,Gender,DateOfBirth,Address,Phone,Image,Role,Status from Account where email=? and Password=?";
        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            pre.setString(1, email);
            pre.setString(2, password);
            rs = pre.executeQuery();
            if (rs.next()) {
                Account account = new Account();
                account.setAccId(rs.getInt("AccountId"));
                account.setEmail(rs.getString("Email"));
                account.setPassword(rs.getString("Password"));
                account.setFullname(rs.getString("Fullname"));
                account.setGender(rs.getBoolean("Gender"));
                account.setDob(rs.getDate("DateOfBirth"));
                account.setAddress(rs.getString("Address"));
                account.setRole(rs.getString("Role"));
                account.setImg(rs.getString("Image"));
                account.setStatus(rs.getBoolean("Status"));
                return account;
            }

        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(connection);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return null;
    }

    public Account getAccountById(int id) {
        String sql = "  select * from Account where AccountId =?";

        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            rs = pre.executeQuery();
            while (rs.next()) {
                Account a = new Account();
                a.setAccId(rs.getInt("AccountId"));
                a.setEmail(rs.getString("Email"));
                a.setPassword(rs.getString("Password"));
                a.setFullname(rs.getString("Fullname"));
                a.setGender(rs.getBoolean("Gender"));
                a.setDob(rs.getDate("DateOfBirth"));
                a.setAddress(rs.getString("Address"));
                a.setPhone(rs.getString("Phone"));
                a.setImg(rs.getString("Image"));
                a.setRole(rs.getString("Role"));
//                a.setStatus(rs.getBoolean("Status"));
                return a;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(connection);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return null;
    }

    public int UpdateAccount(Account a) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [Email] = ?\n"
                + "      ,[Fullname] = ?\n"
                + "      ,[Gender] = ?\n"
                + "      ,[DateOfBirth] = ?\n"
                + "      ,[Address] = ?\n"
                + "      ,[Phone] = ?\n"
                + "      ,[Role] = ?\n"
                + "      ,[Image] = ? WHERE AccountId=?";

        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            pre = connection.prepareStatement(sql);
            pre.setString(1, a.getEmail());
            pre.setString(2, a.getFullname());
            pre.setBoolean(3, a.isGender());
            pre.setDate(4, a.getDob());
            pre.setString(5, a.getAddress());
            pre.setString(6, a.getPhone());
            pre.setString(7, a.getRole());
            pre.setString(8, a.getImg());
            pre.setInt(9, a.getAccId());

            return pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(connection);
            closePreparedStatement(pre);
        }
        return 0;
    }

    public int ChangePassword(int id, String pass) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET \n"
                + "      [Password] = ?\n"
                + " WHERE AccountId=?";
        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            pre.setString(1, pass);
            pre.setInt(2, id);
            return pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public String getExistEmail(String email) {
        String sql = "select Email from Account where Email = ?";
        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            pre.setString(1, email);
            rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getString("Email");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public void insertAccount(Account a) {
        String sql = "INSERT INTO [dbo].[Account]\n"
                + "           ([Email]\n"
                + "           ,[Password]\n"
                + "           ,[Fullname]\n"
                + "           ,[Gender]\n"
                + "           ,[DateOfBirth]\n"
                + "           ,[Address]\n"
                + "           ,[Phone]\n"
                + "           ,[Image]\n"
                + "           ,[Role]\n"
                + "           ,[Status])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,?,?,?,?)";
        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);

            pre.setString(1, a.getEmail());
            pre.setString(2, a.getPassword());
            pre.setString(3, a.getFullname());
            pre.setBoolean(4, a.isGender());
            pre.setDate(5, a.getDob());
            pre.setString(6, a.getAddress());
            pre.setString(7, a.getPhone());
            pre.setString(8, a.getImg());
            pre.setString(9, a.getRole());
            pre.setBoolean(10, a.isStatus());

            pre.executeUpdate(); //INSERT UPDATE DELETE
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void updatePassword(String email, String newPassword) {
        String sql = "UPDATE [Account]\n"
                + "   SET [Password] = ?\n"
                + " WHERE Email = ?";

        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            pre.setString(1, newPassword);
            pre.setString(2, email);
            pre.executeUpdate(); //INSERT UPDATE DELETE
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public ArrayList<Account> pagingAccount(int pageIndex, int role) {
        ArrayList<Account> accs = new ArrayList<>();
        String sql = "";
        try {
            if (role > 0) {
                sql = "SELECT * FROM (SELECT *,ROW_NUMBER() OVER (ORDER BY fullname) AS Seq FROM dbo.Account where role=?)t WHERE Seq BETWEEN ? AND ?";
            } else {
                sql = "SELECT * FROM (SELECT *,ROW_NUMBER() OVER (ORDER BY fullname) AS Seq FROM dbo.Account where not role=1)t WHERE Seq BETWEEN ? AND ?";
            }
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            if (role > 0) {
                pre.setString(1, role + "");
                pre.setInt(2, (pageIndex - 1) * 5 + 1);
                pre.setInt(3, (pageIndex - 1) * 5 + 5);
            } else {
                pre.setInt(1, (pageIndex - 1) * 5 + 1);
                pre.setInt(2, (pageIndex - 1) * 5 + 5);
            }
            rs = pre.executeQuery();
            while (rs.next()) {
                Account acc = new Account();
                acc.setAccId(rs.getInt("AccountId"));
                acc.setEmail(rs.getString("Email"));
                acc.setPassword(rs.getString("Password"));
                acc.setFullname(rs.getString("Fullname"));
                acc.setGender(rs.getBoolean("Gender"));
                acc.setDob(rs.getDate("DateOfBirth"));
                acc.setAddress(rs.getString("Address"));
                acc.setPhone(rs.getString("Phone"));
                acc.setImg(rs.getString("Image"));
                acc.setRole(rs.getString("Role"));
                acc.setStatus(rs.getBoolean("Status"));
                accs.add(acc);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(connection);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return accs;
    }

    public int getTotalAccountByRole(int role) {
        String query = "";
        try {
            if (role > 0) {
                query = "select count(*) from Account where role = ?";
            } else {
                query = "select count(*) from Account where not role=1";
            }
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            if (role > 0) {
                pre.setString(1, role + "");
            }
            rs = pre.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(connection);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return 0;
    }

    public String getImgAccountById(int accId) {
        String query = "";
        try {
            /*Set up connection and Sql statement for Query*/
            query = "select Image from Account where AccountId=?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setInt(1, accId);
            rs = pre.executeQuery();
            if (rs.next()) {

                return rs.getString("image");
            }
        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(connection);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return null;
    }

    public ArrayList<Account> getAccountByName(String name, int pageIndex) {
        ArrayList<Account> list = new ArrayList<>();
        try {
            /*Set up connection and Sql statement for Query*/
            String query = "SELECT *\n"
                    + "FROM\n"
                    + "(\n"
                    + "SELECT *,\n"
                    + "ROW_NUMBER() OVER (ORDER BY fullname) AS Seq\n"
                    + "FROM dbo.Account\n"
                    + "where fullname like ?)t\n"
                    + "WHERE Seq BETWEEN ? AND ?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setString(1, "%" + name.trim() + "%");
            pre.setInt(2, (pageIndex - 1) * 5 + 1);
            pre.setInt(3, (pageIndex - 1) * 5 + 5);


            /*Query and save in ResultSet*/
            rs = pre.executeQuery();

            /*Assign data to an arraylist of Movie*/
            while (rs.next()) {
                Account acc = new Account();
                acc.setAccId(rs.getInt("AccountId"));
                acc.setEmail(rs.getString("Email"));
                acc.setPassword(rs.getString("Password"));
                acc.setFullname(rs.getString("Fullname"));
                acc.setGender(rs.getBoolean("Gender"));
                acc.setDob(rs.getDate("DateOfBirth"));
                acc.setAddress(rs.getString("Address"));
                acc.setPhone(rs.getString("Phone"));
                acc.setImg(rs.getString("Image"));
                acc.setRole(rs.getString("Role"));
                acc.setStatus(rs.getBoolean("Status"));
                list.add(acc);
            }
        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return list;
    }

    public int getTotalAccountByName(String name) {
        try {
            /*Set up connection and Sql statement for Query*/
            String query = "select count(*) from Account where fullname like ?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setString(1, "%" + name + "%");

            /*Excute query and store it to check*/
            rs = pre.executeQuery();

            while (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return 0;
    }
    
    public boolean deleteAccount(int id) {
        int check = 0;
        try {
            /*Set up connection and Sql statement for Query*/
            String query = "delete from Account where AccountId = ?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);

            /*Set params for Query*/
            pre.setInt(1, id);

            /*Excute query and store it to check*/
            check = pre.executeUpdate();

        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return check > 0;
    }

}
