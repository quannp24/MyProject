/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.business;

import controller.login.BaseAuthenticationController2;
import dal.AdminDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.AccountStaff;

/**
 *
 * @author Quan
 */
public class StaffControl extends BaseAuthenticationController2 {

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
//        request.getRequestDispatcher("/view/admincontrol.jsp").forward(request, response);
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
    protected void processGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account acc = (Account) request.getSession().getAttribute("account");
        AccountStaff accStaff = (AccountStaff) request.getSession().getAttribute("accountStaff");
        Account account = null; //code lấy bid
        if (acc == null) {
            account = accStaff.getBid();
        } else {
            account = acc;
        }
        AdminDBContext db = new AdminDBContext();
        ArrayList<AccountStaff> list = db.getStaffs(account.getBid().trim());
        request.setAttribute("staffs", list);
        request.setAttribute("account", account);
        request.getRequestDispatcher("/view/admincontrol.jsp").forward(request, response);
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
    protected void processPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String userStaff = request.getParameter("username").trim();
        String passStaff = request.getParameter("password").trim();
        String displayname = request.getParameter("name");
        Account acc = (Account) request.getSession().getAttribute("account");
        AccountStaff accStaff = (AccountStaff) request.getSession().getAttribute("accountStaff");
        Account bid = null; //code lấy bid
        if (acc == null) {
            bid = accStaff.getBid();
        } else {
            bid = acc;
        }
        AdminDBContext db = new AdminDBContext();
        if (db.checkUserStaff(userStaff, bid.getBid().trim())) {
            String mess = "Tên đăng nhập đã tồn tại!";
            request.setAttribute("mess", mess);
            request.getRequestDispatcher("/view/admincontrol.jsp").forward(request, response);
            return;
        } else {
            AccountStaff staff = new AccountStaff();
            staff.setBid(bid);
            staff.setDisplayname(displayname);
            staff.setUserStaff(userStaff);
            staff.setPassStaff(passStaff);
            db.insertStaff(staff);
            String mess = "Đã thêm thành viên mới.";
            AdminDBContext dbnew= new AdminDBContext();
            ArrayList<AccountStaff> list = dbnew.getStaffs(bid.getBid().trim());
            request.setAttribute("mess", mess);
            request.setAttribute("staffs", list);
            request.setAttribute("account", bid);
            request.getRequestDispatcher("/view/admincontrol.jsp").forward(request, response);
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
