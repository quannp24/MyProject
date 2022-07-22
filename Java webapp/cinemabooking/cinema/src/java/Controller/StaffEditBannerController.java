/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.BannerDAO;
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
import javax.servlet.http.Part;
import model.Banner;

/**
 *
 * @author Quan
 */
@MultipartConfig
public class StaffEditBannerController extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet StaffEditBannerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffEditBannerController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        request.setCharacterEncoding("utf-8");
        BannerDAO bannerDB = new BannerDAO();
        // Parameter Initializing
        String id = request.getParameter("id");

        // Get value from database
        Banner banner = bannerDB.get(Integer.parseInt(id));

        // Set attribute
        request.setAttribute("banner", banner);
        request.getRequestDispatcher("view/StaffEditBanner.jsp").forward(request, response);
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
        BannerDAO bannerDB = new BannerDAO();

        int new_id = Integer.parseInt(request.getParameter("new_id").trim());
        String new_title = request.getParameter("new_title").trim();

        String new_desc = request.getParameter("new_desc").trim();
        String new_start = request.getParameter("start");
        Date start = Date.valueOf(new_start);
        String new_finish = request.getParameter("finish");
        Date finish = Date.valueOf(new_finish);

        Part part = request.getPart("new_Img");  //lấy file ảnh truyền vào
        String realPath = "C:/Users/Quan/FU/SWP/cinemabooking/cinema/web/image/banner";  //truyền đường dẫn folder chứa ảnh
        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();  //
        String imgDB = "";
        //lay img cũ từ database và cắt lấy phần tên ảnh cũ
        String[] ImgOldDB = bannerDB.getImgBanner(new_id).split("/");
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
                imgDB = "image/banner/" + ImgOldDB[2]; //ko truyền ảnh nhưng có dữ liệu từ db trước đó
            }
        } else {
            imgDB = "image/banner/" + filename;   //có truyền ảnh
        }

        Banner banner = new Banner(new_id, imgDB, new_title, new_desc, start, finish);

        if (new_title.length() < 4 || new_title.length() > 100) {
            banner.setImg("image/banner/" + ImgOldDB[2]);
            request.setAttribute("banner", banner);
            request.setAttribute("error", "Độ dài tiêu đề phải từ 4-100 kí tự!");
            request.getRequestDispatcher("view/StaffEditBanner.jsp").forward(request, response);
        } else if (new_desc.length() < 4 || new_desc.length() > 5000) {
            banner.setImg("image/banner/" + ImgOldDB[2]);
            request.setAttribute("banner", banner);
            request.setAttribute("error", "Độ dài nội dung phải từ 4-5000 kí tự!");
            request.getRequestDispatcher("view/StaffEditBanner.jsp").forward(request, response);
        } else if (start.after(finish)) {
            request.setAttribute("banner", banner);
            request.setAttribute("error", "Ngày bắt đầu phải trước ngày kết thúc");
            request.getRequestDispatcher("view/StaffEditBanner.jsp").forward(request, response);
        } else {
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

            bannerDB.editBanner(banner);
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
