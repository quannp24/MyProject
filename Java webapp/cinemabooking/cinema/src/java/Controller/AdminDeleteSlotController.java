/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.DateRoomDAO;
import DAL.MovieTimeDAO;
import DAL.TimeRoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DateRoom;
import model.MovieTime;
import model.TimeRoom;

/**
 *
 * @author Quan
 */
public class AdminDeleteSlotController extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        int timeroomId = request.getParameter("timeroomId") != null ? Integer.parseInt(request.getParameter("timeroomId")) : 0;
        if (timeroomId != 0) {
            TimeRoomDAO timeroomDB = new TimeRoomDAO();
            MovieTimeDAO movietimeDB = new MovieTimeDAO();
            DateRoomDAO dateroomDB = new DateRoomDAO();

            TimeRoom timeroom = timeroomDB.getTimeRoomById(timeroomId);
            MovieTime slot = movietimeDB.getSlotByMovieTimeId(timeroom.getMovieTimeId());
            DateRoom dateroom = dateroomDB.getDateRoomByDateroomId(slot.getDateRoomID());
            if (movietimeDB.checkCountDateRoom(timeroom.getMovieTimeId()) > 1) { // nếu movietime của slot muốn xóa có cái khác dùng chung thì chỉ cần xóa timeroom
                if (timeroomDB.deleteTimeRoom(timeroomId) != 0) { // xoa thanh cong
                    request.setAttribute("messAdd", "Xóa thành công");
                    request.getRequestDispatcher("setupschedule?date=" + dateroom.getDateRoom().toString()).forward(request, response);
                } else { //xoa that bai
                    request.setAttribute("messError", "Xóa thất bại!");
                    request.getRequestDispatcher("setupschedule?date=" + dateroom.getDateRoom().toString()).forward(request, response);
                }
            } else { //không có cái nào dùng chung thì xóa thêm movietime
                if (dateroomDB.CheckDateRoomDuplicate(slot.getDateRoomID()) > 1) { // nếu dateroom dùng cho movietime khác nữa, thì chỉ xóa movietime và timeroom
                    if (timeroomDB.deleteTimeRoom(timeroomId) != 0) { // xoa thanh cong timeroom
                        if (movietimeDB.deleteMovieTime(timeroom.getMovieTimeId()) != 0) { //xoa thanh cong movietime
                            request.setAttribute("messAdd", "Xóa thành công");
                            request.getRequestDispatcher("setupschedule?date=" + dateroom.getDateRoom().toString()).forward(request, response);
                        } else {
                            request.setAttribute("messError", "Xóa thất bại!");
                            request.getRequestDispatcher("setupschedule?date=" + dateroom.getDateRoom().toString()).forward(request, response);
                        }
                    } else {
                        request.setAttribute("messError", "Xóa thất bại!");
                        request.getRequestDispatcher("setupschedule?date=" + dateroom.getDateRoom().toString()).forward(request, response);
                    }
                } else { // nếu dateroom chỉ dùng cho movietime muốn xóa, xóa luôn cả dateroom
                    if (timeroomDB.deleteTimeRoom(timeroomId) != 0) { // xoa thanh cong timeroom
                        if (movietimeDB.deleteMovieTime(timeroom.getMovieTimeId()) != 0) { //xoa thanh cong movietime
                            if (dateroomDB.deleteDateRoom(slot.getDateRoomID()) != 0) { // xoa thanh cong dateroom
                                request.setAttribute("messAdd", "Xóa thành công");
                                request.getRequestDispatcher("setupschedule?date=" + dateroom.getDateRoom().toString()).forward(request, response);
                            } else { // xoa that bai dateroom
                                request.setAttribute("messError", "Xóa thất bại!");
                                request.getRequestDispatcher("setupschedule?date=" + dateroom.getDateRoom().toString()).forward(request, response);
                            }
                        } else {  //xoa that bai movietime
                            request.setAttribute("messError", "Xóa thất bại!");
                            request.getRequestDispatcher("setupschedule?date=" + dateroom.getDateRoom().toString()).forward(request, response);
                        }
                    } else {  //xoa that bai timeroom
                        request.setAttribute("messError", "Xóa thất bại!");
                        request.getRequestDispatcher("setupschedule?date=" + dateroom.getDateRoom().toString()).forward(request, response);
                    }
                }
            }
        } else {
            response.sendRedirect("setupschedule");
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
        processRequest(request, response);
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
