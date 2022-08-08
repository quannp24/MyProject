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
import model.Room;

/**
 *
 * @author lyqua
 */
public class RoomDAO extends DBContext {

    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;
    private String query;

    public ArrayList<Room> getRooms() {
        ArrayList<Room> rooms = new ArrayList<>();
        String sql = "Select * from Room order by roomname";
        try {
            PreparedStatement s = connection.prepareStatement(sql);
            ResultSet rs = s.executeQuery();
            while (rs.next()) {
                Room r = new Room();
                r.setRoomId(rs.getInt("RoomId"));
                r.setRoomName(rs.getString("RoomName"));
                rooms.add(r);
            }
            return rooms;
        } catch (SQLException ex) {
            Logger.getLogger(RoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Room> getRoomByDateAndMovie(Date date, int movieId) {
        ArrayList<Room> rooms = new ArrayList<>();
        String sql = "select r.* from TimeRoom t join MovieTime m on t.MovieTimeId=m.MovieTimeId \n"
                + "						join DateRoom d on d.DateRoomID=m.DateRoomID\n"
                + "						join Room r on t.RoomId=r.RoomId\n"
                + "						where MovieId=? and DateRoom=? and t.status=1";
        try {
            PreparedStatement s = connection.prepareStatement(sql);
            s.setInt(1, movieId);
            s.setDate(2, date);
            ResultSet rs = s.executeQuery();
            while (rs.next()) {
                Room r = new Room();
                r.setRoomId(rs.getInt("RoomId"));
                r.setRoomName(rs.getString("RoomName"));
                rooms.add(r);
            }
            return rooms;
        } catch (SQLException ex) {
            Logger.getLogger(RoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Room getRoomsByID(int id) {

        String sql = "Select * from Room where RoomId=?";
        try {
            PreparedStatement s = connection.prepareStatement(sql);
            s.setInt(1, id);
            rs = s.executeQuery();
            if (rs.next()) {
                Room r = new Room();
                r.setRoomId(rs.getInt("RoomId"));
                r.setRoomName(rs.getString("RoomName"));
                return r;
            }

        } catch (SQLException ex) {
            Logger.getLogger(RoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void deleteRoomById(int id) {
        String deleteTimeRoom = "DELETE FROM [dbo].[TimeRoom]\n"
                + "      WHERE RoomId = ?";
        try {
            PreparedStatement stm1 = connection.prepareStatement(deleteTimeRoom);
            stm1.setInt(1, id);
            stm1.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(RoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        String sql = "DELETE FROM [dbo].[Room]\n"
                + "      WHERE RoomId=?";
        try {
            PreparedStatement s = connection.prepareStatement(sql);
            s.setInt(1, id);
            s.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(RoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void insertRoom(String roomName) {
        String sql = "INSERT INTO [dbo].[Room]\n"
                + "           ([RoomName])\n"
                + "     VALUES\n"
                + "           (?)";
        try {
            PreparedStatement s = connection.prepareStatement(sql);
            s.setString(1, roomName);
            s.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(RoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void editRoom(Room r) {
        try {
            query = "UPDATE [dbo].[Room]\n"
                    + "   SET [RoomName] = ?\n"
                    + " WHERE RoomId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setString(1, r.getRoomName());
            ps.setInt(2, r.getRoomId());

            ps.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(RoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
    }

    public boolean CheckRoomName(String roomName) {
        try {
            query = "select * from Room where RoomName=? ";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setString(1, roomName.trim());
            rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(RoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return false;
    }
}
