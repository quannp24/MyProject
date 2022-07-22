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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Banner;

/**
 *
 * @author MSI
 */
public class BannerDAO extends DBContext {

    Connection conn = null;
    PreparedStatement pre = null;
    ResultSet rs = null;

    public ArrayList<Banner> listBanner() {
        ArrayList<Banner> arr = new ArrayList<>();
        String sql = "select * from Banner where start<CURRENT_TIMESTAMP and finish>CURRENT_TIMESTAMP";
        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                Banner banner = new Banner(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDate(5), rs.getDate(6));
                arr.add(banner);
            }
        } catch (Exception e) {
        }
        return arr;
    }

    public Banner get(int id) {
        try {
            String query = "SELECT * FROM dbo.Banner WHERE ID = ?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setInt(1, id);
            rs = pre.executeQuery();

            while (rs.next()) {
                Banner banner = new Banner();
                banner.setId(rs.getInt("ID"));
                banner.setTitle(rs.getString("title"));
                banner.setImg(rs.getString("img"));
                banner.setDesc(rs.getString("description"));
                banner.setStart(rs.getDate("start"));
                banner.setFinish(rs.getDate("finish"));
                return banner;
            }
        } catch (SQLException e) {
            Logger.getLogger(BannerDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return null;
    }

    public void deleteBanner(int id) {
        try {
            String query = "DELETE FROM dbo.Banner WHERE ID = ?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setInt(1, id);
            pre.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(BannerDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
    }

    public void editBanner(Banner banner) {
        try {
            String query = "UPDATE dbo.Banner SET Img = ?, Title = ? , [description] = ?,start=?,finish=? WHERE ID = ?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setString(1, banner.getImg());
            pre.setString(2, banner.getTitle());
            pre.setString(3, banner.getDesc());
            pre.setDate(4, banner.getStart());
            pre.setDate(5, banner.getFinish());
            pre.setInt(6, banner.getId());
            pre.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(BannerDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
    }

    public String getImgBanner(int id) {
        try {
            String query = "select img from banner where id=?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setInt(1, id);
            rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getString("img");
            }
        } catch (SQLException e) {
            Logger.getLogger(BannerDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return null;
    }

    public int getTotalBanner() {
        try {
            String query = "SELECT count(*) FROM dbo.Banner";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);

            rs = pre.executeQuery();

            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            Logger.getLogger(BannerDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return 0;
    }

    public List<Banner> pagingBanner(int pageIndex) {
        List<Banner> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM "
                    + "( SELECT *, ROW_NUMBER() OVER "
                    + "(ORDER BY ID desc) AS Seq\n"
                    + "FROM dbo.Banner)t WHERE Seq BETWEEN ? AND ?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setInt(1, (pageIndex - 1) * 5 + 1);
            pre.setInt(2, (pageIndex - 1) * 5 + 5);

            rs = pre.executeQuery();

            while (rs.next()) {
                list.add(new Banner(
                        rs.getInt("id"),
                        rs.getString("img"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getDate("start"),
                        rs.getDate("finish")));
            }

        } catch (SQLException e) {
            Logger.getLogger(BannerDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return list;
    }

    public void addBanner(Banner banner) {
        try {
            String query = "INSERT INTO [dbo].[Banner]\n"
                    + "           ([img]\n"
                    + "           ,[title]\n"
                    + "           ,[description]\n"
                    + "           ,[start]\n"
                    + "           ,[finish])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?)";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setString(1, banner.getImg());
            pre.setString(2, banner.getTitle());
            pre.setString(3, banner.getDesc());
            pre.setDate(4, banner.getStart());
            pre.setDate(5, banner.getFinish());
            pre.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(BannerDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
    }
}
