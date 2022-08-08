/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package Filter;

import DAL.AccountDAO;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author Quan
 */
public class FilterForStaff implements Filter {

    @Override
    public void init(FilterConfig argo) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        if (isAuthenticated((HttpServletRequest) request)) {
            if (checkRole((HttpServletRequest) request)) {
                chain.doFilter(request, response);
            } else {
                request.getRequestDispatcher("view/Page403.jsp").forward(request, response);
            }
        } else {

            request.getRequestDispatcher("view/Login.jsp").forward(request, response);
        }
    }

    private boolean checkRole(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (Integer.parseInt(account.getRole()) != 3) {
            return true;
        }
        return false;
    }

    private boolean isAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            Cookie[] cookies = request.getCookies();
            if (cookies != null)//not login, some cookies
            {
                String username = null;
                String password = null;
                for (Cookie cooky : cookies) {
                    if (cooky.getName().equals("email")) {
                        username = cooky.getValue();
                    }
                    if (cooky.getName().equals("password")) {
                        password = cooky.getValue();
                    }
                }
                if (username == null || password == null) {
                    return false;
                } else {
                    AccountDAO db = new AccountDAO();
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

    @Override
    public void destroy() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
