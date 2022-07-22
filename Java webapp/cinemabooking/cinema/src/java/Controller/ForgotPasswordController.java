/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AccountDAO;
import jakarta.mail.Transport;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.security.SecureRandom;
import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.activation.DataHandler;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;

/**
 *
 * @author cloudy_place
 */
public class ForgotPasswordController extends HttpServlet {

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
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public String generateRandomVerify() {
        // ASCII range – alphanumeric (0-9, a-z, A-Z)
        final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder();

        // each iteration of the loop randomly chooses a character from the given
        // ASCII range and appends it to the `StringBuilder` instance
        for (int i = 0; i < 6; i++) {
            int randomIndex = random.nextInt(chars.length());
            sb.append(chars.charAt(randomIndex));
        }

        return sb.toString();
    }

//    public static void main(String[] args) {
//        System.out.println(new ForgotPasswordController().generateRandomVerify());
//    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/ForgotPassword.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");

        try {
            String email = request.getParameter("email");
            System.out.println(email);
            AccountDAO accountDAO = new AccountDAO();
            String existEmail = accountDAO.getExistEmail(email);
            if (existEmail == null) {
                request.setAttribute("mess", "Your email not exist");
                request.getRequestDispatcher("view/ForgotPassword.jsp").forward(request, response);
            } else {
                try  {
                    Properties properties = new Properties();
                    properties.put("mail.smtp.host", "smtp.gmail.com");
                    properties.put("mail.smtp.port", "587");
                    properties.put("mail.smtp.auth", "true");
                    properties.put("mail.smtp.starttls.enable", "true");
                    properties.put("mail.smtp.ssl.trust", "*");

                    Session session = Session.getInstance(properties, new Authenticator() {
                        @Override
                        protected PasswordAuthentication getPasswordAuthentication() {
                            String username = "gopvui123@gmail.com";
                            String password = "titatiton2561";
                            return new PasswordAuthentication(username, password);
                        }
                    });

                    Message message = new MimeMessage(session);
                    message.setFrom(new InternetAddress("gopvui123@gmail.com"));
                    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(existEmail));
                    message.setSubject("Reset password");
                    String verify = generateRandomVerify();
                    message.setText("Ma xac nhan: " + verify);
//            message.setReplyTo(message.getFrom("));
//                    request.setAttribute("messSuccess", "Check email");
                    HttpSession ss = request.getSession();
                    ss.setAttribute("verify", verify);
                    ss.setAttribute("existEmail", existEmail);
                    ss.setMaxInactiveInterval(10 * 60);
                    Transport.send(message);
                    request.getRequestDispatcher("view/CheckVerify.jsp").forward(request, response);

                } catch (Exception e) {
                    Logger.getLogger(ForgotPasswordController.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        } catch (Exception e) {
            Logger.getLogger(ForgotPasswordController.class.getName()).log(Level.SEVERE, null, e);
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
