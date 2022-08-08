/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.FoodAndDrinkDAO;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
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
 * @author Quan
 */
@MultipartConfig
public class AdminEditFoodController extends HttpServlet {

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
    // create object
    DAL.FoodAndDrinkDAO dao = new FoodAndDrinkDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int fid = Integer.parseInt(request.getParameter("id"));
        FoodAndDrink fad = dao.getFoodAndDrink(fid);
        //set attribute
        request.setAttribute("fd", fad);

        request.getRequestDispatcher("view/UpdateFoodAndDrink.jsp").forward(request, response);
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
        FoodAndDrink fd = new FoodAndDrink();
        int uid = Integer.parseInt(request.getParameter("new_id"));
        String category = request.getParameter("new_Category");
        String name = request.getParameter("new_Name");
        Float uPrice = Float.parseFloat(request.getParameter("new_Price"));
        Part part = request.getPart("new_Img");  //lấy file ảnh truyền vào
        String fileName
                = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        InputStream inputStream = part.getInputStream();
        InputStream inputStream2 = part.getInputStream();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "image" + File.separator + "FoodAndDrink";
        String[] newd = uploadPath.split("build");
        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();  //
        String imgDB = "";
        //lay img cũ từ database và cắt lấy phần tên ảnh cũ
        String[] ImgOldDB = dao.getImgFoodById(uid).split("/");
        //đường dẫn đến thư mục chứa ảnh cũ
        Path path = null;
        Path path2 = null;
        if (ImgOldDB.length > 1) {
            path = Paths.get(uploadPath + File.separator + ImgOldDB[2]);
            path2 = Paths.get(newd[0] + File.separator + "web"
                    + File.separator + "image" + File.separator + "FoodAndDrink" + File.separator + ImgOldDB[2]);
        }
        //nếu ko cập nhật ảnh mới thì vẫn giữ nguyên đường dẫn ảnh cũ từ database
        if (filename.trim().length() < 1) {
            if (ImgOldDB.length < 2) { //ko truyền ảnh và db cũng ko có dữ liệu trước đó
                imgDB = "";
            } else {
                imgDB = "image/FoodAndDrink/" + ImgOldDB[2]; //ko truyền ảnh nhưng có dữ liệu từ db trước đó
            }
        } else {
            imgDB = "image/FoodAndDrink/" + filename;   //có truyền ảnh
        }

        fd.setFadId(uid);
        fd.setCategory(category);
        fd.setFadName(name);
        fd.setImage(imgDB);
        fd.setPrice(uPrice);

        String mess = "";
        if (category.length() < 4 || category.length() > 90) {
            fd.setImage("image/FoodAndDrink/" + ImgOldDB[2]);
            request.setAttribute("fd", fd);
            request.setAttribute("error", "Loại đồ ăn, uống phải có độ dài 4-90 kí tự!");
            request.getRequestDispatcher("view/UpdateFoodAndDrink.jsp").forward(request, response);
        } else if (name.length() < 4 || name.length() > 150) {
            fd.setImage("image/FoodAndDrink/" + ImgOldDB[2]);
            request.setAttribute("fd", fd);
            request.setAttribute("error", "Tên đồ ăn, uống phải có độ dài 4-150 kí tự!");
            request.getRequestDispatcher("view/UpdateFoodAndDrink.jsp").forward(request, response);
        } else {
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
                        + File.separator + "image" + File.separator + "FoodAndDrink" + File.separator + fileName);
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
            dao.updateFoodAndDrink(fd);
            FoodAndDrink newfd = dao.getFoodAndDrink(uid);
            request.setAttribute("fd", newfd);
            request.setAttribute("mess", "Cập nhật thành công!");
            request.getRequestDispatcher("view/UpdateFoodAndDrink.jsp").forward(request, response);
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
