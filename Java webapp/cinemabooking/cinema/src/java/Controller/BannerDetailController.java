/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.BannerDAO;
import DAL.MovieDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Banner;
import model.Movie;

/**
 *
 * @author Quan
 */
public class BannerDetailController extends HttpServlet {

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
//        request.setCharacterEncoding("UTF-8");
//        int bannerId = Integer.parseInt(request.getParameter("id"));
//        BannerDAO bannerDB = new BannerDAO();
//        Banner banner = bannerDB.get(bannerId);
//        request.setAttribute("banner", banner);
//        // SHOW THE LIST OF MOVIE
//        DAL.MovieDAO dal = new MovieDAO();
//        ArrayList<Movie> arr = dal.top8Movies();
//        request.setAttribute("listMov", arr);
//        // SHOW THE LIST OF BANNER
//        DAL.BannerDAO dalBanner = new BannerDAO();
//        ArrayList<Banner> arrBanner = dalBanner.listBanner();
//        request.setAttribute("listBanner", arrBanner);
//        request.getRequestDispatcher("view/BannerDetail.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        int bannerId = Integer.parseInt(request.getParameter("bannerId"));
        BannerDAO bannerDB = new BannerDAO();
        Banner banner = bannerDB.get(bannerId);


        try ( PrintWriter out = response.getWriter()) {
            out.print(" <div class=\"modal-nofi-overlay\"></div>\n"
                    + "            <div class=\"modal-add-banner modal-dialog-scrollable\" role=\"document\" >\n"
                    + "                <button onclick=\"closeBannerModal()\"  id=\"cboxClose-banner\" ></button>\n"
                    + "                <div class=\"modal-body row\" style=\"padding-bottom: 0;\">\n"
                    + "                    <div class=\"image-banner\">\n"
                    + "                        <img src=\""+banner.getImg()+"\"  alt=\"...\" />\n"
                    + "                    </div>\n"
                    + "                    <div class=\"form-group\" style=\"text-align: center;margin: 5px auto\">\n"
                    + "                        <h4 class=\"modal-add-title\" style=\"font-weight: bold\">"+banner.getTitle().toUpperCase()+"</h4>\n"
                    + "                    </div>\n"
                    + "                    <div class=\"form-group\">\n"
                    + "                        <label>"+banner.getDesc()+"</label>\n"
                    + "                    </div>\n"
                    + "                </div>\n"
                    + "            </div>");
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
