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
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.ArrayList;
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
public class EditScheduleController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditScheduleController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditScheduleController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        int timeroomId = request.getParameter("timeroomId") != null ? Integer.parseInt(request.getParameter("timeroomId")) : 0;
        int movieId = request.getParameter("movieId") != null ? Integer.parseInt(request.getParameter("movieId")) : 0;
        int numberSlot = request.getParameter("slot") != null ? Integer.parseInt(request.getParameter("slot")) : 0;
        int roomId = request.getParameter("roomId") != null ? Integer.parseInt(request.getParameter("roomId")) : 0;
        Time start = request.getParameter("start") != null ? Time.valueOf(request.getParameter("start")) : null;
        Time finish = request.getParameter("finish") != null ? Time.valueOf(request.getParameter("finish")) : null;
        String mess = "";

        TimeRoomDAO timeroomDB = new TimeRoomDAO();
        MovieTimeDAO movietimeDB = new MovieTimeDAO();
        MovieDAO movieDB = new MovieDAO();
        RoomDAO roomDB = new RoomDAO();
        DateRoomDAO dateroomDB = new DateRoomDAO();

        TimeRoom timeroom = timeroomDB.getTimeRoomById(timeroomId);
        MovieTime slot = movietimeDB.getSlotByMovieTimeId(timeroom.getMovieTimeId());
        Movie movie = movieDB.getMovieById(movieId != 0 ? movieId : timeroom.getMovieId());
        Room room = roomDB.getRoomsByID(roomId != 0 ? roomId : timeroom.getRoomId());
        DateRoom dateroom = dateroomDB.getDateRoomByMovieTimeID(timeroom.getMovieTimeId());
//        ArrayList<Movie> listMovie = movieDB.getMovies(dateroom.getDateRoom());
        ArrayList<Room> listRoom = roomDB.getRooms();
        ArrayList<MovieTime> listSlotRoom = movietimeDB.getSlotByRoomDate(slot.getDateRoomID(), room.getRoomId());

        boolean checkmovie = false; // dùng để check movie trùng

        if (numberSlot != 0 && start != null && finish != null) {// nếu có thay đổi slot 
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
                newSlot.setDateRoomID(slot.getDateRoomID());
                slot = newSlot;
            }
        }
        if (movieId != 0 || roomId != 0 || numberSlot != 0) {
            if (timeroomDB.checkMovieDuplicate(slot.getSlot(), room.getRoomName().contains("Cinema"), slot.getDateRoomID(), movieId != 0 ? movieId : movie.getMovieId())) {
                mess = "Phim chiếu cùng loại phòng không được trùng!";
                checkmovie = true;
            } else {
                movie = movieDB.getMovieById(movieId);
            }
        }
        ArrayList<Integer> listMovieIDExists = timeroomDB.getListMovieExists(slot.getSlot(), slot.getDateRoomID(), room.getRoomName().contains("Cinema"));
        ArrayList<Movie> listMovie = movieDB.getMoviesSlot(dateroom.getDateRoom(), listMovieIDExists);
        try ( PrintWriter out = response.getWriter()) {
            out.print("<div class=\"modal-edit-nofi\" id=\"admin-edit-modal\" >\n"
                    + "                <div class=\"modal-edit-nofi-overlay\"></div>\n"
                    + "                <div class=\"modal-edit modal-dialog-scrollable\">\n"
                    + "                    <form id=\"edit-slotForm\" class=\"full-width\" action=\"editslot\" method=\"post\">\n"
                    + "                        <h5 class=\"modal-add-title\">Sửa lịch chiếu phim</h5>\n"
                    + "                        <div class=\"modal-add-body\">\n"
                    + "                            <div class=\"add-input-option\">\n");
            if (!checkmovie) {
                out.print("                                <input name=\"movieId\" value=\"" + movie.getMovieId() + "\"hidden=\"\" required> \n");
            } else {
                out.print("                                <input name=\"movieId\" value=\"\" hidden=\"\" required> \n");
            }

            out.print("                                <input name=\"roomId\" value=\"" + room.getRoomId() + "\"hidden=\"\" required> \n");
            if (roomId == 0) {
                out.print("                                <input name=\"slot\" value=\"" + slot.getSlot() + "\"hidden=\"\" required> \n"
                        + "                                <input name=\"start\" value=\"" + slot.getStart() + "\"hidden=\"\" required> \n"
                        + "                                <input name=\"finish\" value=\"" + slot.getFinish() + "\"hidden=\"\" required> \n");
            } else {
                if (numberSlot != 0) {
                    out.print("                                <input name=\"slot\" value=\"" + slot.getSlot() + "\"hidden=\"\" required> \n"
                            + "                                <input name=\"start\" value=\"" + slot.getStart() + "\"hidden=\"\" required> \n"
                            + "                                <input name=\"finish\" value=\"" + slot.getFinish() + "\"hidden=\"\" required> \n");
                } else {
                    out.print("                                <input name=\"slot\" value=\"\"hidden=\"\" required> \n"
                            + "                                <input name=\"start\" value=\"\"hidden=\"\" required> \n"
                            + "                                <input name=\"finish\" value=\"\"hidden=\"\" required> \n");
                }
            }
            out.print("                                <input name=\"timeroomId\" value=\"" + timeroomId + "\"hidden=\"\" required> \n"
                    + "\n"
                    + "\n"
                    + "                                <label>Phim chiếu </label>                              \n");
            if (!checkmovie) {
                out.print("                                <input class=\"\" name=\"\" value=\"" + movie.getMovieName() + "\" placeholder=\"\" readonly required=\"\">\n");
            } else {
                out.print("                                <input class=\"\" name=\"\" value=\"\" placeholder=\"\" readonly required=\"\">\n");
            }

            out.print("                                <button type=\"button\" onclick=\"openEditChooseMovie()\" class=\"btn-change-option\">Chọn</button>\n"
                    + "                            </div>\n"
                    + "                            <div class=\"add-input-option\">\n"
                    + "                                <label>Phòng </label>  \n"
                    + "                                <input class=\"\" value=\"" + room.getRoomName() + "\" type=\"\" placeholder=\"\"readonly required=\"\">\n"
                    + "                                <button onclick=\"openEditchooseRoom()\" type=\"button\" class=\"btn-change-option\">Chọn</button>\n"
                    + "                            </div>"
                    + "                                      <div class=\"add-input-option\">\n"
                    + "                                <label>Slot </label>  \n"
                    + "\n");
            SimpleDateFormat time = new SimpleDateFormat("HH:mm a");
            if (roomId == 0) {
                out.print("                                <input class=\"\"  value=\"Slot " + slot.getSlot() + " từ " + time.format(slot.getStart()) + " đến " + time.format(slot.getFinish()) + "\" type=\"\" placeholder=\"\" readonly>\n");
            } else {
                if (numberSlot != 0) {
                    out.print("                                <input class=\"\"  value=\"Slot " + slot.getSlot() + " từ " + time.format(slot.getStart()) + " đến " + time.format(slot.getFinish()) + "\" type=\"\" placeholder=\"\" readonly>\n");
                } else {
                    out.print("                                <input class=\"\"  value=\"\" type=\"\" placeholder=\"\" required=\"\" readonly>\n");
                }
            }
            out.print("                                <button onclick=\"openEditChooseSlot()\" type=\"button\" class=\"btn-change-option\">Chọn</button>\n"
                    + "                            </div>\n");
//            if (mess.trim().length() > 0) {
            out.print("      <div class=\"text-center\">\n"
                    + "          <label id=\"mess-test\" style=\"color: red\">" + mess + " </label>  \n"
                    + "        </div>\n");
//            }
            out.print("                        </div>\n"
                    + "                        <div class=\"modal-btn\">\n"
                    + "                            <button type=\"button\"  onclick=\"checkSubmitForm()\" class=\"custom-btn btn-crud\"><span>Sửa ngay !</span><span>Sửa</span></button>\n"
                    + "                            <button type=\"button\" onclick=\"showDelMess(" + timeroomId + ")\"  class=\"custom-btn btn-crud\"><span>Xóa slot!</span><span>Xóa</span></button>\n"
                    + "                            <button type=\"button\" onclick=\"closeEditModal()\" class=\"custom-btn btn-crud\"><span>Đóng ngay !</span><span>Đóng</span></button>\n"
                    + "                        </div> \n"
                    + "                    </form>\n"
                    + "                </div>\n"
                    + "            </div>");
            out.print("<div class=\"modal-edit-nofi modal-choose\" id=\"modal-edit-choose-movie\">\n"
                    + "                <div class=\"modal-nofi-overlay\"></div>\n"
                    + "                <div class=\"modal-edit-movie modal-dialog-scrollable\">\n"
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
                        + "                                                    <td><a style=\"cursor: pointer\" onclick=\"selectMovie(" + m.getMovieId() + "," + timeroomId + ")\">Chọn</a></td>\n"
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

            out.print("<div class=\"modal-edit-nofi modal-choose\" id=\"modal-edit-choose-room\">\n"
                    + "                <div class=\"modal-nofi-overlay\"></div>\n"
                    + "                <div class=\"modal-edit-small modal-dialog-scrollable\">\n"
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
                        + "                                             <td><a style=\"cursor: pointer\" onclick=\"selectRoom(" + movie.getMovieId() + "," + timeroomId + "," + r.getRoomId() + ")\">Chọn</a></td>\n"
                        + "\n"
                        + "                                        </tr>\n");
            }
            out.print("\n"
                    + "                                    </tbody>\n"
                    + "                                </table>\n"
                    + "                            </div>\n"
                    + "                        </div>\n"
                    + "                        <div class=\"modal-btn\">\n"
                    + "                            <button type=\"button\" onclick=\"closeModalChoose()\" class=\"custom-btn btn-crud\"><span>Close !</span><span>Close</span></button>\n"
                    + "                        </div> \n"
                    + "                    </form>\n"
                    + "                </div>\n"
                    + "            </div>");

            out.print("<div class=\"modal-edit-nofi modal-choose\" id=\"modal-edit-choose-slot\">\n"
                    + "                <div class=\"modal-nofi-overlay\"></div>\n"
                    + "                <div class=\"modal-edit-medium modal-dialog-scrollable\">\n"
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
                    + "                                    <tbody>\n"
                    + "\n");
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
                                + "<td><input onchange=\"valueSubmit(" + timeroomId + "," + count + "," + i + "," + room.getRoomId() + "," + movie.getMovieId() + ")\" style=\"margin-top: 5px;\" type=\"time\" id=\"start\"  required></td>\n"
                                + " <td><input onchange=\"valueSubmit(" + timeroomId + "," + count + "," + i + "," + room.getRoomId() + "," + movie.getMovieId() + ")\" style=\"margin-top: 5px;\" type=\"time\" id=\"finish\" required></td>\n"
                                + " <td><button id=\"submit-time\" class=\"btn-movie \" ><a>Chọn</a></button></td>"
                                + " </tr>\n");
                        count++;
                    }
                }
            }

            out.print("\n"
                    + "                                    </tbody>\n"
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        int timeroomId = request.getParameter("timeroomId") != null ? Integer.parseInt(request.getParameter("timeroomId")) : 0;
        int movieId = request.getParameter("movieId") != null ? Integer.parseInt(request.getParameter("movieId")) : 0;
        int numberSlot = request.getParameter("slot") != null ? Integer.parseInt(request.getParameter("slot")) : 0;
        int roomId = request.getParameter("roomId") != null ? Integer.parseInt(request.getParameter("roomId")) : 0;
        Time start = request.getParameter("start") != null ? Time.valueOf(request.getParameter("start")) : null;
        Time finish = request.getParameter("finish") != null ? Time.valueOf(request.getParameter("finish")) : null;

        TimeRoomDAO timeroomDB = new TimeRoomDAO();
        MovieTimeDAO movietimeDB = new MovieTimeDAO();
        MovieDAO movieDB = new MovieDAO();
        RoomDAO roomDB = new RoomDAO();
        DateRoomDAO dateroomDB = new DateRoomDAO();

        TimeRoom timeroom = timeroomDB.getTimeRoomById(timeroomId); //lấy các thông tin của slot cũ
        MovieTime slotOld = movietimeDB.getSlotByMovieTimeId(timeroom.getMovieTimeId());// slot cũ
        Movie movie = movieDB.getMovieById(movieId != 0 ? movieId : timeroom.getMovieId());
        Room room = roomDB.getRoomsByID(roomId != 0 ? roomId : timeroom.getRoomId());
        MovieTime slotNew = new MovieTime();
        slotNew.setDateRoomID(slotOld.getDateRoomID());
        slotNew.setStart(start);
        slotNew.setFinish(finish);
        slotNew.setSlot(numberSlot);
        slotNew.setMovieTimeId(slotOld.getMovieTimeId());
        DateRoom dateroom = dateroomDB.getDateRoomByDateroomId(slotOld.getDateRoomID());

        if (movietimeDB.checkCountDateRoom(timeroom.getMovieTimeId()) > 1) { //nếu movietime cũ có cái khác dùng chung 
            MovieTime mtExists = movietimeDB.CheckMovieTimeExists(slotNew);
            if (mtExists != null) { // nếu thời gian mới trùng với tgian nào đó thì lấy dùng luôn không cần thêm mới
                TimeRoom timeroomNew = new TimeRoom();
                timeroomNew.setMovieId(movieId);
                timeroomNew.setRoomId(roomId);
                timeroomNew.setMovieTimeId(mtExists.getMovieTimeId());
                timeroomNew.setTimeRoomId(timeroomId);
                if (timeroomDB.updateTimeRoom(timeroomNew) != 0) {
                    request.setAttribute("messAdd", "Cập nhật thành công");
                    request.getRequestDispatcher("setupschedule?date=" + dateroom.getDateRoom().toString()).forward(request, response);
                } else {
                    request.setAttribute("messError", "Cập nhật thất bại");
                    request.getRequestDispatcher("setupschedule?date=" + dateroom.getDateRoom().toString()).forward(request, response);
                }
            } else { // còn nếu ko có thì thêm mới slot 
                mtExists = movietimeDB.addSlot(slotNew); // thêm và trả về movietime vừa thêm
                TimeRoom timeroomNew = new TimeRoom();
                timeroomNew.setMovieId(movieId);
                timeroomNew.setRoomId(roomId);
                timeroomNew.setMovieTimeId(mtExists.getMovieTimeId());
                timeroomNew.setTimeRoomId(timeroomId);
                if (timeroomDB.updateTimeRoom(timeroomNew) != 0) {
                    request.setAttribute("messAdd", "Cập nhật thành công");
                    request.getRequestDispatcher("setupschedule?date=" + dateroom.getDateRoom().toString()).forward(request, response);
                } else {
                    request.setAttribute("messError", "Cập nhật thất bại");
                    request.getRequestDispatcher("setupschedule?date=" + dateroom.getDateRoom().toString()).forward(request, response);
                }
            }
        } else { // nếu ko có timeroom khác dùng movietime chung thì update cái cũ
            if (movietimeDB.updateMovieTime(slotNew) > 0) { //nếu update movietime cũ thành công
                TimeRoom timeroomNew = new TimeRoom();
                timeroomNew.setMovieId(movieId);
                timeroomNew.setRoomId(roomId);
                timeroomNew.setMovieTimeId(slotOld.getMovieTimeId());
                timeroomNew.setTimeRoomId(timeroomId);
                if (timeroomDB.updateTimeRoom(timeroomNew) != 0) {
                    request.setAttribute("messAdd", "Cập nhật thành công");
                    request.getRequestDispatcher("setupschedule?date=" + dateroom.getDateRoom().toString()).forward(request, response);
                } else {
                    request.setAttribute("messError", "Cập nhật thất bại");
                    request.getRequestDispatcher("setupschedule?date=" + dateroom.getDateRoom().toString()).forward(request, response);
                }
            } else { // update movietime cũ ko thành
                request.setAttribute("messError", "Cập nhật thất bại");
                request.getRequestDispatcher("setupschedule?date=" + dateroom.getDateRoom().toString()).forward(request, response);
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
