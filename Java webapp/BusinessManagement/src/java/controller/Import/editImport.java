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
import model.Bill;
import model.BillDetail;
import model.Import;
import model.ImportDetail;

/**
 *
 * @author Quan
 */
public class editImport extends BaseAuthenticationController {

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
        String[] product = request.getParameterValues("product");
        String[] describe = request.getParameterValues("describe");
        String[] unitprice = request.getParameterValues("unitprice");
        String[] quantity = request.getParameterValues("quantity");
        String[] price = request.getParameterValues("price");
        String raw_total = request.getParameter("total");
        String name = request.getParameter("name"); //
        String address = request.getParameter("address");//
        String raw_iid = request.getParameter("iid").trim();//
        String phone = request.getParameter("phone").trim();
        String confirm = request.getParameter("confirm");
        String raw_payment = request.getParameter("payment");
        String raw_debt = request.getParameter("debt");
        int debt = Integer.parseInt(raw_debt);
        int payment = Integer.parseInt(raw_payment);
        int total = Integer.parseInt(raw_total);
        int iid = Integer.parseInt(raw_iid);

        Account acc = (Account) request.getSession().getAttribute("account");
        AccountStaff accStaff = (AccountStaff) request.getSession().getAttribute("accountStaff");
        Account bid = null;
        if (acc == null) {
            bid = accStaff.getBid();
        } else {
            bid = acc;
        }
        ImportDBContext db = new ImportDBContext();
        Import im = new Import();
        im.setBid(bid);
        im.setIid(iid);
        im.setIname(name);
        im.setIphone(phone);
        im.setIaddress(address);
        im.setIconfirm(confirm);
        im.setItotal(total);
        im.setPayment(payment);
        im.setIdebt(debt);
        ImportDBContext dbnew = new ImportDBContext();
        ArrayList<Integer> nums=dbnew.getNum(iid);
        ArrayList<ImportDetail> list = new ArrayList<>();
        for (int i = 0; i < product.length; i++) {
            ImportDetail d = new ImportDetail();
            d.setIid(im);
            d.setIproduct(product[i]);
            d.setIdescribe(describe[i]);
            d.setIquantity(Integer.parseInt(quantity[i]));
            d.setIunitprice(Integer.parseInt(unitprice[i]));
            d.setIprice(Integer.parseInt(price[i]));
            d.setNum(nums.get(i));
            list.add(d);
        }
        db.updateImport(im, list, iid);
        response.sendRedirect("invoiceimport");
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
