/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.business;

import controller.login.BaseAuthenticationController;
import dal.ExpenseDBContext;
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
import model.Import;

/**
 *
 * @author Quan
 */
public class ExpenseController extends BaseAuthenticationController {

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
        String raw_date = request.getParameter("search")==null?"":request.getParameter("search");
        
        int year = 0;
        int month = 0;
        int day = 0;
//        int sum=0;
        if (raw_date != ""||raw_date.trim().length()>0) {
            String date[] = raw_date.split("-");
            year=Integer.parseInt(date[0]);
            month=Integer.parseInt(date[1]);
            day=Integer.parseInt(date[2]);
        }
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
        ExpenseDBContext db = new ExpenseDBContext();
        ExpenseDBContext dbnew = new ExpenseDBContext();
        ExpenseDBContext da = new ExpenseDBContext();
        
        int totalrecords = dbnew.count(bid, year, month, day);
        int sum=da.sum(bid, year, month, day);
        ArrayList<Bill> bills = db.getBills(pageindex, pagesize, bid.trim(), year, month, day);
        int totalpage = (totalrecords % pagesize == 0) ? totalrecords / pagesize
                : (totalrecords / pagesize) + 1;
        request.setAttribute("bills", bills);
        
        request.setAttribute("totalpage", totalpage);
        request.setAttribute("sum", sum);
        request.setAttribute("totalrecords", totalrecords);
        request.setAttribute("pageindex", pageindex);
        request.setAttribute("pagesize", pagesize);
        
        String raw_pageL = request.getParameter("pageleft");   //LEFT
        if (raw_pageL == null || raw_pageL.trim().length() == 0) {
            raw_pageL = "1";
        }
        int pageindexL = Integer.parseInt(raw_pageL);
        int pagesizeL = 5;
        ExpenseDBContext importdb = new ExpenseDBContext();
        ExpenseDBContext importdb2 = new ExpenseDBContext();
        ExpenseDBContext importdbnew = new ExpenseDBContext();
        int totalrecordsL=importdb.countI(bid, year, month, day);
        int sumL=importdb2.sumI(bid, year, month, day);
        ArrayList<Import> imports = importdbnew.getImports(pageindexL, pagesizeL, bid.trim(), year, month, day);
        int totalpageL = (totalrecordsL % pagesizeL == 0) ? totalrecordsL / pagesizeL
                : (totalrecordsL / pagesizeL) + 1;
        
        request.setAttribute("imports", imports);
        request.setAttribute("search", raw_date);
        request.setAttribute("totalpageL", totalpageL);
        request.setAttribute("sumL", sumL);
        request.setAttribute("totalrecordsL", totalrecordsL);
        request.setAttribute("pageindexL", pageindexL);
        request.setAttribute("pagesizeL", pagesizeL);
        request.getRequestDispatcher("/view/expense.jsp").forward(request, response);
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
