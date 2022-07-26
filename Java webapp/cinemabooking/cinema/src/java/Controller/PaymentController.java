/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Config.Config;
import DAL.CartDAO;
import DAL.SeatRoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.FastFoodCart;
import model.SeatRoom;

/**
 *
 * @author Quan
 */
public class PaymentController extends HttpServlet {

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
        int timeroomId = Integer.parseInt(request.getParameter("timeroomId"));
        double fee = Double.parseDouble(request.getParameter("total"));
        double convert = fee * 1000;
        String[] quantity = request.getParameterValues("quantity");
        String[] foodId = request.getParameterValues("foodId");
        String[] seatId = request.getParameter("listseatId") != null ? request.getParameter("listseatId").split(",") : null;
        ArrayList<FastFoodCart> listFood = new ArrayList<>();
        for (int i = 0; i < quantity.length; i++) { //lọc kết quả của dsach food
            if (Integer.parseInt(quantity[i]) != 0) {
                FastFoodCart fd = new FastFoodCart();
                fd.setFastfoodId(Integer.parseInt(foodId[i]));
                fd.setQuantity(Integer.parseInt(quantity[i]));
                listFood.add(fd);
            }
        }
        SeatRoomDAO seatroomDB = new SeatRoomDAO();
        CartDAO cartDB = new CartDAO();
        ArrayList<SeatRoom> listSeat = seatroomDB.getSeatRoomsByAll(timeroomId, seatId, 0); //lấy dsach seatroomId
        request.getSession().setAttribute("listSeat", listSeat);
        request.getSession().setAttribute("listFood", listFood);
        request.getSession().setAttribute("total", convert);
        request.getSession().setAttribute("cartId", cartDB.getCartID()+1);
        
        int id = cartDB.getCartID()+1;
//        double convert = fee * 1000;
        String vnp_Version = "2.0.1";  //phiên bản api sử dụng để thanh toán
        String vnp_Command = "pay";     //mã cho giao dịch thanh toán là pay
        String vnp_OrderInfo = null;
        vnp_OrderInfo = "Thanh toan : " + id;      // nội dung thanh toán
        int amount = (int) Math.round(convert) * 100;
        String orderType = "billpayment";  //mã danh mục hàng hóa
        String vnp_TxnRef = id + "";  //mã tham chiếu của giao dịch hệ thống vn pay
        String vnp_IpAddr = Config.getIpAddress(request);        //lấy ra địa chỉ Ip của tài khoản trên website
        String vnp_TmnCode = Config.vnp_TmnCode;           //lấy ra mã code của website trên vnpay
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND"); // đơn vị tiền tệ sử dụng để thanh toán
        vnp_Params.put("vnp_BankCode", "");
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
        vnp_Params.put("vnp_OrderType", orderType);
        vnp_Params.put("vnp_Locale", "vn"); // ngôn ngữ giao diện hiển thị
        vnp_Params.put("vnp_ReturnUrl", Config.vnp_Returnurl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Date dt = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String dateString = formatter.format(dt);
        String vnp_CreateDate = dateString;
        String vnp_TransDate = vnp_CreateDate;
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        //Build data to hash and querystring
        List fieldNames = new ArrayList(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                //Build hash data
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(fieldValue);
                //Build query
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnp_SecureHash = Config.Sha256(Config.vnp_HashSecret + hashData.toString());
        queryUrl += "&vnp_SecureHashType=SHA256&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
        response.sendRedirect(paymentUrl);
        return;
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
