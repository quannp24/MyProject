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
import java.text.SimpleDateFormat;
import java.time.DateTimeException;
import java.time.LocalTime;
import java.util.ArrayList;
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
public class AddScheduleController extends HttpServlet {

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) //chọn và xử lý thông tin ở modal
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Date date = request.getParameter("date") != null ? Date.valueOf(request.getParameter("date")) : null;
        int movieId = request.getParameter("movieId") != null ? Integer.parseInt(request.getParameter("movieId")) : 0;
        int numberSlot = request.getParameter("slot") != null ? Integer.parseInt(request.getParameter("slot")) : 0;
        int roomId = request.getParameter("roomId") != null ? Integer.parseInt(request.getParameter("roomId")) : 0;
        Time start = request.getParameter("start") != null ? Time.valueOf(request.getParameter("start")) : null;
        Time finish = request.getParameter("finish") != null ? Time.valueOf(request.getParameter("finish")) : null;
        String mess = "";
        boolean checkmovie = false;

        TimeRoomDAO timeroomDB = new TimeRoomDAO();
        MovieTimeDAO movietimeDB = new MovieTimeDAO();
        MovieDAO movieDB = new MovieDAO();
        RoomDAO roomDB = new RoomDAO();
        DateRoomDAO dateroomDB = new DateRoomDAO();

        Movie movie = movieDB.getMovieById(movieId);
        Room room = roomDB.getRoomsByID(roomId);
        DateRoom dateroom = dateroomDB.CheckDateRoomExists(date);
        ArrayList<Room> listRoom = roomDB.getRooms();
        ArrayList<MovieTime> listSlotRoom = null;
        if (roomId != 0) {
            try {
                listSlotRoom = movietimeDB.getSlotByRoomDate(dateroom.getDateRoomID(), room.getRoomId()) == null ? null : movietimeDB.getSlotByRoomDate(dateroom.getDateRoomID(), room.getRoomId());
            } catch (NullPointerException e) {

            }
        }
        MovieTime slot = null;
        if (numberSlot != 0 && start != null && finish != null) {// nếu có thay đổi slot 
            if (listSlotRoom != null) {
                boolean checkError = false;
                if (start.before(finish)) {
                    for (int i = 0; i < listSlotRoom.size(); i++) {
                        if (i == 0 && numberSlot < listSlotRoom.get(i).getSlot()) {// trường hợp vị trí trùng add slot ở đầu
                            if (finish.after(listSlotRoom.get(i).getStart())) { // thời gian kết thúc của slot thêm vào bị trùng với 1 slot khác
                                mess = "Thời gian kết thúc bị trùng với slot khác!";
                                checkError = true;
                            }
                        }
                        if (i != 0 && numberSlot < listSlotRoom.get(i).getSlot()) {  //vị trí trùng add slot ở giữa 2 slot khác
                            if (start.before(listSlotRoom.get(i - 1).getFinish()) || finish.after(listSlotRoom.get(i).getStart())) {
                                mess = "Thời gian bị trùng với slot nào đó!";
                                checkError = true;
                            }
                        }
                        if (i == listSlotRoom.size() - 1 && numberSlot > listSlotRoom.get(i).getSlot()) { //vị trí trùng add slot ở cuối
                            if (start.before(listSlotRoom.get(i).getFinish())) {
                                mess = "Thời gian bắt đầu trùng với slot nào đó!";
                                checkError = true;
                            }
                        }
                    }
                    if (movie != null) {
                        LocalTime addMinute = start.toLocalTime();
                        Time maxTime = Time.valueOf(addMinute.plusMinutes(movie.getDuration()));
                        if (finish.before(maxTime)) {
                            mess = "Thời gian kết thúc không phù hợp với thời lượng của phim bạn chọn.";
                            checkError = true;
                        }

                    }
                } else {
                    mess = "Thời gian bắt đầu phải trước thời gian kết thúc!";
                    checkError = true;
                }
                if (!checkError) {
                    MovieTime newSlot = new MovieTime();
                    newSlot.setFinish(finish);
                    newSlot.setSlot(numberSlot);
                    newSlot.setStart(start);
                    newSlot.setDateRoomID(dateroom.getDateRoomID());
                    slot = newSlot;
                }
            } else {
                boolean checkError = false;
                if (movie != null) {
                    LocalTime addMinute = start.toLocalTime();
                    Time maxTime = Time.valueOf(addMinute.plusMinutes(movie.getDuration()));
                    if (finish.before(maxTime)) {
                        mess = "Thời gian kết thúc không phù hợp với thời lượng của phim bạn chọn.";
                        checkError = true;
                    }

                }
                if (!checkError) {
                    MovieTime newSlot = new MovieTime();
                    newSlot.setFinish(finish);
                    newSlot.setSlot(numberSlot);
                    newSlot.setStart(start);
                    slot = newSlot;
                }
            }
        }
        if (movieId != 0 && roomId != 0 && numberSlot != 0 && dateroom != null) {
            if (timeroomDB.checkMovieDuplicate(numberSlot, room.getRoomName().contains("Cinema"), dateroom.getDateRoomID(), movieId)) {
                mess = "Phim chiếu cùng loại phòng không được trùng!";
                checkmovie = true;
            } else {
                movie = movieDB.getMovieById(movieId);
            }
        }
        ArrayList<Movie> listMovie = null;
        ArrayList<Integer> listMovieIDExists = null;
        if (slot != null && room != null && dateroom != null) {
            listMovieIDExists = timeroomDB.getListMovieExists(slot.getSlot(), slot.getDateRoomID(), room.getRoomName().contains("Cinema"));
        }
        if (listMovieIDExists != null) {
            listMovie = movieDB.getMoviesSlot(dateroom.getDateRoom(), listMovieIDExists);
        } else {
            listMovie = movieDB.getMovies(date);
        }
        try ( PrintWriter out = response.getWriter()) {
            out.print("<div class=\"modal-nofi\" id=\"admin-add-modal\" >\n"
                    + "                <div class=\"modal-nofi-overlay\"></div>\n"
                    + "                <div class=\"modal-add modal-dialog-scrollable\">\n"
                    + "                    <form class=\"full-width\" id=\"Add-form\" action=\"updateschedule\" method=\"post\">\n"
                    + "                        <h5 class=\"modal-add-title\">Thêm lịch chiếu phim</h5>\n"
                    + "                        <div class=\"modal-add-body\">\n"
                    + "                            <div class=\"add-input-option\">\n"
                    + "                                <input name=\"dateRoom\" value=\"" + date + "\"hidden=\"\" required> \n");
            if (movie != null && !checkmovie) {
                out.print("                                <input name=\"movieId\" value=\"" + movie.getMovieId() + "\"hidden=\"\" required> \n");
            } else {
                out.print("                                <input name=\"movieId\" value=\"\"hidden=\"\" required> \n");
            }
            if (room != null) {
                out.print("                                <input name=\"roomId\" value=\"" + room.getRoomId() + "\"hidden=\"\" required> \n");
            } else {
                out.print("                                <input name=\"roomId\" value=\"\"hidden=\"\" required> \n");
            }
            if (slot != null) {
                out.print("                                <input name=\"slot\" value=\"" + slot.getSlot() + "\"hidden=\"\" required> \n"
                        + "                                <input name=\"start\" value=\"" + slot.getStart() + "\"hidden=\"\" required> \n"
                        + "                                <input name=\"finish\" value=\"" + slot.getFinish() + "\"hidden=\"\" required> \n");
            } else {
                out.print("                                <input name=\"slot\" value=\"\"hidden=\"\" required> \n"
                        + "                                <input name=\"start\" value=\"\"hidden=\"\" required> \n"
                        + "                                <input name=\"finish\" value=\"\"hidden=\"\" required> \n");
            }
            out.print("\n"
                    + "\n"
                    + "                                <label>Phim chiếu </label>                              \n");
            if (movie != null && !checkmovie) {
                out.print("                                <input class=\"\" name=\"\" value=\"" + movie.getMovieName() + "\" placeholder=\"\" readonly required=\"\">\n");
            } else {
                out.print("                                <input class=\"\" name=\"\" value=\"\" placeholder=\"\" readonly required=\"\">\n");
            }
            out.print("                                <button type=\"button\" onclick=\"openChooseMovie()\" class=\"btn-change-option\">Chọn</button>\n"
                    + "                            </div>\n"
                    + "                            <div class=\"add-input-option\">\n"
                    + "                                <label>Phòng </label>  \n");
            if (room != null) {
                out.print("                                <input class=\"\" value=\"" + room.getRoomName() + "\" type=\"\" placeholder=\"\"readonly required=\"\">\n");
            } else {
                out.print("                                <input class=\"\" value=\"\" type=\"\" placeholder=\"\"readonly required=\"\">\n");
            }
            out.print("                                <button type=\"button\" onclick=\"openchooseRoom()\" class=\"btn-change-option\">Chọn</button>\n"
                    + "                            </div>\n"
                    + "                            <div class=\"add-input-option\">\n"
                    + "                                <label>Slot </label>  \n");
            SimpleDateFormat time = new SimpleDateFormat("HH:mm a");
            if (slot != null) {
                out.print("                                    <input class=\"\"  value=\"Slot " + slot.getSlot() + " từ " + time.format(slot.getStart()) + " đến " + time.format(slot.getFinish()) + "\" type=\"text\" placeholder=\"\" readonly required=\"\">\n");
            } else {
                out.print("                                    <input class=\"\"  value=\"\" type=\"text\" placeholder=\"\" readonly required=\"\">\n");
            }
            out.print("<button onclick=\"openChooseTime()\" type=\"button\" class=\"btn-change-option\">Chọn</button>\n"
                    + "                                </div>\n"
                    + "\n"
                    + "                                <div class=\"text-center\">\n"
                    + "                                    <label id=\"mess-text\" style=\"color: red\">" + mess + "</label>  \n"
                    + "\n"
                    + "                            </div>\n"
                    + "\n"
                    + "\n"
                    + "                        </div>\n"
                    + "                        <div class=\"modal-btn\">\n"
                    + "                            <button type=\"button\" onclick=\"checkSubmitFormAdd()\" class=\"custom-btn btn-crud\"><span>Thêm ngay !</span><span>Thêm</span></button>\n"
                    + "                            <button type=\"button\" onclick=\"closeModal()\" class=\"custom-btn btn-crud\"><span>Đóng ngay !</span><span>Đóng</span></button>\n"
                    + "                        </div> \n"
                    + "                    </form>\n"
                    + "                </div>\n"
                    + "            </div>");

            out.print("<div class=\"modal-nofi modal-choose\" id=\"modal-choose-movie\">\n"
                    + "                <div class=\"modal-nofi-overlay\"></div>\n"
                    + "                <div class=\"modal-add-movie modal-dialog-scrollable\">\n"
                    + "                    <form class=\"full-width\" action=\"\" method=\"post\">\n"
                    + "                        <h5 class=\"modal-add-title\">Chọn phim chiếu</h5>\n"
                    + "                        <div class=\"modal-add-body\">\n"
                    + "                            <div class=\"table-responsive\">\n"
                    + "                                <table class=\"table\">\n"
                    + "                                    <thead>\n"
                    + "                                        <tr>\n"
                    + "\n"
                    + "                                            <th scope=\"col\">Tên phim</th>\n"
                    + "                                            <th scope=\"col\" style=\"width: 20%\">Thể loại</th>\n"
                    + "                                            <th scope=\"col\" style=\"width: 15%\">Thời lượng</th>\n"
                    + "                                            <th scope=\"col\" style=\"width: 20%\">Khởi chiếu</th>\n"
                    + "                                            <th scope=\"col\" style=\"width: 5%\"></th>\n"
                    + "                                        </tr>\n"
                    + "                                    </thead>\n"
                    + "                                    <tbody>\n"
                    + "\n"
                    + "\n");

            for (Movie m : listMovie) {

                out.print("                                            <tr>\n"
                        + "\n"
                        + "                                                <td style=\"font-weight: bold\">" + m.getMovieName() + "</td>\n"
                        + "                                                <td>" + m.getCategory() + "</td>\n"
                        + "                                                <td>" + m.getDuration() + "</td>\n"
                        + "                                                <td>" + m.getStartdate() + "</td>\n"
                        + "                                                    <td><a style=\"cursor: pointer\" onclick=\"ChooseMovie(" + roomId + "," + m.getMovieId() + ",'" + date + "')\">Chọn</a></td>\n"
                        + "\n"
                        + "                                            </tr>\n"
                        + "\n");
            }
            out.print("\n"
                    + "                                    </tbody>\n"
                    + "                                </table>\n"
                    + "                            </div>\n"
                    + "                        </div>\n"
                    + "                        <div class=\"modal-btn\">\n"
                    + "                            <button type=\"button\" onclick=\"closeModalChoose()\" class=\"custom-btn btn-crud\"><span>Đóng !</span><span>Đóng</span></button>\n"
                    + "                        </div> \n"
                    + "                    </form>\n"
                    + "                </div>\n"
                    + "            </div>");

            out.print("<div class=\"modal-nofi modal-choose\" id=\"modal-choose-room\">\n"
                    + "                <div class=\"modal-nofi-overlay\"></div>\n"
                    + "                <div class=\"modal-add-small modal-dialog-scrollable\">\n"
                    + "                    <form class=\"full-width\" action=\"\" method=\"post\">\n"
                    + "                        <h5 class=\"modal-add-title\">Chọn phòng</h5>\n"
                    + "                        <div class=\"modal-add-body\">\n"
                    + "                            <div class=\"table-responsive\">\n"
                    + "                                <table class=\"table\">\n"
                    + "                                    <thead>\n"
                    + "                                        <tr>\n"
                    + "                                            <th scope=\"col\">Phòng</th>\n"
                    + "                                            <th scope=\"col\"></th>\n"
                    + "                                        </tr>\n"
                    + "                                    </thead>\n"
                    + "                                    <tbody>\n"
                    + "\n");

            for (Room r : listRoom) {
                out.print("                                        <tr>\n"
                        + "                                            <td>" + r.getRoomName() + "</td>\n"
                        + "                                             <td><a style=\"cursor: pointer\" onclick=\"ChooseRoom(" + movieId + ",'" + date + "'," + r.getRoomId() + ")\">Chọn</a></td>\n"
                        + "\n"
                        + "                                        </tr>\n");
            }

            out.print("                                    </tbody>\n"
                    + "                                </table>\n"
                    + "                            </div>\n"
                    + "                        </div>\n"
                    + "                        <div class=\"modal-btn\">\n"
                    + "                            <button type=\"button\" onclick=\"closeModalChoose()\" class=\"custom-btn btn-crud\"><span>Close !</span><span>Close</span></button>\n"
                    + "                        </div> \n"
                    + "                    </form>\n"
                    + "                </div>\n"
                    + "            </div>"
            );

            out.print("<div class=\"modal-nofi modal-choose\" id=\"modal-choose-slot\">\n"
                    + "                <div class=\"modal-nofi-overlay\"></div>\n"
                    + "                <div class=\"modal-add-medium modal-dialog-scrollable\">\n"
                    + "                    <!--<form class=\"full-width\" action=\"updateschedule\" method=\"get\">-->\n"
                    + "                    <div class=\"full-width\">\n"
                    + "                        <h5 class=\"modal-add-title\">Chọn slot</h5>\n"
                    + "                        <div class=\"modal-add-body\">\n"
                    + "                            <div class=\"table-responsive\">\n"
                    + "                                <table class=\"table\">\n"
                    + "                                    <thead>\n"
                    + "                                        <tr>\n"
                    + "                                            <th scope=\"col\">Slot</th>\n"
                    + "                                            <th scope=\"col\">Bắt đầu</th>\n"
                    + "                                            <th scope=\"col\">Kết thúc</th>\n"
                    + "                                            <th scope=\"col\"></th>\n"
                    + "                                        </tr>\n"
                    + "                                    </thead>\n"
                    + "                                    <tbody>\n");
            if (listSlotRoom != null) {
                int count = 0;
                for (int i = 1; i <= 10; i++) {
                    boolean check = false;
                    for (MovieTime sr : listSlotRoom) {
                        if (sr.getSlot() == i) {
                            out.print("                                            <tr>\n"
                                    + "                                                <td>" + sr.getSlot() + "</td>\n"
                                    + "                                                <td>" + time.format(sr.getStart()) + "</td>\n"
                                    + "                                                <td>" + time.format(sr.getFinish()) + "</td>\n"
                                    + "\n"
                                    + "                                                <td><a>Đã chọn</a></td>\n"
                                    + "                                            </tr>\n");
                            check = true;
                            break;
                        }
                    }
                    if (!check) {
                        out.print("<tr>\n"
                                + "<td>" + i + "</td>"
                                + "<td><input onchange=\"valueSubmitAdd('" + date + "'," + count + "," + i + "," + roomId + "," + movieId + ")\" style=\"margin-top: 5px;\" type=\"time\" id=\"start\"  required></td>\n"
                                + " <td><input onchange=\"valueSubmitAdd('" + date + "'," + count + "," + i + "," + roomId + "," + movieId + ")\" style=\"margin-top: 5px;\" type=\"time\" id=\"finish\" required></td>\n"
                                + " <td><button id=\"submit-time\" class=\"btn-movie \" ><a>Chọn</a></button></td>"
                                + " </tr>\n");
                        count++;
                    }
                }
            } else {
                if (dateroom == null) {
                    int count = 0;
                    for (int i = 1; i <= 10; i++) {
                        boolean check = false;

                        out.print("<tr>\n"
                                + "<td>" + i + "</td>"
                                + "<td><input onchange=\"valueSubmitAdd('" + date + "'," + count + "," + i + "," + roomId + "," + movieId + ")\" style=\"margin-top: 5px;\" type=\"time\" id=\"start\"  required></td>\n"
                                + " <td><input onchange=\"valueSubmitAdd('" + date + "'," + count + "," + i + "," + roomId + "," + movieId + ")\" style=\"margin-top: 5px;\" type=\"time\" id=\"finish\" required></td>\n"
                                + " <td><button id=\"submit-time\" class=\"btn-movie \" ><a>Chọn</a></button></td>"
                                + " </tr>\n");
                        count++;

                    }
                }
            }

            out.print("                                    </tbody>\n"
                    + "                                </table>\n"
                    + "                            </div>\n"
                    + "                        </div>\n"
                    + "                        <div class=\"modal-btn\">\n"
                    + "                            <button type=\"button\" onclick=\"closeModalChoose()\" class=\"custom-btn btn-crud\"><span>Close !</span><span>Close</span></button>\n"
                    + "                        </div> \n"
                    + "\n"
                    + "                    </div>\n"
                    + "                </div>\n"
                    + "            </div>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) //thêm slot mới
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String raw_date = request.getParameter("dateRoom");
        String raw_movieId = request.getParameter("movieId");
        String raw_roomid = request.getParameter("roomId");
        String raw_slot = request.getParameter("slot");
        String raw_start = request.getParameter("start");
        String raw_finish = request.getParameter("finish");
        int slot = 0;
        int movieId = 0;
        int roomId = 0;
        Time start = null;
        Time finish = null;
        Date date = null;
        String mess = "";
        try {
            slot = Integer.parseInt(raw_slot);
        } catch (NumberFormatException e) {
            Logger.getLogger(AdminSetupScheduleController.class.getName()).log(Level.SEVERE, null, e);
        }
        try {
            movieId = Integer.parseInt(raw_movieId);
        } catch (NumberFormatException e) {
            Logger.getLogger(AdminSetupScheduleController.class.getName()).log(Level.SEVERE, null, e);
        }
        try {
            roomId = Integer.parseInt(raw_roomid);
        } catch (NumberFormatException e) {
            Logger.getLogger(AdminSetupScheduleController.class.getName()).log(Level.SEVERE, null, e);
        }
        try {
            start = Time.valueOf(raw_start);
            finish = Time.valueOf(raw_finish);
        } catch (DateTimeException e) {
            Logger.getLogger(AdminSetupScheduleController.class.getName()).log(Level.SEVERE, null, e);
        }
        try {
            date = Date.valueOf(raw_date);
        } catch (DateTimeException e) {
            Logger.getLogger(AdminSetupScheduleController.class.getName()).log(Level.SEVERE, null, e);
        }
        DateRoomDAO dateroomDB = new DateRoomDAO();
        MovieTimeDAO movietimeDB = new MovieTimeDAO();
        TimeRoomDAO timeroomDB = new TimeRoomDAO();
        DateRoom dateroom = dateroomDB.CheckDateRoomExists(date);
        if (dateroom != null) { //date da co trong database
            MovieTime mt = new MovieTime();
            mt.setSlot(slot);
            mt.setStart(start);
            mt.setFinish(finish);
            mt.setDateRoomID(dateroom.getDateRoomID());
            MovieTime m = movietimeDB.CheckMovieTimeExists(mt);//check đã có movietime có slot nào có start finish date trùng với cái đã nhập và lấy ra
            if (m != null) {//neu có cái trùng
                TimeRoom t = new TimeRoom();
                t.setMovieId(movieId);
                t.setRoomId(roomId);
                t.setMovieTimeId(m.getMovieTimeId());
                if (timeroomDB.addTimeRoom(t) > 0) {
                    mess = "Thêm thành công";
                    request.setAttribute("messAdd", mess);
                    request.setAttribute("date", date);
                    request.getRequestDispatcher("setupschedule?date=" + date).forward(request, response);
                } else {
                    mess = "Lỗi thêm ở phần phòng hoặc phim";
                    request.setAttribute("messError", mess);
                    request.getRequestDispatcher("setupschedule?date=" + date).forward(request, response);
                }
            } else {// không có cái trùng
                m = movietimeDB.addSlot(mt); //thì thêm mới 1 cái và trả về movietime vừa thêm mới
                if (m != null) {//nếu thêm movietime thành công
                    TimeRoom t = new TimeRoom();
                    t.setMovieId(movieId);
                    t.setRoomId(roomId);
                    t.setMovieTimeId(m.getMovieTimeId());
                    if (timeroomDB.addTimeRoom(t) > 0) { //thêm thành công timeroom với cái movietimeId đã đc add mới
                        mess = "Thêm thành công";
                        request.setAttribute("messAdd", mess);
                        request.setAttribute("date", date);
                        request.getRequestDispatcher("setupschedule?date=" + date).forward(request, response);
                    } else {// thêm thất bại
                        mess = "Lỗi thêm ở phần phòng hoặc phim";
                        request.setAttribute("messError", mess);
                        request.getRequestDispatcher("setupschedule?date=" + date).forward(request, response);
                    }
                } else {//thêm ko thành công
                    mess = "Lỗi thêm ở phần slot";
                    request.setAttribute("messError", mess);
                    request.getRequestDispatcher("setupschedule?date=" + date).forward(request, response);
                }
            }
        } else {// date chua co trong database
            if (dateroomDB.addDate(date) > 0) { //add thanh cong date moi
                dateroom = dateroomDB.CheckDateRoomExists(date);// lấy dateroom vừa đc thêm vào
                MovieTime mt = new MovieTime();
                mt.setSlot(slot);
                mt.setStart(start);
                mt.setFinish(finish);
                mt.setDateRoomID(dateroom.getDateRoomID());
                MovieTime m = movietimeDB.addSlot(mt);
                if (m != null) {//thêm movietime thành công và trả về movietime đã thêm
                    TimeRoom t = new TimeRoom();
                    t.setMovieId(movieId);
                    t.setRoomId(roomId);
                    t.setMovieTimeId(m.getMovieTimeId());
                    if (timeroomDB.addTimeRoom(t) > 0) {
                        mess = "Thêm thành công";
                        request.setAttribute("messAdd", mess);
                        //request.setAttribute("date", date);
                        request.getRequestDispatcher("setupschedule?date=" + date).forward(request, response);
                    } else {
                        mess = "Lỗi thêm ở phần phòng hoặc phim";
                        request.setAttribute("messError", mess);
                        request.getRequestDispatcher("setupschedule?date=" + date).forward(request, response);
                    }

                } else {// thêm movietime ko thành công thì báo lỗi
                    mess = "Lỗi thêm ở phần slot";
                    request.setAttribute("messError", mess);
                    request.getRequestDispatcher("setupschedule?date=" + date).forward(request, response);
                }
            } else {// ko add dc date moi
                mess = "Lỗi thêm ngày mới";
                request.setAttribute("messError", mess);
                request.getRequestDispatcher("setupschedule?date=" + date).forward(request, response);
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
