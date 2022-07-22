/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AccountDAO;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Date;
import model.Account;

/**
 *
 * @author cloudy_place
 */
public class SignupController extends HttpServlet {

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
        request.getRequestDispatcher("view/Signup.jsp").forward(request, response);
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

        String fullName = request.getParameter("name");
        String email = request.getParameter("emailSignUp");
        String pass = request.getParameter("passSignUp");
        Boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
        Date dob = Date.valueOf(request.getParameter("dob"));
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String image = "";
        String role = "3";
        Boolean status = true;

        AccountDAO accountDao = new AccountDAO();
        String errorExistEmail = "";
        String errorPassLength = "";
        String signupSuccessfull = "";
        boolean checkExistEmail = false;
        boolean checkPassLength = false;
        if (accountDao.getExistEmail(email) != null) {
            errorExistEmail = "Email đã tồn tại. Hãy nhập email khác";
            request.setAttribute("errorExistEmail", errorExistEmail);
            checkExistEmail = true;

//            request.getRequestDispatcher("view/signup.jsp").forward(request, response);
//            response.sendRedirect("login");
        }
        if (pass.length() < 6) {
            errorPassLength = "Mật khẩu phải có ít nhất 6 kí tự";
            request.setAttribute("errorPassLength", errorPassLength);
            checkPassLength = true;
        }
        if (checkExistEmail == false && checkPassLength == false) {
            Account account = new Account(email, pass, fullName, gender, dob, address, phone, image, role, status);
            accountDao.insertAccount(account);
            signupSuccessfull = "Bạn đã đăng ký tài khoản thành công";
            request.setAttribute("signupSuccessfull", signupSuccessfull);
        }
        request.getRequestDispatcher("view/Signup.jsp").forward(request, response);
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
