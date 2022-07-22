/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.CartDAO;
import DAL.FastFoodCartDAO;
import DAL.SeatRoomCartDAO;
import DAL.SeatRoomDAO;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.Cart;
import model.FastFoodCart;
import model.SeatRoom;

/**
 *
 * @author Quan
 */
public class PaymentVerification extends HttpServlet {

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
            throws ServletException, IOException, WriterException {
        response.setContentType("text/html;charset=UTF-8");
        String vnp_TxnRef = request.getParameter("vnp_TxnRef");
        String vnp_BankTranNo = request.getParameter("vnp_BankTranNo");
        String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
         ArrayList<SeatRoom> listSeat = (ArrayList<SeatRoom>) request.getSession().getAttribute("listSeat");
        SeatRoomDAO seatroomDB = new SeatRoomDAO();
        try {
            if (vnp_TxnRef != null && Integer.parseInt(vnp_TxnRef) > 0
                    && vnp_BankTranNo != null && vnp_ResponseCode != null && vnp_ResponseCode.equals("00")
                    && vnp_TransactionNo != null && Integer.parseInt(vnp_TransactionNo) > 0) {  // giao dich thanh cong
                String path = this.getClass().getClassLoader().getResource("").getPath();
                int id=(Integer)request.getSession().getAttribute("cartId");
                String fullPath = URLDecoder.decode(path, "UTF-8");
                String pathArr[] = fullPath.split("/build");
                String img = "image/QRcode/" + id + ".png";
                String convertQR = "http://localhost:9999/CinemaBookingSystem/scanticket?cartId=" + id;  //link sau khi quet ma
                CartDAO cartDB = new CartDAO();
                SeatRoomCartDAO srCartDB = new SeatRoomCartDAO();
                FastFoodCartDAO fdcartDB = new FastFoodCartDAO();

                Account acc = (Account) request.getSession().getAttribute("account");
                double total = (Double) request.getSession().getAttribute("total");
                ArrayList<FastFoodCart> listFood = (ArrayList<FastFoodCart>) request.getSession().getAttribute("listFood");
                if (acc != null) {
                    int cartId = cartDB.AddCart(acc.getAccId(), total / 1000, img); // add va tra ve cartid vua add
                    if (cartId != 0) { //add cart thanh cong
                        try {
                            generateQR(convertQR, pathArr[0] + "/web/" + img);// chuyen link thanh QRcode va luu vao file
                            srCartDB.AddSeatRoomCart(cartId, listSeat);//add seat vao seatroomcart
                            fdcartDB.AddFastFoodCart(cartId, listFood);//add food vao fastfoodcart
                            seatroomDB.updateStatus(listSeat);
                        } catch (Exception e) {
                            Logger.getLogger(PaymentVerification.class.getName()).log(Level.SEVERE, null, e);
                        }
                        request.getRequestDispatcher("view/paymentsuccess.jsp").forward(request, response);
                        return;
                    } else { // neu add cart that bai
                        seatroomDB.deleteSeatRoomByID(listSeat);
                        request.getRequestDispatcher("view/paymentfailed.jsp").forward(request, response);
                    }

                }
            }
            seatroomDB.deleteSeatRoomByID(listSeat);
            response.sendRedirect(request.getContextPath() + "/paymentfailed.jsp");
        } catch (IOException e) {
            System.out.println(e);
        }
    }

    public static void generateQR(String text, String pathfile) throws WriterException, IOException {
        QRCodeWriter writer = new QRCodeWriter();
        BitMatrix bitMatrix = writer.encode(text, BarcodeFormat.QR_CODE, 300, 300);
        MatrixToImageWriter.writeToPath(bitMatrix, "PNG", new File(pathfile));
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
        try {
            processRequest(request, response);
        } catch (WriterException ex) {
            Logger.getLogger(PaymentVerification.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            processRequest(request, response);
        } catch (WriterException ex) {
            Logger.getLogger(PaymentVerification.class.getName()).log(Level.SEVERE, null, ex);
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
