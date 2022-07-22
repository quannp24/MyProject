/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DateRoom;
import model.Room;

/**
 *
 * @author Quan
 */
public class DateRoomDAO extends DBContext {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String query = null;

    public DateRoom CheckDateRoomExists(Date date) {
        try {
            query = "select * from DateRoom where DateRoom=? ";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setDate(1, date);
            rs = ps.executeQuery();
            if (rs.next()) {
                DateRoom d = new DateRoom();
                d.setDateRoomID(rs.getInt("DateRoomID"));
                d.setDateRoom(rs.getDate("DateRoom"));
                return d;
            }
        } catch (SQLException e) {
            Logger.getLogger(DateRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return null;
    }

    public int CheckDateRoomDuplicate(int dateroomId) {
        try {
            query = "select count(*) as total from MovieTime where DateRoomID=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, dateroomId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            Logger.getLogger(DateRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return -1;
    }

    public int deleteDateRoom(int id) {
        try {
            query = "DELETE FROM [dbo].[DateRoom]\n"
                    + "      WHERE DateRoomID=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            return ps.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(DateRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return 0;
    }

    public int addDate(Date date) {
        try {
            query = "INSERT INTO [dbo].[DateRoom]\n"
                    + "           ([DateRoom])\n"
                    + "     VALUES\n"
                    + "           (?)";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setDate(1, date);
            return ps.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(DateRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return 0;
    }

    public DateRoom getDateRoomByDateroomId(int dateroomId) {
        try {
            query = "select * from DateRoom where DateRoomId=? ";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, dateroomId);
            rs = ps.executeQuery();
            if (rs.next()) {
                DateRoom d = new DateRoom();
                d.setDateRoomID(rs.getInt("DateRoomID"));
                d.setDateRoom(rs.getDate("DateRoom"));
                return d;
            }
        } catch (SQLException e) {
            Logger.getLogger(DateRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return null;
    }

    public DateRoom getDateRoomByMovieTimeID(int movieTimeID) {
        try {
            query = "select d.* from MovieTime m join DateRoom d on m.DateRoomID=d.DateRoomID where MovieTimeId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, movieTimeID);
            rs = ps.executeQuery();
            if (rs.next()) {
                DateRoom d = new DateRoom();
                d.setDateRoomID(rs.getInt("DateRoomID"));
                d.setDateRoom(rs.getDate("DateRoom"));
                return d;
            }
        } catch (SQLException e) {
            Logger.getLogger(DateRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return null;
    }
}
