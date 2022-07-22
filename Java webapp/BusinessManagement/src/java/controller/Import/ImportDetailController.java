/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.Import;

import controller.login.BaseAuthenticationController;
import dal.ImportDBContext;
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
import model.Import;
import model.ImportDebt;
import model.ImportDetail;

/**
 *
 * @author Quan
 */
public class ImportDetailController extends BaseAuthenticationController {

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
        String raw_iid=request.getParameter("iid");
        int iid=Integer.parseInt(raw_iid);
        Account acc = (Account) request.getSession().getAttribute("account");
        AccountStaff accStaff = (AccountStaff) request.getSession().getAttribute("accountStaff");
        Account bid = null; //code lấy bid
        if (acc == null) {
            bid = accStaff.getBid();
        } else {
            bid = acc;
        }
        ImportDBContext db = new ImportDBContext();
        
        ArrayList<ImportDetail> details = db.getImportDetail(iid);
        Import b= db.getImport(iid);
        ImportDebt bd= db.getImportDebt(iid);
        request.setAttribute("details", details);
        request.setAttribute("importdebt", bd);
        request.setAttribute("import", b);
        
        request.getRequestDispatcher("/view/ImportDetail.jsp").forward(request, response);
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
