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
import model.TimeRoom;

/**
 *
 * @author lyqua
 */
public class TimeRoomDAO extends DBContext {

    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;
    private String query;

    public ArrayList<TimeRoom> getAllTimeRoomByDateRoom(int dateroomID) {
        ArrayList<TimeRoom> list = new ArrayList<>();
        try {
            query = "select TimeRoomId,RoomId,MovieId,t.MovieTimeId,t.status from TimeRoom t join MovieTime m on t.MovieTimeId=m.MovieTimeId where DateRoomID=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, dateroomID);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new TimeRoom(rs.getInt("TimeRoomId"), rs.getInt("RoomId"), rs.getInt("MovieId"), rs.getInt("MovieTimeId"), rs.getBoolean("status"))
                );
            }
        } catch (SQLException e) {
            Logger.getLogger(TimeRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }

        return list;
    }

    public ArrayList<TimeRoom> getTimeRoomByStatus(Date dateroom) {
        ArrayList<TimeRoom> list = new ArrayList<>();
        try {
            query = "select DISTINCT * from TimeRoom t join MovieTime m on t.MovieTimeId=m.MovieTimeId\n"
                    + "               					join DateRoom d on d.DateRoomID=m.DateRoomID\n"
                    + "                						join Room r on t.RoomId=r.RoomId\n"
                    + "                					where DateRoom=? and t.status=0";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setDate(1, dateroom);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new TimeRoom(rs.getInt("TimeRoomId"), rs.getInt("RoomId"), rs.getInt("MovieId"), rs.getInt("MovieTimeId"), rs.getBoolean("status"))
                );
            }
        } catch (SQLException e) {
            Logger.getLogger(TimeRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }

        return list;
    }

    public TimeRoom getTimeRoomBook(int movieId, Date date, int movietimeId, int typeRoom) {
        try {
            if (typeRoom == 1) {
                query = "select t.* from TimeRoom t join MovieTime m on t.MovieTimeId=m.MovieTimeId \n"
                        + "						join DateRoom d on d.DateRoomID=m.DateRoomID\n"
                        + "						join Room r on t.RoomId=r.RoomId\n"
                        + "						where  MovieId=? and DateRoom=? and m.MovieTimeId=? and RoomName like '%Cinema%'";
            } else {
                query = "select t.* from TimeRoom t join MovieTime m on t.MovieTimeId=m.MovieTimeId \n"
                        + "						join DateRoom d on d.DateRoomID=m.DateRoomID\n"
                        + "						join Room r on t.RoomId=r.RoomId\n"
                        + "						where  MovieId=? and DateRoom=? and m.MovieTimeId=? and RoomName like '%VIP%'";
            }

            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, movieId);
            ps.setDate(2, date);
            ps.setInt(3, movietimeId);
            rs = ps.executeQuery();
            if (rs.next()) {
                TimeRoom t = new TimeRoom(rs.getInt("TimeRoomId"), rs.getInt("RoomId"), rs.getInt("MovieId"), rs.getInt("MovieTimeId"), rs.getBoolean("status"));
                return t;
            }
        } catch (SQLException e) {
            Logger.getLogger(TimeRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }

        return null;
    }

    public int addTimeRoom(TimeRoom t) {
        try {
            query = "INSERT INTO [dbo].[TimeRoom]\n"
                    + "           ([RoomId]\n"
                    + "           ,[MovieId]\n"
                    + "           ,[MovieTimeId]"
                    + "           ,[status])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?,0)";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, t.getRoomId());
            ps.setInt(2, t.getMovieId());
            ps.setInt(3, t.getMovieTimeId());

            return ps.executeUpdate();

        } catch (SQLException e) {
            Logger.getLogger(TimeRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return 0;
    }

    public int deleteTimeRoom(int id) {
        try {
            query = "DELETE FROM [dbo].[TimeRoom]\n"
                    + "      WHERE TimeRoomId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            return ps.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(TimeRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return 0;
    }

    public TimeRoom getTimeRoomByCartId(int cartId, int accId) {
        try {
            query = "select DISTINCT t.* from cart c join SeatRoomCart sc on c.CartId=sc.CartId\n"
                    + " join SeatRoom s on sc.SeatRoomId=s.SeatRoomId\n"
                    + " join TimeRoom t on t.TimeRoomId=s.TimeRoomId\n"
                    + "where c.CartId=? and AccountId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, cartId);
            ps.setInt(2, accId);
            rs = ps.executeQuery();
            if (rs.next()) {
                TimeRoom t = new TimeRoom(rs.getInt("TimeRoomId"), rs.getInt("RoomId"), rs.getInt("MovieId"), rs.getInt("MovieTimeId"), rs.getBoolean("status"));
                return t;
            }
        } catch (SQLException e) {
            Logger.getLogger(TimeRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }

        return null;
    }

    public TimeRoom getTimeRoomById(int timeroomId) {
        try {
            query = "select * from TimeRoom where TimeRoomId=?";

            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, timeroomId);
            rs = ps.executeQuery();
            if (rs.next()) {
                TimeRoom t = new TimeRoom(rs.getInt("TimeRoomId"), rs.getInt("RoomId"), rs.getInt("MovieId"), rs.getInt("MovieTimeId"), rs.getBoolean("status"));
                return t;
            }
        } catch (SQLException e) {
            Logger.getLogger(TimeRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }

        return null;
    }

    public int updateTimeRoom(TimeRoom t) {
        try {
            query = "UPDATE [dbo].[TimeRoom]\n"
                    + "   SET [RoomId] = ?\n"
                    + "      ,[MovieId] = ?\n"
                    + "      ,[MovieTimeId] = ?\n"
                    + " WHERE TimeRoomId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, t.getRoomId());
            ps.setInt(2, t.getMovieId());
            ps.setInt(3, t.getMovieTimeId());
            ps.setInt(4, t.getTimeRoomId());

            return ps.executeUpdate();

        } catch (SQLException e) {
            Logger.getLogger(TimeRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return 0;
    }

    public int updateStatusTimeRoom(ArrayList<TimeRoom> list) {
        try {
            query = "UPDATE [dbo].[TimeRoom]\n"
                    + "   SET [Status] = 1\n"
                    + " WHERE TimeRoomId=?";
            con = new DBContext().connection;
            connection.setAutoCommit(false);
            for (TimeRoom t : list) {
                ps = con.prepareStatement(query);
                ps.setInt(1, t.getTimeRoomId());
                ps.executeUpdate();
            }
            return 1;
        } catch (SQLException e) {
            Logger.getLogger(TimeRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        try {
            connection.setAutoCommit(true);
        } catch (SQLException ex) {
            Logger.getLogger(TimeRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return 0;
    }

    public boolean checkMovieDuplicate(int slot, boolean typeRoom, int dateroomId, int movieId) {
        try {
            if (typeRoom) {  // true là phòng 2D
                query = "select * from TimeRoom t join MovieTime m on t.MovieTimeId=m.MovieTimeId \n"
                        + "						join Room r on t.RoomId=r.RoomId\n"
                        + "where DateRoomID=? and slot=? and RoomName like '%Cinema%' and movieId=?";
            } else {  // false là phòng 3D
                query = "select * from TimeRoom t join MovieTime m on t.MovieTimeId=m.MovieTimeId \n"
                        + "						join Room r on t.RoomId=r.RoomId\n"
                        + "where DateRoomID=? and slot=? and RoomName like '%VIP%' and movieId=?";
            }
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, dateroomId);
            ps.setInt(2, slot);
            ps.setInt(3, movieId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(TimeRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }

        return false;
    }

    public ArrayList<Integer> getListMovieExists(int slot, int dateroomId, boolean typeRoom) {
        ArrayList<Integer> list = new ArrayList<>();
        try {
            if (typeRoom) {  // true là phòng 2D
                query = "select t.* from TimeRoom t join MovieTime m on t.MovieTimeId=m.MovieTimeId \n"
                        + "						join Room r on t.RoomId=r.RoomId\n"
                        + "where DateRoomID=? and slot=? and RoomName like '%Cinema%'";
            } else {  // false là phòng 3D
                query = "select t.* from TimeRoom t join MovieTime m on t.MovieTimeId=m.MovieTimeId \n"
                        + "						join Room r on t.RoomId=r.RoomId\n"
                        + "where DateRoomID=? and slot=? and RoomName like '%VIP%'";
            }
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, dateroomId);
            ps.setInt(2, slot);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt("MovieId"));

            }
            return list;
        } catch (SQLException e) {
            Logger.getLogger(TimeRoomDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }

        return null;
    }

}
