/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.DateRoomDAO;
import DAL.MovieDAO;
import DAL.MovieTimeDAO;
import DAL.RoomDAO;
import DAL.TimeRoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Time;
import java.time.DateTimeException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DateRoom;
import model.Movie;
import model.MovieTime;
import model.Room;
import model.TimeRoom;

/**
 *
 * @author Quan
 */
public class AdminSetupScheduleController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        ZoneId zid = ZoneId.of("Asia/Ho_Chi_Minh");
        LocalDate ld = LocalDate.now(zid);
        Date currentDate = Date.valueOf(ld); //lấy date hiện tại
        DateRoomDAO db = new DateRoomDAO();
        RoomDAO roomDB = new RoomDAO();
        MovieTimeDAO movietimeDB = new MovieTimeDAO();

        TimeRoomDAO timeroomDB = new TimeRoomDAO();
        MovieDAO movieDB = new MovieDAO();
        String mess = "";
        DateRoom dateroom = db.CheckDateRoomExists(currentDate);
        ArrayList<Room> rooms = roomDB.getRooms();
        ArrayList<Movie> listMovie = movieDB.getMovies(currentDate);
        boolean check = dateroom != null ? true : false;
        if (dateroom != null) {
            ArrayList<MovieTime> slots = movietimeDB.getSlots(dateroom.getDateRoomID());
            int lastSlot;
            if (slots.size() > 0) {
                lastSlot = slots.get(slots.size() - 1).getSlot();
            } else {
                lastSlot = 0;
                check = false;
                mess = "Ngày này chưa có lịch chiếu, hãy thêm slot trước";
                request.setAttribute("date", currentDate);
                request.setAttribute("check", check);
                request.setAttribute("listMovie", listMovie);
                request.setAttribute("listroom", rooms);
                request.setAttribute("mess", mess);
                request.getRequestDispatcher("view/AdminSetupSchedule.jsp").forward(request, response);
            }
            if (rooms.size() < 1) {
                check = false;
                mess = "Phòng chiếu chưa có, hãy thêm phòng chiếu trước";
                request.setAttribute("date", currentDate);
                request.setAttribute("check", check);
                request.setAttribute("mess", mess);
                request.getRequestDispatcher("view/AdminSetupSchedule.jsp").forward(request, response);
            }

            ArrayList<TimeRoom> listTimeRoom = timeroomDB.getAllTimeRoomByDateRoom(dateroom.getDateRoomID());
            request.setAttribute("listroom", rooms);
            request.setAttribute("lastSlot", lastSlot);
            request.setAttribute("listMovie", listMovie);
            request.setAttribute("listTimeRoom", listTimeRoom);
            request.setAttribute("listSlot", slots);
            request.setAttribute("check", check);
            request.setAttribute("mess", mess);
            request.setAttribute("date", currentDate);
            request.getRequestDispatcher("view/AdminSetupSchedule.jsp").forward(request, response);

        } else {
            mess = "Ngày này chưa có lịch chiếu, cập nhật ngay!";
            request.setAttribute("date", currentDate);
            request.setAttribute("check", check);
            request.setAttribute("listMovie", listMovie);
            request.setAttribute("listroom", rooms);
            request.setAttribute("mess", mess);
            request.getRequestDispatcher("view/AdminSetupSchedule.jsp").forward(request, response);
        }

    }

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
        processRequest(request, response);

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

        request.setCharacterEncoding("UTF-8");
        ZoneId zid = ZoneId.of("Asia/Ho_Chi_Minh");
        LocalDate ld = LocalDate.now(zid);
        String raw_date = request.getParameter("date");
        Date currentDate = null;
        if (raw_date.trim().length() > 0 || raw_date != null) {
            currentDate = Date.valueOf(request.getParameter("date")); //lấy date hiện tại
        }
        DateRoomDAO db = new DateRoomDAO();
        RoomDAO roomDB = new RoomDAO();
        MovieTimeDAO movietimeDB = new MovieTimeDAO();
        TimeRoomDAO timeroomDB = new TimeRoomDAO();
        MovieDAO movieDB = new MovieDAO();
        String mess = "";
        DateRoom dateroom = db.CheckDateRoomExists(currentDate);
        ArrayList<Room> rooms = roomDB.getRooms();
        boolean check = dateroom != null ? true : false;
        ArrayList<Movie> listMovie = movieDB.getMovies(currentDate);
        if (dateroom != null) {

            ArrayList<MovieTime> slots = movietimeDB.getSlots(dateroom.getDateRoomID());
            int lastSlot;
            if (slots.size() > 0) {
                lastSlot = slots.get(slots.size() - 1).getSlot();
            } else {
                lastSlot = 0;
                check = false;
                mess = "Ngày này chưa có lịch chiếu, hãy thêm slot trước";
                request.setAttribute("date", currentDate);
                request.setAttribute("check", check);
                request.setAttribute("listMovie", listMovie);
                request.setAttribute("listroom", rooms);
                request.setAttribute("mess", mess);
                request.getRequestDispatcher("view/AdminSetupSchedule.jsp").forward(request, response);
            }
            if (rooms.size() < 1) {
                check = false;
                mess = "Phòng chiếu chưa có, hãy thêm phòng chiếu trước";
                request.setAttribute("date", currentDate);
                request.setAttribute("check", check);
                request.setAttribute("mess", mess);
                request.getRequestDispatcher("view/AdminSetupSchedule.jsp").forward(request, response);
            }

            ArrayList<TimeRoom> listTimeRoom = timeroomDB.getAllTimeRoomByDateRoom(dateroom.getDateRoomID());
            request.setAttribute("listroom", rooms);
            request.setAttribute("lastSlot", lastSlot);
            request.setAttribute("listMovie", listMovie);
            request.setAttribute("listTimeRoom", listTimeRoom);
            request.setAttribute("listSlot", slots);
            request.setAttribute("mess", mess);
            request.setAttribute("check", check);
            request.setAttribute("date", currentDate);
            request.getRequestDispatcher("view/AdminSetupSchedule.jsp").forward(request, response);

        } else {
            mess = "Ngày này chưa có lịch chiếu, cập nhật ngay!";
            request.setAttribute("date", currentDate);
            request.setAttribute("listMovie", listMovie);
            request.setAttribute("listroom", rooms);
            request.setAttribute("mess", mess);
            request.setAttribute("check", check);
            request.getRequestDispatcher("view/AdminSetupSchedule.jsp").forward(request, response);
        }
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
