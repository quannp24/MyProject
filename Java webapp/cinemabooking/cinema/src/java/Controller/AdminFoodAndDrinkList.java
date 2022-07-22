/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.FoodAndDrinkDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.FoodAndDrink;

/**
 *
 * @author MSI
 */
public class AdminFoodAndDrinkList extends HttpServlet {

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
//            
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
        response.setContentType("text/html;charset=UTF-8");
        DAL.FoodAndDrinkDAO dao=new FoodAndDrinkDAO();
//        DAL.PagingDAO paging=new PagingDAO();
        //Phan Trang
        String index=request.getParameter("pageIndex");
        // Trang trong thi ve lai trang 1
        if(index==null){
            index="1";
        }
        int pageIndex=Integer.parseInt(index);
        //count number of pages
        int total= dao.totalFood();//14
        int endPage= (int)Math.ceil((double) total/3);
        //get list banner by pageIndex
        ArrayList<FoodAndDrink> foodList=new ArrayList<>();
        foodList=dao.pagingFAD(pageIndex);
        request.setAttribute("foodList", foodList);
        request.setAttribute("total", total);
        request.setAttribute("endPage", endPage);
        request.setAttribute("pageIndex", pageIndex);
        
        request.getRequestDispatcher("view/AdminFoodAndDrink.jsp").forward(request, response);
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
//        processRequest(request, response);
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
