/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.MovieDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Movie;

/**
 *
 * @author Quan
 */
public class AdminMovieList extends HttpServlet {

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
        int pageSize=5; //số lượng phim trong 1 trang
        int page=1;
        MovieDAO m = new MovieDAO();
        String pageRequest=request.getParameter("page");
        if(pageRequest!=null){
            page=Integer.parseInt(pageRequest);
        }
        
        
        int totalMovie= m.getTotalMovie();// tính tổng số lượng phim
        int totalPage=totalMovie/pageSize;    //tính tổng số trang
        
        if(totalMovie % pageSize!=0){
            totalPage=totalPage+1;    // nếu chia dư thì cộng số trang lên 1
        }
        
        
        ArrayList<Movie> listMovie=m.getMovieWithPagging(page,pageSize);
        for (Movie movie : listMovie) {
            if (movie.getDescription().length() > 250) {
                String s=movie.getDescription().substring(0, 250)+"...";
                movie.setDescription(s);
            }
        }
        request.setAttribute("page", page);
        request.setAttribute("totalpage", totalPage);   
        request.setAttribute("listmovie", listMovie);
        
        request.getRequestDispatcher("view/AdminMovieList.jsp").forward(request, response);
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
