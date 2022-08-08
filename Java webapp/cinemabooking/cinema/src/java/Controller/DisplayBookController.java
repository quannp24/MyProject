/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.TimeRoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.TimeRoom;

/**
 *
 * @author Quan
 */
public class DisplayBookController extends HttpServlet {

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
        Date curdate = request.getParameter("date") != null ? Date.valueOf(request.getParameter("date")) : null;

        TimeRoomDAO timeroomDB = new TimeRoomDAO();

        ArrayList<TimeRoom> listSlot = timeroomDB.getTimeRoomByStatus(curdate);
        if (listSlot.size() > 0) {
            int ru = timeroomDB.updateStatusTimeRoom(listSlot);
            if (ru != 0) {
                request.setAttribute("messAdd", "Đã hiển thị " + listSlot.size() + " suất chiếu trên hệ thống đặt vé");
                request.getRequestDispatcher("setupschedule?date=" + curdate).forward(request, response);
            } else {
                request.setAttribute("mess", "Quá trình xử lý đã bị lỗi đâu đó.");
                request.getRequestDispatcher("setupschedule?date=" + curdate).forward(request, response);
            }
        } else {
            request.setAttribute("mess", "Bạn không có suất chiếu nào chưa hiển thị.");
            request.getRequestDispatcher("setupschedule?date=" + curdate).forward(request, response);
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
