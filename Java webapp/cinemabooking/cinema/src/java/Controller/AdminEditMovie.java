/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.MovieDAO;
import Validation.ValidateMovie;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
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
import model.Movie;

/**
 *
 * @author Quan
 */
@MultipartConfig
public class AdminEditMovie extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
        MovieDAO db = new MovieDAO();
        int movieId = Integer.parseInt(request.getParameter("movieID"));//lay movie id tu request
        Movie movie = db.getMovieById(movieId);// lay ra movie update
        request.setAttribute("movie", movie);

        request.getRequestDispatcher("view/AdminEditMovie.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8"); //có thể nhận dữ liệu là tiếng việt

        MovieDAO db = new MovieDAO();
        int movieId = Integer.parseInt(request.getParameter("movieID").trim());
        String movieName = request.getParameter("movieName").trim();

        Part part = request.getPart("movieImage");  //lấy file ảnh truyền vào
        String fileName
                = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        InputStream inputStream = part.getInputStream();
        InputStream inputStream2 = part.getInputStream();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "image" + File.separator + "movie";
        String[] newd = uploadPath.split("build");
        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();  //

        String movieCategory = request.getParameter("movieCategory").trim();
        String description = request.getParameter("movieDescription").trim();
        String movieLanguage = request.getParameter("movieLanguage").trim();
        String movieRated = request.getParameter("movieRated").trim();
        String movieDuration = request.getParameter("movieDuration").trim();
        int duration = Integer.parseInt(movieDuration);
        String movieStartdate = request.getParameter("startdate");
        Date premiere = Date.valueOf(movieStartdate);//ep kieu du lieu cho date
        String raw_enddate = request.getParameter("enddate") == null ? "" : request.getParameter("enddate");
        Date endDate = null;
        if (raw_enddate != null && raw_enddate.trim().length() > 0) {
            endDate = Date.valueOf(raw_enddate);
        }
        String imgDB = "";
        //lay img cũ từ database và cắt lấy phần tên ảnh cũ
        String[] ImgOldDB = db.getImgMovieById(movieId).split("/");
        //đường dẫn đến thư mục chứa ảnh cũ
        Path path = null;
        Path path2 = null;
        if (ImgOldDB.length > 1) {
            path = Paths.get(uploadPath + File.separator + ImgOldDB[2]);
            path2 = Paths.get(newd[0] + File.separator + "web"
                    + File.separator + "image" + File.separator + "movie" + File.separator + ImgOldDB[2]);
        }
        //nếu ko cập nhật ảnh mới thì vẫn giữ nguyên đường dẫn ảnh cũ từ database
        if (filename.trim().length() < 1) {
            if (ImgOldDB.length < 2) { //ko truyền ảnh và db cũng ko có dữ liệu trước đó
                imgDB = "";
            } else {
                imgDB = "image/movie/" + ImgOldDB[2]; //ko truyền ảnh nhưng có dữ liệu từ db trước đó
            }
        } else {
            imgDB = "image/movie/" + filename;   //có truyền ảnh
        }

        Movie movie = new Movie(movieId, movieName, movieCategory, premiere, duration, movieLanguage, movieRated, description, imgDB, endDate);

        if (movieName.length() < 4 || movieName.length() > 3000) {
            movie.setImage("image/movie/" + ImgOldDB[2]);
            request.setAttribute("movie", movie);
            request.setAttribute("error", "Tên phim không được để trống và giới hạn 4-3000 ký tự!!!");
            request.getRequestDispatcher("view/AdminEditMovie.jsp").forward(request, response);
        } else if (movieCategory.trim().length() < 4 || movieCategory.trim().length() > 1000) {
            request.setAttribute("movie", movie);
            request.setAttribute("error", "Thể loại không được để trống và giới hạn 4-1000 ký tự!!!");
            request.getRequestDispatcher("view/AdminEditMovie.jsp").forward(request, response);
        } else if (description.length() < 4 || description.length() > 4000) {
            request.setAttribute("movie", movie);
            request.setAttribute("error", "Nội dung phim không được để trống và giới hạn 4-4000 ký tự!!!");
            request.getRequestDispatcher("view/AdminEditMovie.jsp").forward(request, response);
        } else if (movieLanguage.trim().length() < 4 || movieLanguage.trim().length() > 800) {
            request.setAttribute("movie", movie);
            request.setAttribute("error", "Ngôn ngữ không được để trống và giới hạn 4-800 ký tự!!!");
            request.getRequestDispatcher("view/AdminEditMovie.jsp").forward(request, response);
        } else if (movieRated.trim().length() < 4 || movieRated.trim().length() > 1000) {
            request.setAttribute("movie", movie);
            request.setAttribute("error", "Rated không được để trống và giới hạn 4-1000 ký tự!!! ");
            request.getRequestDispatcher("view/AdminEditMovie.jsp").forward(request, response);
        } else if ((Integer.parseInt(movieDuration) > 500)) {
            request.setAttribute("movie", movie);
            request.setAttribute("error", "Thời lượng phải là số và nhỏ hơn 500!");
            request.getRequestDispatcher("view/AdminEditMovie.jsp").forward(request, response);
        } else if (premiere.after(endDate)) {
            request.setAttribute("movie", movie);
            request.setAttribute("error", "Ngày dừng chiếu phải sau ngày khởi chiếu!");
            request.getRequestDispatcher("view/AdminEditMovie.jsp").forward(request, response);
        } else {
            //folder chứa ảnh ko tồn tại thì tạo mới
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            if (filename.trim().length() > 1) { //truyền lên ảnh
                if (ImgOldDB.length > 1) {
                    if (Files.exists(path)) { //check có tồn tại file ảnh, có thì xóa
                        Files.delete(path);
                    }
                    if (Files.exists(path2)) { //check có tồn tại file ảnh, có thì xóa
                        Files.delete(path2);
                    }
                }
                FileOutputStream outputStream = new FileOutputStream(uploadPath
                        + File.separator + fileName);
                FileOutputStream outputStream2 = new FileOutputStream(newd[0] + File.separator + "web"
                        + File.separator + "image" + File.separator + "movie" + File.separator + fileName);
                int read = 0;
                final byte[] bytes = new byte[1024];
                while ((read = inputStream.read(bytes)) != -1) {
                    outputStream.write(bytes, 0, read);
                }
                read = 0;
                while ((read = inputStream2.read(bytes)) != -1) {
                    outputStream2.write(bytes, 0, read);
                }
            }

            db.editMovie(movie);
            Movie m = db.getMovieById(movieId);// lay ra movie update
            request.setAttribute("movie", m);
            request.setAttribute("mess", "Cập nhật thành công");
            request.getRequestDispatcher("view/AdminEditMovie.jsp").forward(request, response);
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
