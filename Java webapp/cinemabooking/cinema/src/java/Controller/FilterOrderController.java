/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Account;
import model.Cart;

/**
 *
 * @author Quan
 */
public class FilterOrderController extends HttpServlet {

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
        HttpSession session = request.getSession();
        ArrayList<Cart> orderList = new ArrayList<>();
        int total = 0;
        try {

            String sta = request.getParameter("status");
            int status = Integer.parseInt(sta);
            CartDAO db = new CartDAO();
            Account acc = (Account) session.getAttribute("account");
            String index = request.getParameter("pageIndex");
            if (index == null) {
                index = "1";
            }
            int accId = acc.getAccId();
            int pageIndex = Integer.parseInt(index);

             total = db.getTotalOrderByStatus(accId,status);

            int endPage = (int) Math.ceil((double) total / 3);
            orderList = db.getCartByStatus(status, accId, pageIndex);
            session.setAttribute("order", orderList);
            request.setAttribute("total1", total);
            request.setAttribute("endPage1", endPage);
            request.setAttribute("pageIndex1", pageIndex);
            request.setAttribute("status", status);
        } catch (Exception e) {
            Logger.getLogger(FilterOrderController.class.getName()).log(Level.SEVERE, null, e);
        }
        request.getRequestDispatcher("view/MyOrder.jsp").forward(request, response);
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
