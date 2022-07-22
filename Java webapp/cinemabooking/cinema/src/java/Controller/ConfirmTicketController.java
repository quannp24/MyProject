/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.Cart;

/**
 *
 * @author Quan
 */
public class ConfirmTicketController extends HttpServlet {

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
        int cartId = request.getParameter("cartId") != null ? Integer.parseInt(request.getParameter("cartId")) : 0;
        try {
            Account acc = (Account) request.getSession().getAttribute("account");
            CartDAO cartDB = new CartDAO();
            Cart cart = cartDB.getCartById(cartId, acc.getAccId());

            if (cart != null && Integer.parseInt(acc.getRole()) != 3) {

                if (cartDB.updateStatusByCartId(cartId) != 0) {
                    request.setAttribute("mess", "Xác nhận thành công.");
                    request.getRequestDispatcher("scanticket?cartId=" + cartId).forward(request, response);
                } else {
                    request.setAttribute("mess", "Xác nhận thất bại.");
                    request.getRequestDispatcher("scanticket?cartId=" + cartId).forward(request, response);
                }
            }

        } catch (Exception e) {
            request.setAttribute("mess", "Xác nhận thất bại.");
            request.getRequestDispatcher("scanticket?cartId=" + cartId).forward(request, response);
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
