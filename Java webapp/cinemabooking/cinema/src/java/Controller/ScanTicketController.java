/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.CartDAO;
import DAL.DateRoomDAO;
import DAL.FastFoodCartDAO;
import DAL.MovieDAO;
import DAL.MovieTimeDAO;
import DAL.RoomDAO;
import DAL.SeatDAO;
import DAL.TimeRoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Account;
import model.Cart;
import model.FastFoodCart;
import model.FoodAndDrink;
import model.Movie;
import model.MovieTime;
import model.Room;
import model.Seat;
import model.TimeRoom;

/**
 *
 * @author Quan
 */
public class ScanTicketController extends HttpServlet {

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
        HttpSession session = request.getSession();
        String id = request.getParameter("cartId");
        int cId = Integer.parseInt(id);
        Account acc = (Account) request.getSession().getAttribute("account");
        CartDAO cartDB = new CartDAO();
        TimeRoomDAO timeroomDB = new TimeRoomDAO();
        RoomDAO roomDB = new RoomDAO();
        MovieDAO movieDB = new MovieDAO();
        DateRoomDAO dateDB = new DateRoomDAO();
        MovieTimeDAO movietimeDB = new MovieTimeDAO();
        SeatDAO seatDB = new SeatDAO();
        FastFoodCartDAO fdDB = new FastFoodCartDAO();
        try {
             Cart order = cartDB.getOrderByCartId(cId);
            ArrayList<Integer> cartIdExpired = cartDB.getCartExpired(order.getAccountId());  // lấy dsach mã hóa đơn đã hết hạn
            if (cartIdExpired.size() > 0) {
                for (Integer e : cartIdExpired) {
                    if (cId == e) {// update status=0 theo e
                        cartDB.updateStatusByCartId(cId);
                        break;
                    }
                }
            }

            TimeRoom timeroom = timeroomDB.getTimeRoomByCartId(cId, order.getAccountId());
            Room room = roomDB.getRoomsByID(timeroom.getRoomId());
            Movie movie = movieDB.getMovieById(timeroom.getMovieId());
            MovieTime slot = movietimeDB.getSlotByMovieTimeId(timeroom.getMovieTimeId());
            Date date = dateDB.getDateRoomByDateroomId(slot.getDateRoomID()).getDateRoom();
            ArrayList<Seat> seatlist = seatDB.getSeatByCartId(cId, order.getAccountId());
            ArrayList<FastFoodCart> listFood = fdDB.getFoodByCartId(cId, order.getAccountId());
            ArrayList<FoodAndDrink> listFD = new ArrayList<>();
            for (FastFoodCart f : listFood) {
                listFD.add(fdDB.getFoodByFastFoodId(f.getFastfoodId()));
            }

            request.setAttribute("order", order);
            request.setAttribute("room", room);
            request.setAttribute("slot", slot);
            request.setAttribute("listFood", listFood);
            request.setAttribute("listFD", listFD);
            request.setAttribute("listSeat", seatlist);
            request.setAttribute("date", date);
            request.setAttribute("movie", movie);

            request.getRequestDispatcher("view/ScanTicket.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect("home");
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
