/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.business;

import controller.login.BaseAuthenticationController;
import dal.ImportDBContext;
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
import model.Import;
import model.ImportDebt;
import model.ImportDetail;
import model.Warehouse;

/**
 *
 * @author Quan
 */
public class importController extends BaseAuthenticationController {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
        request.getRequestDispatcher("/view/import.jsp").forward(request, response);
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
        String[] product = request.getParameterValues("product");
        String[] describe = request.getParameterValues("describe");
        String[] unitprice = request.getParameterValues("unitprice");
        String[] quantity = request.getParameterValues("quantity");
        String[] price = request.getParameterValues("price");
        String raw_total = request.getParameter("total");
        String iname = request.getParameter("iname");
        String iaddress = request.getParameter("iaddress");
        String iphone = request.getParameter("iphone");
        String iconform = request.getParameter("iconfirm");
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
        ImportDBContext db = new ImportDBContext();
        Boolean status=debt>0?true:false; 
        WarehouseDBContext productdb = new WarehouseDBContext();
        int iid = db.getIid();
        Import m = new Import(iid, bid, iname, iphone, iaddress, iconform, total, debt, payment);
        ImportDebt d= new ImportDebt();
        d.setIid(m);
        d.setStatus(status);
        ArrayList<ImportDetail> list = new ArrayList<>();
        for (int i = 0; i < product.length; i++) {
            ImportDetail im = new ImportDetail();
            im.setIid(m);
            im.setIproduct(product[i]);
            im.setIdescribe(describe[i]);
            im.setIunitprice(Integer.parseInt(unitprice[i]));
            im.setIquantity(Integer.parseInt(quantity[i]));
            im.setIprice(Integer.parseInt(price[i]));
            list.add(im); //truyền các product vào mảng
            Warehouse w = productdb.getProduct(im.getIproduct(), bid.getBid());
            if (w == null) {    //check nếu product chưa có trong kho thì insert mới
                Warehouse p = new Warehouse();
                p.setBid(bid);
                p.setProduct(im.getIproduct());
                p.setQuantity(im.getIquantity());
                WarehouseDBContext po = new WarehouseDBContext();
                po.insertProduct(p);
            } else {               //còn nếu có rồi thì +quantity
                w.setQuantity(im.getIquantity() + w.getQuantity());
                WarehouseDBContext po = new WarehouseDBContext();
                po.updateProduct(w);
            }

        }
        db.insertImport(m, list,d);
        String re = "Nhập kho thành công!";
        request.setAttribute("mess", re);
        request.getRequestDispatcher("/view/import.jsp").forward(request, response);

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
