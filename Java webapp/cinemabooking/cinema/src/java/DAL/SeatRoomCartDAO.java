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
public class SeatRoomCartDAO extends DBContext {

    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;
    private String query;

    public void AddSeatRoomCart(int cartId, ArrayList<SeatRoom> listSeatId) {
        try {
            /*Set up connection and Sql statement for Query*/

            query = "INSERT INTO [dbo].[SeatRoomCart]\n"
                    + "           ([SeatRoomId]\n"
                    + "           ,[CartId])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?)";
            con = new DBContext().connection;
            connection.setAutoCommit(false);
            for (SeatRoom seatRoom : listSeatId) {
                ps = con.prepareStatement(query);
                ps.setInt(1, seatRoom.getSeatRoomId());
                ps.setInt(2, cartId);
                ps.executeUpdate();
            }

        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        try {
            connection.setAutoCommit(true);
        } catch (SQLException ex) {
            Logger.getLogger(SeatRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(con);
            closePreparedStatement(ps);
            closeResultSet(rs);
        }
    }
}
