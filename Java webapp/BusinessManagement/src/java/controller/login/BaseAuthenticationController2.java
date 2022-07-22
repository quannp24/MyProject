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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Account;
import model.AccountStaff;

/**
 *
 * @author SAP-LAP-FPT
 */
public abstract class BaseAuthenticationController2 extends HttpServlet {

    private boolean isAuthenticated(HttpServletRequest request) {     //ktra login mới đc vào
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            Cookie[] cookies = request.getCookies();
            if (cookies != null)//not login, some cookies
            {
                String username = null;
                String password = null;
                for (Cookie cooky : cookies) {
                    if (cooky.getName().equals("username")) {
                        username = cooky.getValue();
                    }
                    if (cooky.getName().equals("password")) {
                        password = cooky.getValue();
                    }
                }
                if (username == null || password == null) {
                    return false;
                } else {
                    AccountDBContext db = new AccountDBContext();
                    account = db.getAccount(username, password);
                    if (account != null) {
                        request.getSession().setAttribute("account", account);
                        return true;
                    } else {
                        return false;
                    }
                }
            } else //not login, not cookie
            {
                return false;
            }
        }
        return true;

    }

    private boolean isAuthenticatedforStaff(HttpServletRequest request) {
        HttpSession session = request.getSession();

        AccountStaff accountStaff = (AccountStaff) session.getAttribute("accountStaff");
        if (accountStaff == null) {
            Cookie[] cookies = request.getCookies();
            if (cookies != null)//not login, some cookies
            {
                String username = null;
                String password = null;
                String bid = null;
                for (Cookie cooky : cookies) {
                    if (cooky.getName().equals("username")) {
                        username = cooky.getValue();
                    }
                    if (cooky.getName().equals("password")) {
                        password = cooky.getValue();
                    }
                    if (cooky.getName().equals("bid")) {
                        bid = cooky.getValue();
                    }
                }
                if (username == null || password == null || bid == null) {
                    return false;
                } else {
                    accountStaffDBContext db = new accountStaffDBContext();
                    accountStaff = db.getAccountStaff(username, password, bid);
                    if (accountStaff != null) {
                        request.getSession().setAttribute("accountStaff", accountStaff);
                        return true;
                    } else {
                        return false;
                    }
                }
            } else //not login, not cookie
            {
                return false;
            }
        }
        return true;

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
        if (isAuthenticated(request) || isAuthenticatedforStaff(request)) {
            //process business
            processGet(request, response);
        } else {
            if (!isAuthenticated(request)) {
                String mess = "Phiên đăng nhập đã hết hạn, hãy đăng nhập lại!";
                request.setAttribute("mess", mess);
                response.sendRedirect("../login");
            } else {
                String mess = "Phiên đăng nhập đã hết hạn, hãy đăng nhập lại!";
                request.setAttribute("mess", mess);
                response.sendRedirect("../slogin");
            }
        }
    }

    protected abstract void processGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException;

    protected abstract void processPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException;

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
        if (isAuthenticated(request) || isAuthenticatedforStaff(request)) {
            //process business
            processPost(request, response);
        } else {
            if (!isAuthenticated(request)) {
                String mess = "Phiên đăng nhập đã hết hạn, hãy đăng nhập lại!";
                request.setAttribute("mess", mess);
                response.sendRedirect("../login");
            } else {
                String mess = "Phiên đăng nhập đã hết hạn, hãy đăng nhập lại!";
                request.setAttribute("mess", mess);
                response.sendRedirect("../slogin");
            }
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
