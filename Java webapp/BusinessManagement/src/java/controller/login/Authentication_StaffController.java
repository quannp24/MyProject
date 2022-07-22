/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.login;

import dal.AccountDBContext;
import dal.accountStaffDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.AccountStaff;

/**
 *
 * @author Quan
 */
public class Authentication_StaffController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

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
        request.getRequestDispatcher("/view/LoginStaff.jsp").forward(request, response);
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
        request.getSession().invalidate();
        Cookie c_userd = new Cookie("username", "");
        Cookie c_passd = new Cookie("password", "");
        Cookie c_bida = new Cookie("bid", "");
        c_userd.setMaxAge(0);
        c_passd.setMaxAge(0);
        c_bida.setMaxAge(0);
        response.addCookie(c_userd);
        response.addCookie(c_passd);
        response.addCookie(c_bida);
        
        String username = request.getParameter("username");
        String password = request.getParameter("pass");
        String bid = request.getParameter("bid").trim();

        accountStaffDBContext db = new accountStaffDBContext();
        AccountStaff account = db.getAccountStaff(username, password, bid);
        if (account != null) {
            request.getSession().setAttribute("accountStaff", account);
            String remember = request.getParameter("remember");
            if (remember != null) {
                Cookie c_user = new Cookie("username", username);
                Cookie c_pass = new Cookie("password", password);
                Cookie c_bid = new Cookie("bid", bid);
                c_user.setMaxAge(24 * 3600 * 7);
                c_pass.setMaxAge(24 * 3600 * 7);
                c_bid.setMaxAge(24 * 3600 * 7);
                response.addCookie(c_user);
                response.addCookie(c_pass);
                response.addCookie(c_bid);
            }
            response.sendRedirect("manage");  //sau chỉnh lại
        } else {
            String mess = "Thông tin đăng nhập sai, hãy đăng nhập lại!";
            request.setAttribute("mess", mess);
            request.getRequestDispatcher("/view/LoginStaff.jsp").forward(request, response);
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
