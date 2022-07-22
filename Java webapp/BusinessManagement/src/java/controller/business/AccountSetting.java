package controller.business;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import controller.login.BaseAuthenticationController2;
import dal.AccountDBContext;
import java.io.IOException;
import java.io.PrintWriter;
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
public class AccountSetting extends BaseAuthenticationController2 {

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
//        request.getRequestDispatcher("/view/SettingAccount.jsp").forward(request, response);
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
        request.setAttribute("account", account);
        request.getRequestDispatcher("/view/SettingAccount.jsp").forward(request, response);
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
        String username = request.getParameter("username").trim();
        String name = request.getParameter("name");
        String passcurr = request.getParameter("passcurrent");
        String passnew = request.getParameter("password");
        String passnew_confirm = request.getParameter("password2");
        Account acc = (Account) request.getSession().getAttribute("account");
        AccountStaff accStaff = (AccountStaff) request.getSession().getAttribute("accountStaff");
        Account account = null; //code lấy bid
        if (acc == null) {
            account = accStaff.getBid();
        } else {
            account = acc;
        }
        if (!passcurr.equals(account.getPassword())) {  
            String mess = "Mật khẩu hiện tại sai, hãy nhập lại!";
            request.setAttribute("mess", mess);
        }
        
        if (!passnew.equals(passnew_confirm)) {
            String mess = "Mật khẩu mới không trùng nhau, hãy nhập lại!";
            request.setAttribute("mess", mess);
        }
        request.setAttribute("account", account);
        if(passnew.equals(passnew_confirm) && passcurr.equals(account.getPassword())){
            AccountDBContext db = new AccountDBContext();
            db.updateAccount(account, passnew, name);
            response.sendRedirect("../logoutacc");
        }else
        
        request.getRequestDispatcher("/view/SettingAccount.jsp").forward(request, response);
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
