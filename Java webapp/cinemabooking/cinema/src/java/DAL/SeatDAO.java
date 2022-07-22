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
import model.Seat;

/**
 *
 * @author Quan
 */
public class SeatDAO extends DBContext {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String query = null;

    public ArrayList<Seat> getSeatByCartId(int cartId, int accId) {
        ArrayList<Seat> list = new ArrayList<>();
        try {
            /*Set up connection and Sql statement for Query*/

            query = "select DISTINCT g.*  from cart c join SeatRoomCart sc on c.CartId=sc.CartId\n"
                    + " join SeatRoom s on sc.SeatRoomId=s.SeatRoomId\n"
                    + "	join Seat g on g.SeatId=s.SeatId\n"
                    + "	where c.CartId=? and AccountId=?";
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            ps.setInt(1, cartId);
            ps.setInt(2, accId);

            /*Query and save in ResultSet*/
            rs = ps.executeQuery();

            /*Assign data to an arraylist of Account*/
            while (rs.next()) {
                list.add(new Seat(rs.getInt("SeatId"), rs.getInt("SeatNumber"), rs.getFloat("SeatPrice"), rs.getString("SeatRow")));
            }
        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(SeatDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return list;
    }

    public ArrayList<Seat> getSeats() {
        ArrayList<Seat> seats = new ArrayList<>();
        query = "  Select * from Seat order by SeatRow";
        try {
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Seat s = new Seat();
                s.setSeatId(rs.getInt("SeatId"));
                s.setSeatNumber(rs.getInt("SeatNumber"));
                s.setSeatPrice(rs.getInt("SeatPrice"));
                s.setSeatRow(rs.getString("SeatRow"));
                seats.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return seats;
    }
    
    public ArrayList<String> getCharSeats() {
        ArrayList<String> list = new ArrayList<>();
        query = "  select DISTINCT  SeatRow from Seat";
        try {
            con = new DBContext().connection;
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString(1));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
        return list;
    }
}
