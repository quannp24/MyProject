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
import model.SeatRoom;

/**
 *
 * @author Quan
 */
public class SeatRoomDAO extends DBContext {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String query = null;

    public ArrayList<SeatRoom> getSeatRoomsByTimeRoomId(int timeRoomId) {
        ArrayList<SeatRoom> seatRooms = new ArrayList<>();
        query = "select * from SeatRoom where TimeRoomId = ?";
        try {
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, timeRoomId);
            rs = ps.executeQuery();
            while (rs.next()) {
                SeatRoom s = new SeatRoom();
                s.setSeatId(rs.getInt("SeatId"));
                s.setSeatRoomId(rs.getInt("SeatRoomId"));
                s.setStatusSeat(rs.getBoolean("status"));
                s.setTimeRoomId(rs.getInt("TimeRoomId"));
                seatRooms.add(s);
            }
            return seatRooms;
        } catch (SQLException ex) {
            Logger.getLogger(SeatRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return null;

    }

    public ArrayList<SeatRoom> getSeatRoomsByAll(int timeRoomId, String[] seatId, int status) {
        ArrayList<SeatRoom> seatRooms = new ArrayList<>();
        query = "select * from SeatRoom where TimeRoomId = ? and seatId=? and status=?";
        try {
            con = new DBContext().connection;
            for (int i = 0; i < seatId.length; i++) {
                ps = con.prepareStatement(query);
                ps.setInt(1, timeRoomId);
                ps.setInt(2, Integer.parseInt(seatId[i]));
                ps.setInt(3, status);
                rs = ps.executeQuery();
                if (rs.next()) {
                    SeatRoom s = new SeatRoom();
                    s.setSeatId(rs.getInt("SeatId"));
                    s.setSeatRoomId(rs.getInt("SeatRoomId"));
                    s.setStatusSeat(rs.getBoolean("status"));
                    s.setTimeRoomId(rs.getInt("TimeRoomId"));
                    seatRooms.add(s);
                }
            }
            return seatRooms;
        } catch (SQLException ex) {
            Logger.getLogger(SeatRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return null;

    }

    public void addSeatTemporary(int timeroomId, String[] seatId) {
        try {
            query = "INSERT INTO [dbo].[SeatRoom]\n"
                    + "           ([SeatId]\n"
                    + "           ,[TimeRoomId]\n"
                    + "           ,[status])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,0)";
            connection.setAutoCommit(false);
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            for (int i = 0; i < seatId.length; i++) {
                if (seatId[i].length() > 0) {
                    ps.setInt(1, Integer.parseInt(seatId[i]));
                    ps.setInt(2, timeroomId);
                    ps.executeUpdate();
                }
            }

        } catch (SQLException e) {
            Logger.getLogger(SeatRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        try {
            connection.setAutoCommit(true);
        } catch (SQLException ex) {
            Logger.getLogger(SeatRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
    }

    public boolean checkSeatRoomExits(int timeRoomId, String[] seatId) {
        boolean check = false;
        try {

            for (String s : seatId) {
                query = "select * from SeatRoom where TimeRoomId = ? and seatId=?";
                con = new DBContext().connection;
                ps = con.prepareStatement(query);
                ps.setInt(1, timeRoomId);
                ps.setInt(2, Integer.parseInt(s));
                rs = ps.executeQuery();
                if (rs.next()) {
                    check = true;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return check;

    }

    public void deleteSeatRoom(int timeroomId, String[] listSeat) {
        try {
            connection.setAutoCommit(false);
            query = "DELETE FROM [dbo].[SeatRoom]\n"
                    + "      WHERE TimeRoomId=? and status=0 and SeatId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            for (int i = 0; i < listSeat.length; i++) {
                ps.setInt(1, timeroomId);
                ps.setInt(2, Integer.parseInt(listSeat[i]));
                ps.executeUpdate();
            }

        } catch (SQLException e) {
            Logger.getLogger(SeatRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        try {
            connection.setAutoCommit(true);
        } catch (SQLException ex) {
            Logger.getLogger(SeatRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
    }
    public void deleteSeatRoomByID(ArrayList<SeatRoom> list) {
        try {
            connection.setAutoCommit(false);
            query = "DELETE FROM [dbo].[SeatRoom]\n"
                    + "      WHERE SeatRoomId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            for (int i = 0; i < list.size(); i++) {
                ps.setInt(1, list.get(i).getSeatRoomId());
                ps.executeUpdate();
            }

        } catch (SQLException e) {
            Logger.getLogger(SeatRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        try {
            connection.setAutoCommit(true);
        } catch (SQLException ex) {
            Logger.getLogger(SeatRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
    }

    public void updateStatus(ArrayList<SeatRoom> list) {
        try {
            connection.setAutoCommit(false);
            query = "UPDATE [dbo].[SeatRoom]\n"
                    + "   SET [status] = 1\n"
                    + " WHERE SeatRoomId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            for (int i = 0; i < list.size(); i++) {
                ps.setInt(1, list.get(i).getSeatRoomId());
                ps.executeUpdate();
            }

        } catch (SQLException e) {
            Logger.getLogger(SeatRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        try {
            connection.setAutoCommit(true);
        } catch (SQLException ex) {
            Logger.getLogger(SeatRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
    }
}
