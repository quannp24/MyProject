/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.RoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Room;

/**
 *
 * @author Quan
 */
@WebServlet(name = "ManagementRoom", urlPatterns = {"/managementroom"})
public class ManagementRoom extends HttpServlet {

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
            out.println("<title>Servlet ManagementRoom</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagementRoom at " + request.getContextPath() + "</h1>");
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
        RoomDAO rdao = new RoomDAO();
        ArrayList<Room> rooms = rdao.getRooms();
        request.setAttribute("rooms", rooms);
        request.getRequestDispatcher("view/ManagementRoom.jsp").forward(request, response);
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
        RoomDAO rdao = new RoomDAO();
        ArrayList<Room> rooms = rdao.getRooms();
        String roomName = request.getParameter("roomName");

        for (Room r : rooms) {
            if (!r.getRoomName().trim().toLowerCase().equals(roomName)) {
                request.setAttribute("error", "Tên phòng đã tồn tại!");
                request.setAttribute("rooms", rooms);
                request.getRequestDispatcher("view/ManagementRoom.jsp").forward(request, response);
                return;
            } else {
                request.setAttribute("mess", "Đã thêm thành công phòng mới!");
                request.setAttribute("rooms", rooms);
                rdao.insertRoom(roomName);
                request.getRequestDispatcher("view/ManagementRoom.jsp").forward(request, response);
                return;
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
