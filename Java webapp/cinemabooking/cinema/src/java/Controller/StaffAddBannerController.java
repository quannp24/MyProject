/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.BannerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Banner;

/**
 *
 * @author Quan
 */
@MultipartConfig
public class StaffAddBannerController extends HttpServlet {

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
//            out.println("<title>Servlet StaffAddBannerController</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet StaffAddBannerController at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");

        // Lead to AdminAddBanner.jsp
        request.getRequestDispatcher("view/StaffAddBanner.jsp").forward(request, response);
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
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        BannerDAO bannerDB = new BannerDAO();

        // Parameter Initializing
        String new_title = request.getParameter("new_title".trim());
        String new_desc = request.getParameter("new_desc").trim();
        String new_start = request.getParameter("start");
        Date start = Date.valueOf(new_start);
        String new_finish = request.getParameter("finish");
        Date finish = Date.valueOf(new_finish);
        Part part = request.getPart("new_Img");  //lấy file ảnh truyền vào
        String realPath = "C:/Users/Quan/FU/SWP/cinemabooking/cinema/web/image/banner";  //truyền đường dẫn folder chứa ảnh
        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();

        // Set the value
        Banner banner = new Banner(0, "image/banner/" + filename, new_title, new_desc, start, finish);

        if (new_title.length() < 4 || new_title.length() > 100) {
            request.setAttribute("banner", banner);
            request.setAttribute("error", "Độ dài tiêu đề phải từ 4-100 kí tự!");
            request.getRequestDispatcher("view/StaffAddBanner.jsp").forward(request, response);
        } else if (new_desc.length() < 4 || new_desc.length() > 5000) {
            request.setAttribute("banner", banner);
            request.setAttribute("error", "Độ dài nội dung phải từ 4-5000 kí tự!");
            request.getRequestDispatcher("view/StaffAddBanner.jsp").forward(request, response);
        } else if (filename == null || filename.trim().length() < 1) {
            request.setAttribute("banner", banner);
            request.setAttribute("error", "Ảnh không được để trống");
            request.getRequestDispatcher("view/StaffAddBanner.jsp").forward(request, response);
        } else if (start.after(finish)) {
            request.setAttribute("banner", banner);
            request.setAttribute("error", "Ngày bắt đầu phải trước ngày kết thúc");
            request.getRequestDispatcher("view/StaffAddBanner.jsp").forward(request, response);
        } else {
            if (!Files.exists(Paths.get(realPath))) {
                Files.createDirectory(Paths.get(realPath));
            }
            part.write(realPath + "/" + filename);
            bannerDB.addBanner(banner);
            response.sendRedirect(request.getContextPath() + "/listbanner");
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
