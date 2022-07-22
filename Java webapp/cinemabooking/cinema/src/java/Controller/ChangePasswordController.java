/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;

/**
 *
 * @author senan
 */
public class ChangePasswordController extends HttpServlet {

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
//        response.setContentType("text/html;charset=UTF-8");
//        try ( PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet ChangePasswordController</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet ChangePasswordController at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
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
        int id = Integer.parseInt(request.getParameter("id"));
        AccountDAO adao = new AccountDAO();
        Account a =  adao.getAccountById(id);
//        String pass = a.getPassword();
//        request.setAttribute("pass", pass);
        request.setAttribute("id", id);
        request.getRequestDispatcher("view/ChangePassword.jsp").forward(request, response);
        
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
        PrintWriter out = response.getWriter();
        int id =Integer.parseInt( request.getParameter("id"));
        AccountDAO adao = new AccountDAO();
        Account a =  adao.getAccountById(id);
        try{
            
            String oldp = request.getParameter("oldp");
            if(oldp.equals("")||oldp == null){
                throw new Exception();
            }
            String newp = request.getParameter("newp");
            if(newp.equals("")||newp == null){
                throw new Exception();
            }
            String conp = request.getParameter("conp");
            if(conp.equals("")||conp == null){
                throw new Exception();
            }
            if(oldp.equals(a.getPassword())!=true){
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Old password not match');");
                out.println("location='changepass?id="+id+"';");
                out.println("</script>");
               
            }
            if(newp.equals(conp)!=true){
                out.println("<script type=\"text/javascript\">");
                out.println("alert('New password not match with confirm password');");
                out.println("location='changepass?id="+id+"';");
                out.println("</script>");
         
            }
            if(newp.equals(conp)&& oldp.equals(a.getPassword())){
                int check = adao.ChangePassword(id, newp);
                if(check ==1){
                    out.println("<script type=\"text/javascript\">");
                out.println("alert('Change password successful!');");
                out.println("location='login';");
                out.println("</script>");
                }
                else{
                   out.println("<script type=\"text/javascript\">");
                out.println("alert('Change password unsuccessful!');");
                out.println("location='changepass?id="+id+"';");
                out.println("</script>"); 
                }
            }
        }
        catch (Exception ex){
            out.println("<script type=\"text/javascript\">");
                out.println("alert('Change password unsuccessful!');");
                out.println("location='changepass?id="+id+"';");
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
