/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author MSI
 */
public class DBContext {

    public Connection connection;

    public DBContext() {
        try {
            String url = "jdbc:sqlserver://localhost:1433;databaseName=Nhom5-QuanLyRapChieuPhim";
            String username = "sa";
            String password = "12345678";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void closeConnection(java.sql.Connection con) { // đóng kết nối
        if (con != null) {
            try {
                con.close();
            } catch (SQLException ex) {
                System.err.println(ex);
            }
        }
    }

    /**
     * Close PrepareStatement to MSSQL Sever
     *
     * @param ps
     */
    public void closePreparedStatement(PreparedStatement ps) { // đóng biên dịch sql
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException ex) {
                System.err.println("Close PreparedStatement Fail!");
            }
        }
    }

    /**
     * Close ResultSet to MSSQL Sever
     *
     * @param rs
     */
    public void closeResultSet(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException ex) {
                System.err.println("Close PreparedStatement Fail!");
            }
        }
    }
}
