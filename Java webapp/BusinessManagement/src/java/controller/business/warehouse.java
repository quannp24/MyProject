/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.business;

import controller.login.BaseAuthenticationController;
import dal.WarehouseDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.AccountStaff;
import model.Warehouse;

/**
 *
 * @author Quan
 */
public class warehouse extends BaseAuthenticationController {

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
        WarehouseDBContext db = new WarehouseDBContext();
        String raw_page = request.getParameter("page");
        String search = request.getParameter("search");
        String edit = request.getParameter("edit");
        String month = request.getParameter("month");
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
        int pagesize = 4;
        ArrayList<Warehouse> ware = db.getProducts(pageindex, pagesize, bid,search);
        WarehouseDBContext dbnew = new WarehouseDBContext();
         int totalrecords = dbnew.count(bid,search);
        if(edit!=null ){
            Warehouse pro=ware.get(Integer.parseInt(edit));
            request.setAttribute("edit", pro);
            request.setAttribute("num", edit);
        }
        if(month!=null){
            ware=db.getProductsMonth(pageindex, pagesize, bid);
            totalrecords = dbnew.countM(bid);
        }
       
        
        int totalpage = (totalrecords % pagesize == 0) ? totalrecords / pagesize
                : (totalrecords / pagesize) + 1;
        request.setAttribute("wares", ware);
        request.setAttribute("totalpage", totalpage);
        request.setAttribute("search", search);
        request.setAttribute("month", month);
        request.setAttribute("totalrecords", totalrecords);
        request.setAttribute("pageindex", pageindex);
        request.setAttribute("pagesize", pagesize);
        request.getRequestDispatcher("/view/warehouse.jsp").forward(request, response);
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
