/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.BannerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Banner;

/**
 *
 * @author Quan
 */
public class AdminListBannerController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        BannerDAO bannerDao = new BannerDAO();

        // get pageIndex params
        String index = request.getParameter("pageIndex");
        if (index == null) {
            index = "1";
        }
        int pageIndex = Integer.parseInt(index);

        // count number of pages
        int total = bannerDao.getTotalBanner();
        int endPage = (int) Math.ceil((double) total / 3);

        // get list banner by pageindex
        List<Banner> bannerList = new ArrayList<>();
        bannerList = bannerDao.pagingBanner(pageIndex);
        for (Banner b : bannerList) {
            if (b.getDesc().length() > 151) {
                String s=b.getDesc().substring(0, 150)+"...";
                b.setDesc(s);
            }
        }

        // set properties and send to jsp
        request.setAttribute("bannerList", bannerList);
        request.setAttribute("total", total);
        request.setAttribute("endPage", endPage);
        request.setAttribute("pageIndex", pageIndex);

//        // Set Attribute
        // request.setAttribute("bannerList", bannerList);
        request.getRequestDispatcher("view/StaffListBanner.jsp").forward(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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
