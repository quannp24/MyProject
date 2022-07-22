/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AccountDAO;
import javax.servlet.http.Cookie;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;

/**
 *
 * @author MSI
 */
public class LoginController extends HttpServlet {

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
//            
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            AccountDAO adao = new AccountDAO();
            Account a = adao.getAccountById(id);
            request.setAttribute("account", a);
            request.getRequestDispatcher("view/Login.jsp").forward(request, response);
        } catch (Exception e) {
        request.getRequestDispatcher("view/Login.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        //logout khi login vào acc khác
        request.getSession().invalidate();
        //login
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        AccountDAO db = new AccountDAO();
        Account account = db.getAccount(email, pass);
        if (account != null) {
            request.getSession().setAttribute("account", account);
            String remember = request.getParameter("remember");
            if (remember != null) {
                Cookie c_email = new Cookie("email", email);
                Cookie c_pass = new Cookie("password", pass);
                c_email.setMaxAge(24 * 3600 * 7);
                c_pass.setMaxAge(24 * 3600 * 7);
                response.addCookie(c_email);
                response.addCookie(c_pass);
            }

            response.sendRedirect("home");  //sau chỉnh dispatcher 
        } else {
            String mess = "Thông tin đăng nhập sai, hãy đăng nhập lại!";
            request.setAttribute("mess", mess);
            request.getRequestDispatcher("view/Login.jsp").forward(request, response);
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
