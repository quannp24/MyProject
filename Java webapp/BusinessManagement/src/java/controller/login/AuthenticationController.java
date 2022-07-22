/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.login;

import dal.AccountDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;

/**
 *
 * @author Quan
 */
public class AuthenticationController extends HttpServlet {

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
//        request.getRequestDispatcher("/view/login.jsp").forward(request, response);
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
        request.getRequestDispatcher("/view/login.jsp").forward(request, response);
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
        //logout khi login vào acc khác
        request.getSession().invalidate();
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        Cookie c_userd = new Cookie("username", "");
        Cookie c_passd = new Cookie("password", ""); 
        c_userd.setMaxAge(0);
        c_passd.setMaxAge(0);  
        response.addCookie(c_userd);
        response.addCookie(c_passd);


        String username_signup = request.getParameter("username").trim();
        String password_signup = request.getParameter("pass").trim();
        String conpass_signup = request.getParameter("conpass").trim();
        String username_login = request.getParameter("username1").trim();
        String password_login = request.getParameter("pass1").trim();
        String signup = request.getParameter("signup");
        String login = request.getParameter("login");
        String displayname = request.getParameter("displayname");

        if (login != null && login != "") {  //login
            AccountDBContext db = new AccountDBContext();
            Account account = db.getAccount(username_login, password_login);
            if (account != null) {
                request.getSession().setAttribute("account", account);
                String usern = account.getUsername();
                request.setAttribute("usern", usern);
                String remember = request.getParameter("remember");
                if (remember != null) {
                    Cookie c_user = new Cookie("username", username_login);
                    Cookie c_pass = new Cookie("password", password_login);
                    c_user.setMaxAge(24 * 3600 * 7);
                    c_pass.setMaxAge(24 * 3600 * 7);
                    response.addCookie(c_user);
                    response.addCookie(c_pass);
                }

                response.sendRedirect("manage");  //sau chỉnh dispatcher đến manage
            } else {
                String mess = "Thông tin đăng nhập sai, hãy đăng nhập lại!";
                request.setAttribute("mess", mess);
                request.getRequestDispatcher("/view/login.jsp").forward(request, response);   //login   /record
            }
        }

        if (signup != null && signup != "") {   //register
            if(username_signup.length()<1 || password_signup.length()<1){
                String mess = "Thông tin đăng ký thiếu, hãy điền lại!";
                request.setAttribute("mess", mess);
                request.getRequestDispatcher("/view/login.jsp").forward(request, response);
                return;
            }
            if (!conpass_signup.equals(password_signup)) {
                String mess = "Mật khẩu xác nhận sai, hãy nhập lại";
                request.setAttribute("mess", mess);
                request.getRequestDispatcher("/view/login.jsp").forward(request, response);
                return;
            } else {

                AccountDBContext db = new AccountDBContext();
                String raw_bid = rand_bid(7);
                while (db.checkBid(raw_bid)) { //sinh ra code bid ngẫu nhiên, trùng thì tạo mới lại
                    raw_bid = rand_bid(7);
                }
                if (db.checkUsername(username_signup)) {
                    String mess = "Username đã tồn tại, hãy nhập username khác.";
                    request.setAttribute("mess", mess);
                    request.getRequestDispatcher("/view/login.jsp").forward(request, response);
                    return;
                } else {
                    Account account = new Account();
                    account.setBid(raw_bid);
                    account.setPassword(password_signup);
                    account.setUsername(username_signup);
                    account.setDisplayname(displayname);
                    request.getSession().setAttribute("account", account);
                    db.insertAccount(account);
                    response.sendRedirect("manage");  //sau chỉnh lại
                }
            }
        }

    }

    public static String rand_bid(int length) {   //tạo bid ngẫu nhiên
        char[] alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".toCharArray();
        int max = alphabet.length - 1;
        int min = 0;
        String str = "";
        for (int i = 0; i < length; i++) {
            str += alphabet[(int) Math.floor(Math.random() * (max - min + 1) + min)];
        }
        return str;
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
