/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.MovieDAO;
import DAL.MovieTimeDAO;
import DAL.RoomDAO;
import DAL.TimeRoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Movie;
import model.MovieTime;
import model.Room;
import model.TimeRoom;

/**
 *
 * @author Quan
 */
public class BookingMovieController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

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
        ZoneId zid = ZoneId.of("Asia/Ho_Chi_Minh");
        LocalDate ld = LocalDate.now(zid);
        LocalTime lt = LocalTime.now(zid);
        Date currentDate = Date.valueOf(ld); //lấy date hiện tại
        Time currentTime = Time.valueOf(lt); //time hien tai

        ArrayList<Date> listDate = new ArrayList<>(); //lay dsach 12 ngay tiep theo tu ngay hien tai
        listDate.add(currentDate);
        Date nextDay = currentDate;
        for (int i = 1; i < 12; i++) {
            nextDay = Date.valueOf(nextDay.toLocalDate().plusDays(1));
            listDate.add(nextDay);
        }

        MovieDAO db = new MovieDAO();
        MovieTimeDAO movietimeDB = new MovieTimeDAO();
        RoomDAO roomDB = new RoomDAO();
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        int typeRoomChoice = request.getParameter("typeRoom") != null ? Integer.parseInt(request.getParameter("typeRoom")) : 1;
        int typeRoom;

        ArrayList<Room> listRoom = roomDB.getRoomByDateAndMovie(currentDate, movieId);
        ArrayList<MovieTime> listSlot = movietimeDB.getSlotByDateAndMovie(currentDate, movieId, typeRoomChoice);
        Movie movie = db.getMovieById(movieId);

        if (listRoom.size() == 0) {//ktra xem có loại phòng nào
            typeRoom = 0;
        } else {
            typeRoom = 1;
            for (Room r : listRoom) {
                if (r.getRoomName().contains("VIP")) {
                    typeRoom = 2;
                    break;
                }
            }
        }

        try ( PrintWriter out = response.getWriter()) {
            out.println("<div class=\"modal-nofi-overlay\"></div>  \n"
                    + "            <div class=\"modal-add modal-dialog-scrollable\" role=\"document\"  >  \n"
                    + "           <button onclick=\"closeModal()\"  id=\"cboxClose\" ></button> \n"
                    + "                <div class=\"modal-body row\" style=\"padding: 0.5rem\">  \n"
                    + "\n"
                    + "                    <div class=\"body-modal\">\n"
                    + "\n"
                    + "                        <div class=\"row\" style=\"margin-top: 10px;\">\n"
                    + "\n"
                    + "                            <div style=\"width: 29%\">\n"
                    + "                                <img src=\"" + movie.getImage() + "\" alt=\"poster\" width=\"100%\" height=\"auto\">\n"
                    + "                            </div>\n"
                    + "                            <div id=\"left-modal\" style=\"width: 71%;\">\n"
                    + "                                <div class=\"title-body-modal\"  >\n"
                    + "                                    <h3 style=\"margin-bottom: auto;margin-top: auto;text-align: center\">PHIM " + movie.getMovieName().toUpperCase() + "</h3>\n"
                    + "                                </div>\n"
                    + "                                <div id=\"cboxLoadedContent\" style=\" overflow: auto;margin-top: 5px;\">\n"
                    + "                                    <ul class=\"toggle-tabs\">\n");
            SimpleDateFormat month = new SimpleDateFormat("MM");
            SimpleDateFormat thu = new SimpleDateFormat("EEE");
            SimpleDateFormat day = new SimpleDateFormat("dd");

            String text = "";
            for (int i = 0; i < listDate.size(); i++) {

                if (i == 0) {
                    out.print("   <li class=\"current\" >\n"
                            + "                                            <div class=\"day\" onclick=\"SelectDay(movieId, date)\">\n");
                    text = month.format(listDate.get(i));
                    out.print("                                                 <span>" + text + "</span>\n");
                    text = thu.format(listDate.get(i));
                    out.print("                                                <em>" + text + "</em>\n");
                    text = day.format(listDate.get(i));
                    out.print("                                                <strong>" + text + "</strong>\n");
                    out.print("                                            </div>\n"
                            + "\n"
                            + "                                        </li>");
                } else {
                    out.print("   <li >\n"
                            + "                                            <div class=\"day\" onclick=\"SelectDay(" + movie.getMovieId() + ",'" + listDate.get(i) + "' )\">\n");
                    text = month.format(listDate.get(i));
                    out.print("                                                 <span>" + text + "</span>\n");
                    text = thu.format(listDate.get(i));
                    out.print("                                                <em>" + text + "</em>\n");
                    text = day.format(listDate.get(i));
                    out.print("                                                <strong>" + text + "</strong>\n");
                    out.print("                                            </div>\n"
                            + "\n"
                            + "                                        </li>");
                }
            }

            out.print("\n"
                    + "                                    </ul>\n"
                    + "                                </div>\n"
                    + "       \n");

            if (typeRoom == 0) {
                out.print("                                <div class=\"choice-room \" style=\"border-bottom: none;\">\n"
                        + "                                    <div id=\"cboxLoadedContent\" style=\" overflow: auto;\">\n"
                        + "                                        <ul class=\"toggle-tabs\" >\n"
                        + "  <li class=\"current\" style=\"margin: 5px;background: none;color: red\" >\n"
                        + "                                                    <p>Ngày này chưa có lịch chiếu, hãy đợi sau nha!</p>\n"
                        + "                                            </li >\n");
                out.print("                                        </ul>\n"
                        + "                                    </div>\n"
                        + "                                </div>\n");
                out.print("                            </div>\n"
                        + "\n"
                        + "\n"
                        + "                        </div>\n"
                        + "\n"
                        + "                    </div>\n"
                        + "                </div>  \n"
                        + "\n"
                        + "            </div>");
            } else {
                if (typeRoom == 1) {
                    out.print("                                <div class=\"choice-room \" >\n"
                            + "                                    <div id=\"cboxLoadedContent\" style=\" overflow: auto;\">\n"
                            + "                                        <ul class=\"toggle-tabs\" >\n"
                            + "                                            <li class=\"current\" style=\"margin: 5px;\" >\n"
                            + "                                                <div class=\"day\" onclick=\"SelectRoom(" + movie.getMovieId() + ",'" + currentDate + "',1)\" style=\"width: 100px;height: 35px;text-align: center;font-weight: bold;font-size: 20px;\">\n"
                            + "                                                    <span>Phòng 2D</span>\n"
                            + "                                                </div>\n"
                            + "                                            </li >\n");
                }
                if (typeRoom == 2) {
                    if (typeRoomChoice == 1) {
                        out.print("                                <div class=\"choice-room \" >\n"
                                + "                                    <div id=\"cboxLoadedContent\" style=\" overflow: auto;\">\n"
                                + "                                        <ul class=\"toggle-tabs\" >\n"
                                + "                                            <li class=\"current\" style=\"margin: 5px;\" >\n"
                                + "                                                <div class=\"day\" onclick=\"SelectRoom(" + movie.getMovieId() + ",'" + currentDate + "',1)\" style=\"width: 100px;height: 35px;text-align: center;font-weight: bold;font-size: 20px;\">\n"
                                + "                                                    <span>Phòng 2D</span>\n"
                                + "                                                </div>\n"
                                + "                                            </li >\n");

                        out.print("                                            <li style=\"margin: 5px;\">\n"
                                + "                                                <div class=\"day\" onclick=\"SelectRoom(" + movie.getMovieId() + ",'" + currentDate + "',2)\" style=\"width: 100px;height: 35px;text-align: center;font-weight: bold;font-size: 20px;\">\n"
                                + "                                                    <span >Phòng 3D</span>\n"
                                + "                                                </div>\n"
                                + "                                            </li>\n");
                    } else {
                        out.print("                                <div class=\"choice-room \" >\n"
                                + "                                    <div id=\"cboxLoadedContent\" style=\" overflow: auto;\">\n"
                                + "                                        <ul class=\"toggle-tabs\" >\n"
                                + "                                            <li style=\"margin: 5px;\" >\n"
                                + "                                                <div class=\"day\" onclick=\"SelectRoom(" + movie.getMovieId() + ",'" + currentDate + "',1)\" style=\"width: 100px;height: 35px;text-align: center;font-weight: bold;font-size: 20px;\">\n"
                                + "                                                    <span>Phòng 2D</span>\n"
                                + "                                                </div>\n"
                                + "                                            </li >\n");

                        out.print("                                            <li class=\"current\" style=\"margin: 5px;\">\n"
                                + "                                                <div class=\"day\" onclick=\"SelectRoom(" + movie.getMovieId() + ",'" + currentDate + "',2)\" style=\"width: 100px;height: 35px;text-align: center;font-weight: bold;font-size: 20px;\">\n"
                                + "                                                    <span >Phòng 3D</span>\n"
                                + "                                                </div>\n"
                                + "                                            </li>\n");
                    }
                }
                out.print("                                        </ul>\n"
                        + "                                    </div>\n"
                        + "                                </div>\n");
                if (listSlot.size() < 1) {   // khi suất chiếu hết
                    out.print("<div class=\"choice-slot \" style=\"border-bottom: none;\" >\n"
                            + "                                    <div id=\"cboxLoadedContent\" style=\" overflow: auto;height: 100%;\">\n"
                            + "                                        <ul class=\"toggle-tabs\" >\n"
                            + "                                            <li  style=\"margin: 5px;color: red;\" >\n"
                            + "                                                    <p>Đã hết suất chiếu ngày này, ghé thăm vào ngày khác nha</p>\n"
                            + "                                            </li >");
                } else {  //khi suất chiếu còn
                    out.print("                                <div class=\"choice-slot \" >\n"
                            + "                                    <div id=\"cboxLoadedContent\" style=\" overflow: auto;height: 100%;\">\n"
                            + "                                        <ul class=\"toggle-tabs\" >\n");

                    SimpleDateFormat time = new SimpleDateFormat("HH:mm a");
                    for (MovieTime s : listSlot) {
                        if (s.getStart().after(currentTime)) {
                            
                            out.print("<li class=\"current\" style=\"margin: 5px;\" >\n"
                                + "                                                <form action=\"bookseat\" method=\"post\">\n"
                                + "                                                    <input type=\"text\" name=\"movieId\" value=\""+movie.getMovieId()+"\" hidden>\n"
                                + "                                                    <input type=\"text\" name=\"date\" value=\""+currentDate+"\" hidden>\n"
                                + "                                                    <input type=\"text\" name=\"typeRoom\" value=\""+typeRoomChoice+"\" hidden>\n"
                                + "                                                    <input type=\"text\" name=\"movietimeId\" value=\""+s.getMovieTimeId()+"\" hidden>\n"
                                + "                                                    <button class=\"time\" style=\"border:1px;\"  type=\"submit\" >\n"
                                + "                                                        <span>" + time.format(s.getStart()) + "</span>\n"
                                + "                                                    </button>\n"
                                + "                                                </form>\n"
                                + "                                            </li >");
                        }
                    }
                }

                out.print("                                        </ul>\n"
                        + "                                    </div>\n"
                        + "                                </div>\n"
                        + "                            </div>\n"
                        + "\n"
                        + "\n"
                        + "                        </div>\n"
                        + "\n"
                        + "                    </div>\n"
                        + "                </div>  \n"
                        + "\n"
                        + "            </div>");
            }
        }
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
        ZoneId zid = ZoneId.of("Asia/Ho_Chi_Minh");
        LocalDate ld = LocalDate.now(zid);
        LocalTime lt = LocalTime.now(zid);
        Date currentDate = Date.valueOf(ld); //lấy date hiện tại
        Time currentTime = Time.valueOf(lt); //time hien tai

        ArrayList<Date> listDate = new ArrayList<>(); //lay dsach 12 ngay tiep theo tu ngay hien tai
        listDate.add(currentDate);
        Date nextDay = currentDate;
        for (int i = 1; i < 12; i++) {
            nextDay = Date.valueOf(nextDay.toLocalDate().plusDays(1));
            listDate.add(nextDay);
        }

        MovieDAO db = new MovieDAO();
        MovieTimeDAO movietimeDB = new MovieTimeDAO();
        RoomDAO roomDB = new RoomDAO();
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        int typeRoomChoice = request.getParameter("typeRoom") != null ? Integer.parseInt(request.getParameter("typeRoom")) : 1;
        Date dateChoice = request.getParameter("dateChoice") != null ? Date.valueOf(request.getParameter("dateChoice")) : currentDate;
        int typeRoom;
        ArrayList<Room> listRoom = null;
        ArrayList<MovieTime> listSlot = null;
        if (dateChoice.equals(currentDate)) {
            listRoom = roomDB.getRoomByDateAndMovie(dateChoice, movieId);
            listSlot = movietimeDB.getSlotByDateAndMovie(dateChoice, movieId, typeRoomChoice);
        } else {
            listRoom = roomDB.getRoomByDateAndMovie(dateChoice, movieId);
            listSlot = movietimeDB.getSlotByDateOrther(dateChoice, movieId, typeRoomChoice);
        }
        Movie movie = db.getMovieById(movieId);

        if (listRoom.size() == 0) {//ktra xem có loại phòng nào
            typeRoom = 0;
        } else {
            typeRoom = 1;
            for (Room r : listRoom) {
                if (r.getRoomName().contains("VIP")) {
                    typeRoom = 2;
                    break;
                }
            }
        }

        try ( PrintWriter out = response.getWriter()) {
            out.print("                                <div class=\"title-body-modal\"  >\n"
                    + "                                    <h3 style=\"margin-bottom: auto;margin-top: auto;text-align: center\">PHIM " + movie.getMovieName().toUpperCase() + "</h3>\n"
                    + "                                </div>\n"
                    + "                                <div id=\"cboxLoadedContent\" style=\" overflow: auto;margin-top: 5px;\">\n"
                    + "                                    <ul class=\"toggle-tabs\">\n");
            SimpleDateFormat month = new SimpleDateFormat("MM");
            SimpleDateFormat thu = new SimpleDateFormat("EEE");
            SimpleDateFormat day = new SimpleDateFormat("dd");

            String text = "";
            for (int i = 0; i < listDate.size(); i++) {

                if (listDate.get(i).equals(dateChoice)) {
                    out.print("   <li class=\"current\" >\n"
                            + "                                            <div class=\"day\" onclick=\"SelectDay(" + movie.getMovieId() + ",'" + listDate.get(i) + "')\">\n");
                    text = month.format(listDate.get(i));
                    out.print("                                                 <span>" + text + "</span>\n");
                    text = thu.format(listDate.get(i));
                    out.print("                                                <em>" + text + "</em>\n");
                    text = day.format(listDate.get(i));
                    out.print("                                                <strong>" + text + "</strong>\n");
                    out.print("                                            </div>\n"
                            + "\n"
                            + "                                        </li>");
                } else {
                    out.print("   <li >\n"
                            + "                                            <div class=\"day\" onclick=\"SelectDay(" + movie.getMovieId() + ",'" + listDate.get(i) + "' )\">\n");
                    text = month.format(listDate.get(i));
                    out.print("                                                 <span>" + text + "</span>\n");
                    text = thu.format(listDate.get(i));
                    out.print("                                                <em>" + text + "</em>\n");
                    text = day.format(listDate.get(i));
                    out.print("                                                <strong>" + text + "</strong>\n");
                    out.print("                                            </div>\n"
                            + "\n"
                            + "                                        </li>");
                }
            }
            out.print("\n"
                    + "                                    </ul>\n"
                    + "                                </div>\n"
                    + "       \n");

            if (typeRoom == 0) {
                out.print("                                <div class=\"choice-room \" style=\"border-bottom: none;\">\n"
                        + "                                    <div id=\"cboxLoadedContent\" style=\" overflow: auto;\">\n"
                        + "                                        <ul class=\"toggle-tabs\" >\n"
                        + "  <li class=\"current\" style=\"margin: 5px;background: none;color: red\" >\n"
                        + "                                                    <p>Ngày này chưa có lịch chiếu, hãy đợi sau nha!</p>\n"
                        + "                                            </li >\n");
                out.print("                                        </ul>\n"
                        + "                                    </div>\n"
                        + "                                </div>\n");
                out.print("                            </div>\n"
                        + "\n"
                        + "\n"
                        + "                        </div>\n"
                        + "\n"
                        + "                    </div>\n"
                        + "                </div>  \n"
                        + "\n"
                        + "            </div>");
            } else {
                if (typeRoom == 1) {
                    out.print("                                <div class=\"choice-room \" >\n"
                            + "                                    <div id=\"cboxLoadedContent\" style=\" overflow: auto;\">\n"
                            + "                                        <ul class=\"toggle-tabs\" >\n"
                            + "                                            <li class=\"current\" style=\"margin: 5px;\" >\n"
                            + "                                                <div class=\"day\" onclick=\"SelectRoom(" + movie.getMovieId() + ",'" + dateChoice + "',1)\" style=\"width: 100px;height: 35px;text-align: center;font-weight: bold;font-size: 20px;\">\n"
                            + "                                                    <span>Phòng 2D</span>\n"
                            + "                                                </div>\n"
                            + "                                            </li >\n");
                }
                if (typeRoom == 2) {
                    if (typeRoomChoice == 1) {
                        out.print("                                <div class=\"choice-room \" >\n"
                                + "                                    <div id=\"cboxLoadedContent\" style=\" overflow: auto;\">\n"
                                + "                                        <ul class=\"toggle-tabs\" >\n"
                                + "                                            <li class=\"current\" style=\"margin: 5px;\" >\n"
                                + "                                                <div class=\"day\" onclick=\"SelectRoom(" + movie.getMovieId() + ",'" + dateChoice + "',1)\" style=\"width: 100px;height: 35px;text-align: center;font-weight: bold;font-size: 20px;\">\n"
                                + "                                                    <span>Phòng 2D</span>\n"
                                + "                                                </div>\n"
                                + "                                            </li >\n");

                        out.print("                                            <li style=\"margin: 5px;\">\n"
                                + "                                                <div class=\"day\" onclick=\"SelectRoom(" + movie.getMovieId() + ",'" + dateChoice + "',2)\" style=\"width: 100px;height: 35px;text-align: center;font-weight: bold;font-size: 20px;\">\n"
                                + "                                                    <span >Phòng 3D</span>\n"
                                + "                                                </div>\n"
                                + "                                            </li>\n");
                    } else {
                        out.print("                                <div class=\"choice-room \" >\n"
                                + "                                    <div id=\"cboxLoadedContent\" style=\" overflow: auto;\">\n"
                                + "                                        <ul class=\"toggle-tabs\" >\n"
                                + "                                            <li style=\"margin: 5px;\" >\n"
                                + "                                                <div class=\"day\" onclick=\"SelectRoom(" + movie.getMovieId() + ",'" + dateChoice + "',1)\" style=\"width: 100px;height: 35px;text-align: center;font-weight: bold;font-size: 20px;\">\n"
                                + "                                                    <span>Phòng 2D</span>\n"
                                + "                                                </div>\n"
                                + "                                            </li >\n");

                        out.print("                                            <li class=\"current\" style=\"margin: 5px;\">\n"
                                + "                                                <div class=\"day\" onclick=\"SelectRoom(" + movie.getMovieId() + ",'" + dateChoice + "',2)\" style=\"width: 100px;height: 35px;text-align: center;font-weight: bold;font-size: 20px;\">\n"
                                + "                                                    <span >Phòng 3D</span>\n"
                                + "                                                </div>\n"
                                + "                                            </li>\n");
                    }

                }
                out.print("                                        </ul>\n"
                        + "                                    </div>\n"
                        + "                                </div>\n");
                if (listSlot.size() < 1) {   // khi suất chiếu hết
                    out.print("<div class=\"choice-slot \" style=\"border-bottom: none;\" >\n"
                            + "                                    <div id=\"cboxLoadedContent\" style=\" overflow: auto;height: 100%;\">\n"
                            + "                                        <ul class=\"toggle-tabs\" >\n"
                            + "                                            <li  style=\"margin: 5px;color: red;\" >\n"
                            + "                                                    <p>Đã hết suất chiếu ngày này, ghé thăm vào ngày khác nha</p>\n"
                            + "                                            </li >");
                } else {  //khi suất chiếu còn
                    out.print("                                <div class=\"choice-slot \" >\n"
                            + "                                    <div id=\"cboxLoadedContent\" style=\" overflow: auto;height: 100%;\">\n"
                            + "                                        <ul class=\"toggle-tabs\" >\n");

                    SimpleDateFormat time = new SimpleDateFormat("HH:mm a");
                    for (MovieTime s : listSlot) {

                        out.print("<li class=\"current\" style=\"margin: 5px;\" >\n"
                                + "                                                <form action=\"bookseat\" method=\"post\">\n"
                                + "                                                    <input type=\"text\" name=\"movieId\" value=\""+movie.getMovieId()+"\" hidden>\n"
                                + "                                                    <input type=\"text\" name=\"date\" value=\""+dateChoice+"\" hidden>\n"
                                + "                                                    <input type=\"text\" name=\"typeRoom\" value=\""+typeRoomChoice+"\" hidden>\n"
                                + "                                                    <input type=\"text\" name=\"movietimeId\" value=\""+s.getMovieTimeId()+"\" hidden>\n"
                                + "                                                    <button class=\"time\" style=\"border:1px;\"  type=\"submit\" >\n"
                                + "                                                        <span>" + time.format(s.getStart()) + "</span>\n"
                                + "                                                    </button>\n"
                                + "                                                </form>\n"
                                + "                                            </li >");

                    }
                }

                out.print("                                        </ul>\n"
                        + "                                    </div>\n"
                        + "                                </div>\n"
                        + "                            </div>\n"
                        + "\n"
                        + "\n"
                        + "                        </div>\n"
                        + "\n"
                        + "                    </div>\n"
                        + "                </div>  \n"
                        + "\n"
                        + "            </div>");
            }

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
