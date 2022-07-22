/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.Account;

/**
 *
 * @author Quan
 */
@MultipartConfig
public class EditAccountController extends HttpServlet {

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
//        response.setContentType("text/html;charset=UTF-8");
//        try ( PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet EditAccountController</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet EditAccountController at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO adao = new AccountDAO();
        int id = Integer.parseInt(request.getParameter("id"));

        Account a = adao.getAccountById(id);
        if (a == null) {
            response.sendRedirect("login");
            return;
        } else {
            request.setAttribute("account", a);
            request.getRequestDispatcher("view/EditAccount.jsp").forward(request, response);
            return;
        }

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
        AccountDAO db = new AccountDAO();
        //get account properites from jsp
        String email = request.getParameter("email").replaceAll("\\s+", " ").trim();

        String fullname = request.getParameter("fullname");
        Date dob = Date.valueOf(request.getParameter("dob"));
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        String raw_gender = request.getParameter("gender").trim();
        Boolean gender = raw_gender.equals("1") ? true : false;
        int accId = Integer.parseInt(request.getParameter("id"));

        Part part = request.getPart("avatar");  //lấy file ảnh truyền vào
        String realPath = "C:/Users/Quan/FU/SWP/cinemabooking/cinema/web/image/avatar";  //truyền đường dẫn folder chứa ảnh
        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        String imgDB = "";
        //lay img cũ từ database và cắt lấy phần tên ảnh cũ
        String[] ImgOldDB = db.getImgAccountById(accId).split("/");
        //đường dẫn đến thư mục chứa ảnh cũ

        Path path = null;
        if (ImgOldDB.length > 1) {
            path = Paths.get(realPath + "/" + ImgOldDB[2]);
        }
        //nếu ko cập nhật ảnh mới thì vẫn giữ nguyên đường dẫn ảnh cũ từ database
        if (filename.trim().length() < 1) {
            if (ImgOldDB.length < 2) { //ko truyền ảnh và db cũng ko có dữ liệu trước đó
                imgDB = "";
            } else {
                imgDB = "image/avatar/" + ImgOldDB[2]; //ko truyền ảnh nhưng có dữ liệu từ db trước đó
            }
        } else {
            imgDB = "image/avatar/" + filename;   //có truyền ảnh
        }
        AccountDAO dbUpdate = new AccountDAO();
        //set popeties into new account
        Account account = new Account();
        account.setEmail(email);
        account.setAddress(address);
        account.setGender(gender);
        account.setImg(imgDB);
        account.setFullname(fullname);
        account.setDob(dob);
        account.setAccId(accId);
        account.setPhone(phone);
        account.setRole(role);
        String mess = "";
        if (fullname.trim().length()<5 || fullname.trim().length()>300) {
            mess = "Họ tên phải chứa 5-300 kí tự!";
        } else if (address.length() < 6) {
            mess = "Địa chỉ phải có ít nhất 6 ký tự";
        } else if (phone.length() > 10 || phone.length() < 10) {
            mess = "Số điện thoại không phải là 10 số";
        } else {

            //edit account
            int check = dbUpdate.UpdateAccount(account);

            //get edit status through check variable
            if (check == 1) {
                if (!Files.exists(Paths.get(realPath))) {
                    Files.createDirectory(Paths.get(realPath));
                }
                if (filename.trim().length() > 1) { //truyền lên ảnh
                    if (ImgOldDB.length > 1) {
                        if (Files.exists(path)) { //check có tồn tại file ảnh, có thì xóa
                            Files.delete(path);
                        }
                    }
                    part.write(realPath + "/" + filename);
                }

                String successMessage = "Đã cập nhật thông tin tài khoản!";
                request.setAttribute("successMessage", successMessage);
//                HttpSession session = request.getSession();
//                session.removeAttribute("account");
//                session.setAttribute("account", account);

            } else {
                String failMessage = "Không thể cập nhật thông tin tài khoản!";
                request.setAttribute("failMessage", failMessage);

            }
        }

        request.setAttribute("mess", mess);
        AccountDAO d = new AccountDAO();
        Account acc = d.getAccountById(accId); //lấy thông tin mới cập nhật từ db
        request.setAttribute("account", acc);
        request.getRequestDispatcher("view/UserProfile.jsp").forward(request, response);
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
