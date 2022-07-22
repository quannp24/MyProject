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
import model.BillDetail;

/**
 *
 * @author Quan
 */
public class EditBill extends BaseAuthenticationController {

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
        String name = request.getParameter("name").trim(); //
        String address = request.getParameter("address").trim();//
        String billcode = request.getParameter("billcode").trim();//
        String phone = request.getParameter("phone").trim();
        String paytype = request.getParameter("paytype").trim();
        String raw_payment = request.getParameter("payment");
        String raw_debt = request.getParameter("debt");
        int debt = Integer.parseInt(raw_debt);
        int payment = Integer.parseInt(raw_payment);
        int total = Integer.parseInt(raw_total);

        Account acc = (Account) request.getSession().getAttribute("account");
        AccountStaff accStaff = (AccountStaff) request.getSession().getAttribute("accountStaff");
        Account bid = null;
        if (acc == null) {
            bid = accStaff.getBid();
        } else {
            bid = acc;
        }
        SellDBContext db = new SellDBContext();
        SellDBContext dbnew = new SellDBContext();
        SellDBContext dbnum = new SellDBContext();
        Bill b = new Bill(bid, billcode, name, phone, address, payment, paytype, debt, total);
        ArrayList<BillDetail> list = new ArrayList<>();
        ArrayList<Integer> nums = dbnum.getNum(bid.getBid().trim(),billcode);
        for (int i = 0; i < product.length; i++) {
            BillDetail d = new BillDetail();
            d.setBid(bid);
            d.setBillcode(b);
            d.setProduct(product[i]);
            d.setDescribe(describe[i]);
            d.setQuantity(Integer.parseInt(quantity[i]));
            d.setUnitprice(Integer.parseInt(unitprice[i]));
            d.setPrice(Integer.parseInt(price[i]));
            d.setNum(nums.get(i));
            list.add(d);
        }
        db.updateBill(b, list, billcode, bid.getBid().trim());
        response.sendRedirect("bills");
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
