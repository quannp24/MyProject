/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.FoodAndDrinkDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.FoodAndDrink;

/**
 *
 * @author MSI
 */
@MultipartConfig
public class AdminAddFoodDrinkController extends HttpServlet {

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
        request.getRequestDispatcher("view/AddFoodAndDrink.jsp").forward(request, response);
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
        String category = request.getParameter("new_Category");
        String name = request.getParameter("new_Name");

        Part part = request.getPart("new_Img");  //lấy file ảnh truyền vào
        String realPath = "C:/Users/Quan/FU/SWP/cinemabooking/cinema/web/image/FoodAndDrink";  //truyền đường dẫn folder chứa ảnh
        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();

        float price = Float.valueOf(request.getParameter("new_Price"));

        FoodAndDrink fd = new FoodAndDrink();
        //Set value
        fd.setCategory(category);
        fd.setFadName(name);
        fd.setPrice(price);
        fd.setImage(filename);

        DAL.FoodAndDrinkDAO fadDAO = new FoodAndDrinkDAO();
        String mess = "";
        if (category.length() < 4 || category.length() > 90) {
            request.setAttribute("fd", fd);
            request.setAttribute("error", "Loại đồ ăn, uống phải có độ dài 4-90 kí tự!");
            request.getRequestDispatcher("view/AddFoodAndDrink.jsp").forward(request, response);
        } else if (name.length() < 4 || name.length() > 150) {
            request.setAttribute("fd", fd);
            request.setAttribute("error", "Tên đồ ăn, uống phải có độ dài 4-150 kí tự!");
            request.getRequestDispatcher("view/AddFoodAndDrink.jsp").forward(request, response);
        } else if (price<0) {
            request.setAttribute("fd", fd);
            request.setAttribute("error", "Giá sản phẩm không được nhỏ hơn 0!");
            request.getRequestDispatcher("view/AddFoodAndDrink.jsp").forward(request, response);
        } else {
            if (!Files.exists(Paths.get(realPath))) {
                Files.createDirectory(Paths.get(realPath));
            }
            part.write(realPath + "/" + filename);
            fadDAO.addFoodAndDrink(fd);
            request.setAttribute("fd", fd);
            request.setAttribute("mess", "Thêm đồ ăn, uống thành công!");
            request.getRequestDispatcher("view/AddFoodAndDrink.jsp").forward(request, response);
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
