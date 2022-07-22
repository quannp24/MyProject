/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.FoodAndDrinkDAO;
import DAL.SeatDAO;
import DAL.SeatRoomDAO;
import DAL.TimeRoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Locale;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.FastFoodCart;
import model.FoodAndDrink;
import model.Seat;
import model.SeatRoom;
import model.TimeRoom;

/**
 *
 * @author Quan
 */
public class BookFoodController extends HttpServlet {

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
//            out.println("<title>Servlet BookFoodController</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet BookFoodController at " + request.getContextPath() + "</h1>");
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
        int timeroomId = request.getParameter("timeroomId") != null ? Integer.parseInt(request.getParameter("timeroomId")) : 0;
        String[] seatId = request.getParameter("listSeat") != null ? request.getParameter("listSeat").split(",") : null;
        request.getSession().setAttribute("listSeat", seatId);
        FoodAndDrinkDAO fdDB = new FoodAndDrinkDAO();
        SeatRoomDAO setroomDB = new SeatRoomDAO();
        if (!setroomDB.checkSeatRoomExits(timeroomId, seatId)) {  // check ghế đã book có ai đặt chưa
            setroomDB.addSeatTemporary(timeroomId, seatId);// chưa thì add tạm thời vào database với status=0 để khóa ko cho ai đặt
            ArrayList<FoodAndDrink> listFood = fdDB.listFAD();
            try ( PrintWriter out = response.getWriter()) {
                out.print(" <ul id=\"bookfood\" class=\"food progress\">\n"
                        + "                                    <li class=\"booking-step\" style=\"position: absolute;top:0px;\n"
                        + "                                        left: 0px;z-index: 100;opacity: 1;display: block;\n"
                        + "                                        visibility: visible\">               \n"
                        + "                                        <label class=\"h2\"> Combo </label>\n"
                        + "\n"
                        + "                                        <ol class=\"products-list\">\n"
                        + "                                            <!--list food and drink-->\n");
                for (int i = 0; i < listFood.size(); i++) {

                    out.print("                                             <li class=\"item first\">\n"
                            + "                                                    <img src=\"" + listFood.get(i).getImage() + "\" class=\"combo-image\" >\n"
                            + "                                                    <div class=\"product-shop\">\n"
                            + "                                                        <div class=\"f-fix\">\n"
                            + "                                                            <div class=\"product-primary\">\n"
                            + "                                                                <h4 style=\"font-weight: bold; text-transform:uppercase\"> " + listFood.get(i).getCategory() + " </h4>\n"
                            + "                                                            </div>\n"
                            + "                                                            <div class=\"desc std\">\n"
                            + "                                                               " + listFood.get(i).getFadName() + "\n"
                            + "                                                            </div>\n"
                            + "                                                            <div class=\"desc\">\n"
                            + "                                                                <div class=\"price-box\">\n"
                            + "                                                                    <span class=\"label\">Giá: </span>\n");
                    Locale localeVN = new Locale("vi", "VN");
                    NumberFormat currencyVN = NumberFormat.getCurrencyInstance(localeVN);
                    String str1 = currencyVN.format(listFood.get(i).getPrice() * 1000);
                    out.print("                                                                    <span class=\"price\">" + str1 + "</span>\n"
                            + "                                                                </div>\n"
                            + "                                                                <div class=\"product-choose\"> \n"
                            + "                                                                    <span onclick=\"minusQuantity(" + i + ")\" class=\"input-group-btn\">\n"
                            + "                                                                        <a id=\"btn-subtract\" onclick=\"\" class=\"btn\" data-type=\"minus\">\n"
                            + "                                                                            <i class=\"fas fa-minus \"></i>\n"
                            + "                                                                        </a>\n"
                            + "                                                                    </span>\n"
                            + "                                                                    <input type=\"text\" name=\"quantity\" class=\"form-control no-padding text-center item-quantity\" value=\"0\">\n"
                            + "                                                                     <input type=\"text\" name=\"foodId\" value=\"" + listFood.get(i).getFadId() + "\" hidden>\n"
                            + "                                                                     <input value =\"" + listFood.get(i).getPrice() + "\" hidden>\n"
                            + "                                                                    <span id=\"btn-add\" onclick=\"addQuantity(" + i + ")\" class=\"input-group-btn\">\n"
                            + "                                                                        <a  class=\"btn \"  data-type=\"minus\">\n"
                            + "                                                                            <i class=\"fas fa-plus \"></i>\n"
                            + "                                                                        </a>\n"
                            + "                                                                    </span>\n"
                            + "                                                                </div>\n"
                            + "                                                            </div>\n"
                            + "                                                        </div>\n"
                            + "                                                    </div>\n"
                            + "                                                </li>\n"
                    );
                }
                out.print("                                        </ol>\n"
                        + "                                    </li>\n"
                        + "                                </ul>");

            }
        } else {  // trùng ghế ai đó đã đặt thì return lỗi

            response.sendError(404, "mess");
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
        int timeroomId = request.getParameter("timeroomId") != null ? Integer.parseInt(request.getParameter("timeroomId")) : 0;
        String[] listSeatSession = (String[]) request.getSession().getAttribute("listSeat");
        TimeRoomDAO timeroomDB = new TimeRoomDAO();
        SeatDAO seatDB = new SeatDAO();
        SeatRoomDAO seatroomDB = new SeatRoomDAO();
        
        if (seatroomDB.checkSeatRoomExits(timeroomId, listSeatSession)) { 
            seatroomDB.deleteSeatRoom(timeroomId, listSeatSession);
        }
        ArrayList<Seat> listSeat = seatDB.getSeats(); //lấy tất cả ghế
        ArrayList<String> listCharSeat = seatDB.getCharSeats(); //lấy chữ cái của hàng ghế
        TimeRoom timeroom = timeroomDB.getTimeRoomById(timeroomId); // lấy timeroom dựa vào thông tin đã book
        ArrayList<SeatRoom> listSeatChecked = seatroomDB.getSeatRoomsByTimeRoomId(timeroom.getTimeRoomId()); //lấy tất cả ghế đã được đặt
        try ( PrintWriter out = response.getWriter()) {
            out.print("<ul id=\"bookghe\" class=\"progress\">\n"
                    + "                                    <li class=\"booking-step\" >              \n"
                    + "                                        <label class=\"h2\" style=\"font-family: 'Merriweather Sans', sans-serif;font-weight: bold\">Người / Ghế</label>\n"
                    + "                                        <div class=\"ticketbox\">\n"
                    + "                                            <div class=\"screen\">\n"
                    + "                                                <span class=\"text-screen\">Phòng chiếu</span>\n"
                    + "                                            </div>\n"
                    + "                                            <table class=\"seat-matrix\"  >\n");
            int location = 0;
            for (int i = 0; i < listCharSeat.size(); i++) {
                out.print("                                                <tr  >\n");
                for (int j = location; j < listSeat.size(); j++) {
                    if (listCharSeat.get(i).equals(listSeat.get(j).getSeatRow())) {
                        out.print("                                                    <td >\n");
                        boolean check = false;
                        for (SeatRoom c : listSeatChecked) {
                            if (c.getSeatId() == listSeat.get(j).getSeatId()) {
                                out.print("                                                        <span style=\"background: #D00202\">" + listSeat.get(j).getSeatRow() + "" + listSeat.get(j).getSeatNumber() + "</span>\n");
                                check = true;
                            }
                        }
                        if (!check) {
                            out.print("                                                        <input onchange=\"addPrice()\" type=\"checkbox\" name=\"seatId\" value=\"" + listSeat.get(j).getSeatId() + "\"");
                            for (String session : listSeatSession) {
                                if (Integer.parseInt(session) == (listSeat.get(j).getSeatId())) {
                                    out.print(" checked ");
                                    break;
                                }
                            }
                            out.print(">\n"
                                    + "                                                        <input hidden onchange=\"addPrice()\" id=\"seatPrice\" value=\"" + listSeat.get(j).getSeatPrice() + "\">\n"
                                    + "                                                        <span>" + listSeat.get(j).getSeatRow() + "" + listSeat.get(j).getSeatNumber() + "</span>\n");
                        }
                        location++;
                        out.print("                                                    </td>\n");
                    } else {
                        break;
                    }
                }
                out.print("                                                </tr>\n");
            }

            out.print("                                            </table>\n"
                    + "                                            <div class=\"ticketbox-notice\" style=\"margin: 3rem 15rem;\">\n"
                    + "                                                <div class=\"iconlist\">\n"
                    + "                                                    <div class=\"icon checked\" style=\"display: flex;\" >\n"
                    + "                                                        <div style=\"background-color: rgba(245, 193, 39, 0.82);width: 20px;height: 20px; margin: 0 10px\"></div> Ghế trống\n"
                    + "                                                    </div>\n"
                    + "                                                    <div class=\"icon checked\" style=\"display: flex;\" >\n"
                    + "                                                        <div style=\"background-color: black;width: 20px;height: 20px; margin: 0 10px\"></div> Ghế bạn chọn\n"
                    + "                                                    </div>\n"
                    + "                                                    <div class=\"icon checked\" style=\"display: flex;\" >\n"
                    + "                                                        <div style=\"background-color: #D00202;width: 20px;height: 20px; margin: 0 10px\"></div> Ghế đã chọn\n"
                    + "                                                    </div>\n"
                    + "                                                </div>\n"
                    + "                                            </div>\n"
                    + "                                        </div>\n"
                    + "                                    </li>\n"
                    + "                                </ul>");
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
