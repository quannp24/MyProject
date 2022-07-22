/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.sell;

import controller.login.BaseAuthenticationController;
import dal.SellDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.AccountStaff;
import model.Bill;

/**
 *
 * @author Quan
 */
public class listBillController extends BaseAuthenticationController {

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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String raw_page = request.getParameter("page");
        String name = request.getParameter("name") == null ? "" : request.getParameter("name");
        String raw_filter = request.getParameter("filter")==null ? "0" : request.getParameter("filter");
        int filter = Integer.parseInt(raw_filter);
        Account acc = (Account) request.getSession().getAttribute("account");
        AccountStaff accStaff = (AccountStaff) request.getSession().getAttribute("accountStaff");
        String bid = "";
        if (acc != null) {
            bid = acc.getBid();
        } else {
            bid = accStaff.getBid().getBid();
        }
        if (raw_page == null || raw_page.trim().length() == 0) {
            raw_page = "1";
        }
        int pageindex = Integer.parseInt(raw_page);
        int pagesize = 5;
        SellDBContext db = new SellDBContext();
        int totalrecords = db.count(bid.trim(), name, filter);
        ArrayList<Bill> bills = db.getBills(pageindex, pagesize, bid.trim(), name, filter);
        int totalpage = (totalrecords % pagesize == 0) ? totalrecords / pagesize
                : (totalrecords / pagesize) + 1;
        request.setAttribute("bills", bills);
        request.setAttribute("filter", filter);
        request.setAttribute("name", name);
        request.setAttribute("totalpage", totalpage);
        request.setAttribute("totalrecords", totalrecords);
        request.setAttribute("pageindex", pageindex);
        request.setAttribute("pagesize", pagesize);
        request.getRequestDispatcher("/view/bills.jsp").forward(request, response);
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
    protected void processGet(HttpServletRequest request, HttpServletResponse response)
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
    protected void processPost(HttpServletRequest request, HttpServletResponse response)
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
