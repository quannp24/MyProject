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
import java.sql.Time;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.MovieTime;

/**
 *
 * @author lyqua
 */
public class MovieTimeDAO extends DBContext {

    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;
    private String query;

    public ArrayList<MovieTime> getSlots(int dateroomID) {
        ArrayList<MovieTime> slots = new ArrayList<>();
        query = "select * from MovieTime where DateRoomID=? order by slot";
        try {
            con = new DBContext().connection;
            ps = connection.prepareStatement(query);
            ps.setInt(1, dateroomID);
            rs = ps.executeQuery();
            while (rs.next()) {
                MovieTime m = new MovieTime();
                m.setDateRoomID(rs.getInt("DateRoomID"));
                m.setMovieTimeId(rs.getInt("MovieTimeId"));
                m.setSlot(rs.getInt("Slot"));
                m.setStart(rs.getTime("Start"));
                m.setFinish(rs.getTime("Finish"));
                slots.add(m);
            }
            return slots;
        } catch (SQLException ex) {
            Logger.getLogger(MovieTimeDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return null;
    }
    
    public int deleteMovieTime(int id) {
        try {
            query = "DELETE FROM [dbo].[MovieTime]\n"
                    + "      WHERE MovieTimeId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            return ps.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(MovieTimeDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return 0;
    }

    public ArrayList<MovieTime> getSlotByRoomDate(int dateroomID, int roomId) {
        ArrayList<MovieTime> slots = new ArrayList<>();
        query = "select m.MovieTimeId,slot,start,Finish from TimeRoom t join MovieTime m on t.MovieTimeId=m.MovieTimeId where RoomId=? and DateRoomID=? order by slot";
        try {
            con = new DBContext().connection;
            ps = connection.prepareStatement(query);
            ps.setInt(1, roomId);
            ps.setInt(2, dateroomID);
            rs = ps.executeQuery();
            while (rs.next()) {
                MovieTime m = new MovieTime();
                m.setMovieTimeId(rs.getInt("MovieTimeId"));
                m.setSlot(rs.getInt("Slot"));
                m.setStart(rs.getTime("Start"));
                m.setFinish(rs.getTime("Finish"));
                slots.add(m);
            }
            return slots;
        } catch (SQLException ex) {
            Logger.getLogger(MovieTimeDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return null;
    }

    public ArrayList<MovieTime> getSlotByDateAndMovie(Date date, int movieId, int typeRoomChoice) {
        ArrayList<MovieTime> slots = new ArrayList<>();
        if (typeRoomChoice == 1) {
            query = "select m.* from TimeRoom t join MovieTime m on t.MovieTimeId=m.MovieTimeId \n"
                    + "						join DateRoom d on d.DateRoomID=m.DateRoomID\n"
                    + "						join Room r on t.RoomId=r.RoomId\n"
                    + "						where MovieId=? and DateRoom=? and RoomName like '%Cinema%' and convert(time,m.Start)>=CONVERT(time,CURRENT_TIMESTAMP) order by m.Start";
        } else {
            query = "select m.* from TimeRoom t join MovieTime m on t.MovieTimeId=m.MovieTimeId \n"
                    + "						join DateRoom d on d.DateRoomID=m.DateRoomID\n"
                    + "						join Room r on t.RoomId=r.RoomId\n"
                    + "						where MovieId=? and DateRoom=? and RoomName like '%VIP%' and convert(time,m.Start)>=CONVERT(time,CURRENT_TIMESTAMP) order by m.Start";
        }

        try {
            con = new DBContext().connection;
            ps = connection.prepareStatement(query);
            ps.setInt(1, movieId);
            ps.setDate(2, date);
            rs = ps.executeQuery();
            while (rs.next()) {
                MovieTime m = new MovieTime();
                m.setMovieTimeId(rs.getInt("MovieTimeId"));
                m.setSlot(rs.getInt("Slot"));
                m.setStart(rs.getTime("Start"));
                m.setFinish(rs.getTime("Finish"));
                slots.add(m);
            }
            return slots;
        } catch (SQLException ex) {
            Logger.getLogger(MovieTimeDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return null;
    }

    public ArrayList<MovieTime> getSlotByDateOrther(Date date, int movieId, int typeRoomChoice) {
        ArrayList<MovieTime> slots = new ArrayList<>();
        if (typeRoomChoice == 1) {
            query = "select m.* from TimeRoom t join MovieTime m on t.MovieTimeId=m.MovieTimeId \n"
                    + "						join DateRoom d on d.DateRoomID=m.DateRoomID\n"
                    + "						join Room r on t.RoomId=r.RoomId\n"
                    + "						where MovieId=? and DateRoom=? and RoomName like '%Cinema%'  order by m.Start";
        } else {
            query = "select m.* from TimeRoom t join MovieTime m on t.MovieTimeId=m.MovieTimeId \n"
                    + "						join DateRoom d on d.DateRoomID=m.DateRoomID\n"
                    + "						join Room r on t.RoomId=r.RoomId\n"
                    + "						where MovieId=? and DateRoom=? and RoomName like '%VIP%'  order by m.Start";
        }

        try {
            con = new DBContext().connection;
            ps = connection.prepareStatement(query);
            ps.setInt(1, movieId);
            ps.setDate(2, date);
            rs = ps.executeQuery();
            while (rs.next()) {
                MovieTime m = new MovieTime();
                m.setMovieTimeId(rs.getInt("MovieTimeId"));
                m.setSlot(rs.getInt("Slot"));
                m.setStart(rs.getTime("Start"));
                m.setFinish(rs.getTime("Finish"));
                slots.add(m);
            }
            return slots;
        } catch (SQLException ex) {
            Logger.getLogger(MovieTimeDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return null;
    }

    public int checkCountDateRoom(int movietimeId) {
        query = "select count(*) total from TimeRoom where MovieTimeId=?";

        try {
            con = new DBContext().connection;
            ps = connection.prepareStatement(query);
            ps.setInt(1, movietimeId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(MovieTimeDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return 0;
    }

    public MovieTime addSlot(MovieTime mt) {
        try {
            query = "INSERT INTO [dbo].[MovieTime]\n"
                    + "           ([Slot]\n"
                    + "           ,[Start]\n"
                    + "           ,[Finish]\n"
                    + "           ,[DateRoomID])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?)";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, mt.getSlot());
            ps.setTime(2, mt.getStart());
            ps.setTime(3, mt.getFinish());
            ps.setInt(4, mt.getDateRoomID());

            int check = ps.executeUpdate();
            if (check > 0) {
                query = "SELECT top(1) * FROM MovieTime order by MovieTimeId desc";
                ps = con.prepareStatement(query);
                rs = ps.executeQuery();
                if (rs.next()) {
                    MovieTime m = new MovieTime();
                    m.setMovieTimeId(rs.getInt("MovieTimeId"));
                    m.setSlot(rs.getInt("Slot"));
                    m.setStart(rs.getTime("Start"));
                    m.setFinish(rs.getTime("Finish"));
                    m.setDateRoomID(rs.getInt("DateRoomID"));
                    if (m.getStart().equals(mt.getStart()) && m.getFinish().equals(mt.getFinish()) && m.getSlot() == mt.getSlot() && m.getDateRoomID() == mt.getDateRoomID()) {
                        return m;
                    }
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(MovieTimeDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return null;
    }

    public MovieTime CheckMovieTimeExists(MovieTime mt) {
        try {
            query = "select * from MovieTime where slot=? and datepart(hh,start) like datepart(hh,?) and "
                    + "datepart(mi,start) like datepart(mi,?) and datepart(hh,finish) like datepart(hh,?) "
                    + "and datepart(mi,finish) like datepart(mi,?) and DateRoomID=? ";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, mt.getSlot());
            ps.setTime(2, mt.getStart());
            ps.setTime(3, mt.getStart());
            ps.setTime(4, mt.getFinish());
            ps.setTime(5, mt.getFinish());
            ps.setInt(6, mt.getDateRoomID());
            rs = ps.executeQuery();
            if (rs.next()) {
                MovieTime m = new MovieTime();
                m.setDateRoomID(rs.getInt("DateRoomID"));
                m.setStart(rs.getTime("Start"));
                m.setFinish(rs.getTime("Finish"));
                m.setMovieTimeId(rs.getInt("MovieTimeId"));
                return m;
            }
        } catch (SQLException e) {
            Logger.getLogger(MovieTimeDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return null;
    }

    public MovieTime getSlotByMovieTimeId(int movietimeId) {
        try {
            query = "select * from movietime where movietimeId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, movietimeId);
            rs = ps.executeQuery();
            if (rs.next()) {
                MovieTime m = new MovieTime();
                m.setDateRoomID(rs.getInt("DateRoomID"));
                m.setSlot(rs.getInt("Slot"));
                m.setStart(rs.getTime("Start"));
                m.setFinish(rs.getTime("Finish"));
                m.setMovieTimeId(rs.getInt("MovieTimeId"));
                return m;
            }
        } catch (SQLException e) {
            Logger.getLogger(MovieTimeDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return null;
    }

    public int updateMovieTime(MovieTime t) {
        try {
            query = "UPDATE [dbo].[MovieTime]\n"
                    + "   SET [Slot] = ?\n"
                    + "      ,[Start] = ?\n"
                    + "      ,[Finish] = ?\n"
                    + "      ,[DateRoomID] = ?\n"
                    + " WHERE MovieTimeId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, t.getSlot());
            ps.setTime(2, t.getStart());
            ps.setTime(3, t.getFinish());
            ps.setInt(4, t.getDateRoomID());
            ps.setInt(5, t.getMovieTimeId());

            return ps.executeUpdate();

        } catch (SQLException e) {
            Logger.getLogger(MovieTimeDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return 0;
    }
}
