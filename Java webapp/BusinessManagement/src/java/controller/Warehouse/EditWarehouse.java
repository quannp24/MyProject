/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.Warehouse;

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
public class EditWarehouse extends BaseAuthenticationController {

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

        String product = request.getParameter("product");
        String quantity = request.getParameter("quantity");
        String delete = request.getParameter("delete");

        WarehouseDBContext db = new WarehouseDBContext();
        Account acc = (Account) request.getSession().getAttribute("account");
        AccountStaff accStaff = (AccountStaff) request.getSession().getAttribute("accountStaff");
        Account bid = null;
        if (acc == null) {
            bid = accStaff.getBid();
        } else {
            bid = acc;
        }
        if (delete != null) {
            db.deleteProduct(Integer.parseInt(delete));
        }
        if (product != null && quantity != null) {
            WarehouseDBContext dbnew = new WarehouseDBContext();
            Warehouse w = new Warehouse();
            w.setBid(bid);
            w.setProduct(product);
            w.setQuantity(Integer.parseInt(quantity));
            dbnew.updateProduct(w);
        }
        response.sendRedirect("warehouse");
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
