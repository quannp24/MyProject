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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.AccountStaff;
import model.Bill;
import model.BillDebt;
import model.BillDetail;

/**
 *
 * @author Quan
 */
public class billController extends BaseAuthenticationController {

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
//        request.getRequestDispatcher("/view/writebill.jsp").forward(request, response);
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
        request.getRequestDispatcher("/view/writebill.jsp").forward(request, response);
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
            throws ServletException, IOException {  // program viết bill, dùng insert bill vào Bill
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String[] product = request.getParameterValues("product");
        String[] describe = request.getParameterValues("describe");
        String[] unitprice = request.getParameterValues("unitprice");
        String[] quantity = request.getParameterValues("quantity");
        String[] price = request.getParameterValues("price");
        String raw_total = request.getParameter("total");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String paytype = request.getParameter("paytype");
        String raw_payment = request.getParameter("payment");
        String raw_debt = request.getParameter("debt");
        int debt = Integer.parseInt(raw_debt);
        int payment = Integer.parseInt(raw_payment);
        int total = Integer.parseInt(raw_total);
        Account acc = (Account) request.getSession().getAttribute("account");
        AccountStaff accStaff = (AccountStaff) request.getSession().getAttribute("accountStaff");
        Account bid = null; //code lấy bid
        if (acc == null) {
            bid = accStaff.getBid();
        } else {
            bid = acc;
        }
        Boolean status = debt > 0 ? true : false;
        SellDBContext db = new SellDBContext();
        String raw_billcode = db.getBillcode(bid.getBid().trim());  //lấy billcode gần nhất 
        int idbill = db.getIdbill(bid.getBid().trim());  //lấy idbill gần nhất 
        String billcode = rand_billcode(raw_billcode);  //set lại billcode để ko bị trùng
        Bill b = new Bill(bid, billcode, name, phone, address, payment, paytype, debt, total);
        Bill bil = new Bill();
        bil.setId(idbill + 1);
        BillDebt billdebt = new BillDebt();
        billdebt.setIdbill(bil);
        billdebt.setStatus(status);
        ArrayList<BillDetail> list = new ArrayList<>();
        for (int i = 0; i < product.length; i++) {
            BillDetail d = new BillDetail();
            d.setBid(bid);
            d.setIdbill(bil);
            d.setBillcode(b);
            d.setProduct(product[i]);
            d.setDescribe(describe[i]);
            d.setQuantity(Integer.parseInt(quantity[i]));
            d.setUnitprice(Integer.parseInt(unitprice[i]));
            d.setPrice(Integer.parseInt(price[i]));
            list.add(d);
        }
        db.insertBill(b, list, billdebt);
        String re = "Lưu hóa đơn thành công!";
        request.setAttribute("mess", re);
        request.getRequestDispatcher("/view/writebill.jsp").forward(request, response);

    }

    public static String rand_billcode(String billcode) {   //tạo code ngẫu nhiên  YYYY-XXXXXXXXX
        String str = "";
        String re = "";
        int count = 0;
        Date date = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
        str += formatter.format(date);
        if (billcode.trim().length()>1) {
            String[] code = billcode.trim().split("-");
            int num = Integer.parseInt(code[1]) + 1;
            int div = num;
            while (div > 0) {
                div /= 10;
                count++;    // đếm số chữ số của num
            }
            if (code[0].equals(str)) {
                re += str + "-";
                for (int i = 0; i < 8 - count; i++) {
                    re += "0";
                }
                re += num;
            } else {
                re += str + "-00000001";
            }
        }else{
            re += str + "-00000001";
        }
        return re;
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
