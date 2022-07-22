/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.DateRoomDAO;
import DAL.MovieDAO;
import DAL.MovieTimeDAO;
import DAL.RoomDAO;
import DAL.SeatDAO;
import DAL.SeatRoomDAO;
import DAL.TimeRoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DateRoom;
import model.Movie;
import model.MovieTime;
import model.Room;
import model.Seat;
import model.SeatRoom;
import model.TimeRoom;

/**
 *
 * @author Quan
 */
public class BookSeatController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try ( PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet BookSeatController</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet BookSeatController at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        int movieId = request.getParameter("movieId") != null ? Integer.parseInt(request.getParameter("movieId")) : 3;
        int typeRoom = request.getParameter("typeRoom") != null ? Integer.parseInt(request.getParameter("typeRoom")) : 1;
        int movietimeId = request.getParameter("movietimeId") != null ? Integer.parseInt(request.getParameter("movietimeId")) : 1;
        Date dateChoice = request.getParameter("date") != null ? Date.valueOf(request.getParameter("date")) : Date.valueOf("2022-07-08");

        TimeRoomDAO timeroomDB = new TimeRoomDAO();
        SeatDAO seatDB = new SeatDAO();
        SeatRoomDAO seatroomDB = new SeatRoomDAO();
        MovieDAO movieDB = new MovieDAO();
        RoomDAO roomDB = new RoomDAO();
        MovieTimeDAO movietimeDB = new MovieTimeDAO();

        ArrayList<Seat> seats = seatDB.getSeats(); //lấy tất cả ghế
        ArrayList<String> charSeat = seatDB.getCharSeats(); //lấy chữ cái của hàng ghế
        Movie movie = movieDB.getMovieById(movieId);

        TimeRoom timeroom = timeroomDB.getTimeRoomBook(movieId, dateChoice, movietimeId, typeRoom); // lấy timeroom dựa vào thông tin đã book
        ArrayList<SeatRoom> seatRooms = seatroomDB.getSeatRoomsByTimeRoomId(timeroom.getTimeRoomId()); //lấy tất cả ghế đã được đặt
        Room room = roomDB.getRoomsByID(timeroom.getRoomId());
        MovieTime slot = movietimeDB.getSlotByMovieTimeId(movietimeId);

        request.setAttribute("listSeat", seats);
        request.setAttribute("typeRoom", typeRoom);
        request.setAttribute("movie", movie);
        request.setAttribute("slot", slot);
        request.setAttribute("date", dateChoice);
        request.setAttribute("timeroomId", timeroom.getTimeRoomId());
        request.setAttribute("movietimeId", movietimeId);
        request.setAttribute("room", room);
        request.setAttribute("listSeatChecked", seatRooms);
        request.setAttribute("listCharSeat", charSeat);
        request.getRequestDispatcher("view/BookSeat.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        int movieId = request.getParameter("movieId") != null ? Integer.parseInt(request.getParameter("movieId")) : 0;
        int typeRoom = request.getParameter("typeRoom") != null ? Integer.parseInt(request.getParameter("typeRoom")) : 1;
        int movietimeId = request.getParameter("movietimeId") != null ? Integer.parseInt(request.getParameter("movietimeId")) : 0;
        Date dateChoice = request.getParameter("date") != null ? Date.valueOf(request.getParameter("date")) : null;

        TimeRoomDAO timeroomDB = new TimeRoomDAO();
        SeatDAO seatDB = new SeatDAO();
        SeatRoomDAO seatroomDB = new SeatRoomDAO();
        MovieDAO movieDB = new MovieDAO();
        RoomDAO roomDB = new RoomDAO();
        MovieTimeDAO movietimeDB = new MovieTimeDAO();

        ArrayList<Seat> seats = seatDB.getSeats(); //lấy tất cả ghế
        ArrayList<String> charSeat = seatDB.getCharSeats(); //lấy chữ cái của hàng ghế
        Movie movie = movieDB.getMovieById(movieId);

        TimeRoom timeroom = timeroomDB.getTimeRoomBook(movieId, dateChoice, movietimeId, typeRoom); // lấy timeroom dựa vào thông tin đã book
        ArrayList<SeatRoom> seatRooms = seatroomDB.getSeatRoomsByTimeRoomId(timeroom.getTimeRoomId()); //lấy tất cả ghế đã được đặt
        Room room = roomDB.getRoomsByID(timeroom.getRoomId());
        MovieTime slot = movietimeDB.getSlotByMovieTimeId(movietimeId);

        request.setAttribute("listSeat", seats);
        request.setAttribute("typeRoom", typeRoom);
        request.setAttribute("movie", movie);
        request.setAttribute("slot", slot);
        request.setAttribute("date", dateChoice);
        request.setAttribute("timeroomId", timeroom.getTimeRoomId());
        request.setAttribute("movietimeId", movietimeId);
        request.setAttribute("room", room);
        request.setAttribute("listSeatChecked", seatRooms);
        request.setAttribute("listCharSeat", charSeat);
        request.getRequestDispatcher("view/BookSeat.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
