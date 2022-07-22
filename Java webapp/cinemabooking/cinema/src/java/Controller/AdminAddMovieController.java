/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.MovieDAO;
import Validation.ValidateMovie;
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
import model.Movie;

/**
 *
 * @author Quan
 */
@MultipartConfig
public class AdminAddMovieController extends HttpServlet {

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
        request.getRequestDispatcher("view/AdminAddMovie.jsp").forward(request, response);
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
        MovieDAO movieDAO = new MovieDAO();

        //lấy ra các dữ liệu từ request 
        String movieName = request.getParameter("movieName").trim();
        Part part = request.getPart("movieImage");  //lấy file ảnh truyền vào
        String realPath = "C:/Users/Quan/FU/SWP/cinemabooking/cinema/web/image/movie";  //truyền đường dẫn folder chứa ảnh
        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();  //

        String movieCategory = request.getParameter("movieCategory").trim();
        String description = request.getParameter("movieDescription").trim();
        String language = request.getParameter("language").trim();
        String rated = request.getParameter("rated").trim();
        String movieDuration = request.getParameter("movieDuration").trim();
        int duration = Integer.parseInt(movieDuration);
        String moviePremiere = request.getParameter("startdate").trim();
        Date startdate = Date.valueOf(moviePremiere);//ep kieu du lieu cho date
        String raw_enddate = request.getParameter("enddate") == null ? "" : request.getParameter("enddate");
        Date endDate = null;
        if (raw_enddate != null && raw_enddate.trim().length() > 0) {
            endDate = Date.valueOf(raw_enddate);
        }

        Movie movie = new Movie(0, movieName, movieCategory, startdate, duration, language, rated, description, "image/movie/" + filename, endDate);

        if (movieName.trim().length() < 4 || movieName.trim().length() > 3000) {
            request.setAttribute("movie", movie);
            request.setAttribute("error", "Tên phim không được để trống và giới hạn 4-3000 ký tự!!!");
            request.getRequestDispatcher("view/AdminAddMovie.jsp").forward(request, response);
        } else if (movieCategory.trim().length()<4 || movieCategory.trim().length()>1000) {
            request.setAttribute("movie", movie);
            request.setAttribute("error", "Thể loại không được để trống và giới hạn 4-1000 ký tự!!!");
            request.getRequestDispatcher("view/AdminAddMovie.jsp").forward(request, response);
        } else if (description.trim().length() < 4 || description.trim().length() > 4000) {
            request.setAttribute("movie", movie);
            request.setAttribute("error", "Miêu tả nội dung không được để trống và giới hạn 4-4000 ký tự!!!");
            request.getRequestDispatcher("view/AdminAddMovie.jsp").forward(request, response);
        } else if (language.trim().length()<4 || language.trim().length()>800) {
            request.setAttribute("movie", movie);
            request.setAttribute("error", "Ngôn ngữ không được để trống và giới hạn 4-800 ký tự!!! ");
            request.getRequestDispatcher("view/AdminAddMovie.jsp").forward(request, response);
        } else if (rated.trim().length()<4 || rated.trim().length()>1000) {
            request.setAttribute("movie", movie);
            request.setAttribute("error", "Rated không được để trống và giới hạn 4-1000 ký tự!!! ");
            request.getRequestDispatcher("view/AdminAddMovie.jsp").forward(request, response);
        } else if ((Integer.parseInt(movieDuration) > 500)) {
            request.setAttribute("movie", movie);
            request.setAttribute("error", "Thời lượng phải là số và nhỏ hơn 500!");
            request.getRequestDispatcher("view/AdminAddMovie.jsp").forward(request, response);
        } else if (startdate.after(endDate)) {
            request.setAttribute("movie", movie);
            request.setAttribute("error", "Ngày dừng chiếu phải sau ngày khởi chiếu!");
            request.getRequestDispatcher("view/AdminAddMovie.jsp").forward(request, response);
        } else {
            //folder chứa ảnh ko tồn tại thì tạo mới

            if (!Files.exists(Paths.get(realPath))) {
                Files.createDirectory(Paths.get(realPath));
            }
            part.write(realPath + "/" + filename);  //in ảnh vào folder
            movieDAO.addMovie(movie);
            request.setAttribute("mess", "Thêm phim thành công!!");
            request.getRequestDispatcher("view/AdminAddMovie.jsp").forward(request, response);
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
