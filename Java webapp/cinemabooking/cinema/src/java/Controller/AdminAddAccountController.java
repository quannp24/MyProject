/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;

/**
 *
 * @author senan
 */
public class AdminAddAccountController extends HttpServlet {

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
        response.sendRedirect("");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("usermanagement");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        AccountDAO adao = new AccountDAO();
        try {
            String status = request.getParameter("status");
            String email = request.getParameter("email");
            if (email.contains("@gmail.com") != true) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Email không đúng định dạng!');");
                out.println("location='usermanagement';");
                out.println("</script>");
                return;
            }

            String password = request.getParameter("password");

            if (password.length()<4 ) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Mật khẩu phải lớn hơn 3 kí tự!');");
                out.println("location='usermanagement';");
                out.println("</script>");
                return;
            }

            String role = request.getParameter("role");

            String fullname = request.getParameter("fullname");

            if (fullname.length()<4 || fullname.length()>300) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Họ tên chứa từ 4-300 kí tự!');");
                out.println("location='usermanagement';");
                out.println("</script>");
                return;
            }

            String phone = request.getParameter("phone");

            if (phone.length()!=10) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Số điện thoại phải đủ 10 số!');");
                out.println("location='usermanagement';");
                out.println("</script>");
                return;
            }

            String address = request.getParameter("address");

            if (address.equals("") || address.length()<4 || address.length()>400) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Địa chỉ phải chứa từ 4-400 kí tự!');");
                out.println("location='usermanagement';");
                out.println("</script>");
                return;
            }
            Date dob = Date.valueOf(request.getParameter("dob"));

            boolean gender = request.getParameter("gender").equals("male");

            String image = "";

            Account account = new Account(email, password, fullname, gender, dob, address, phone, image, role, gender);

            adao.insertAccount(account);
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Thêm thành công!');");
            out.println("location='usermanagement';");
            out.println("</script>");

        } catch (Exception e) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Thêm thất bại!');");
            out.println("location='usermanagement';");
            out.println("</script>");
        }
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
