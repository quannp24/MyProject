package org.apache.jsp.view;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class Page403_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("\n");
      out.write("<html lang =\"en\">\n");
      out.write("    <head>\n");
      out.write("        <meta charset=\"utf-8\">\n");
      out.write("        <title>Lỗi 403 - BM</title>\n");
      out.write("        <!-- Favicon-->\n");
      out.write("        <link rel=\"icon\" type=\"image/x-icon\" href=\"img/d.png\" />\n");
      out.write("        <!--<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css\">-->\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/403/style.css\">\n");
      out.write("\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <!-- partial:index.partial.html -->\n");
      out.write("        <div class=\"wrapper\">\n");
      out.write("\n");
      out.write("            <h1>403-CẤM</h1>\n");
      out.write("\n");
      out.write("            <p>Hãy luyện tập thêm để đủ năng lực vào đây!</p>\n");
      out.write("\n");
      out.write("            <svg class=\"grid-lines\"\n");
      out.write("                 viewbox=\"0 0 100 150\"\n");
      out.write("                 preserveAspectRatio=\"xMidYMid slice\"\n");
      out.write("                 height=\"150\" width=\"100\">\n");
      out.write("\n");
      out.write("            <path class=\"grid-lines__line grid-lines__line--hor\" d=\"m0,39 l100,0\" />\n");
      out.write("            <path class=\"grid-lines__line grid-lines__line--hor\" d=\"m0,75 l100,0\" />\n");
      out.write("            <path class=\"grid-lines__line grid-lines__line--hor\" d=\"m0,111 l100,0\" />\n");
      out.write("            <path class=\"grid-lines__line grid-lines__line--ver\" d=\"m14,0 l0,150\" />\n");
      out.write("            <path class=\"grid-lines__line grid-lines__line--ver\" d=\"m32,0 l0,150\" />\n");
      out.write("            <path class=\"grid-lines__line grid-lines__line--ver\" d=\"m50,0 l0,150\" />\n");
      out.write("            <path class=\"grid-lines__line grid-lines__line--ver\" d=\"m68,0 l0,150\" />\n");
      out.write("            <path class=\"grid-lines__line grid-lines__line--ver\" d=\"m86,0 l0,150\" />\n");
      out.write("            <path class=\"grid-lines__line grid-lines__line--diag\" d=\"m14,0 l72,150\" />\n");
      out.write("            <path class=\"grid-lines__line grid-lines__line--diag\" d=\"m0,25 l100,100\" />\n");
      out.write("            <path class=\"grid-lines__line grid-lines__line--diag\" d=\"m100,25 l-100,100\" />\n");
      out.write("            <path class=\"grid-lines__line grid-lines__line--diag\" d=\"m86,0 l-72,150\" />\n");
      out.write("            <path class=\"grid-lines__line grid-lines__line--cir\"\n");
      out.write("                  d=\"m50,57 c18,0 18,18 18,18\n");
      out.write("                  c0,18 -18,18 -18,18\n");
      out.write("                  c-18,0 -18,-18 -18,-18\n");
      out.write("                  c0,-18 18,-18 18,-18\" />\n");
      out.write("            <path class=\"grid-lines__line grid-lines__line--cir\"\n");
      out.write("                  d=\"m50,39 c36,0 36,36 36,36\n");
      out.write("                  c0,36 -36,36 -36,36\n");
      out.write("                  c-36,0 -36,-36 -36,-36\n");
      out.write("                  c0,-36 36,-36 36,-36\" />\n");
      out.write("            <path class=\"grid-lines__line grid-lines__line--cir\"\n");
      out.write("                  d=\"m50,21 c54,0 54,54 54,54\n");
      out.write("                  c0,54 -54,54 -54,54\n");
      out.write("                  c-54,0 -54,-54 -54,-54\n");
      out.write("                  c0,-54 54,-54 54,-54\" />\n");
      out.write("\n");
      out.write("\n");
      out.write("            <path class=\"wiz wiz--hair-bg\"\n");
      out.write("                  d=\"m50,48\n");
      out.write("                  c0,0 6,0 6,2\n");
      out.write("                  c0,0 0,3 2,3\n");
      out.write("                  c0,0 2,0 2,4\n");
      out.write("                  c0,0 2,0 2,4\n");
      out.write("                  c0,0 3,0 3,6\n");
      out.write("                  c0,0 2,4 -2,6\n");
      out.write("                  c0,0 -2,4 -2,6\n");
      out.write("                  c0,0 0,6 -3,6\n");
      out.write("                  c0,0 0,0 -8,0\n");
      out.write("                  c0,0 0,0, -8,0\n");
      out.write("                  c0,0 -3,0 -3,-6\n");
      out.write("                  c0,0 -2,-4 -2,-6\n");
      out.write("                  c0,0 -4,-2 -2,-6\n");
      out.write("                  c0,0 0,-6 3,-6\n");
      out.write("                  c0,0 0,-4 2,-4\n");
      out.write("                  c0,0 0,-4 2,-4\n");
      out.write("                  c0,0 2,0 2,-3\n");
      out.write("                  c0,0 6,0 6,-2\" />\n");
      out.write("\n");
      out.write("            <path class=\"wiz wiz--head\"\n");
      out.write("                  d=\"m50,50\n");
      out.write("                  c0,0 8,0 8,10\n");
      out.write("                  c0,0 0,10 -8,10\n");
      out.write("                  c0,0 -8,0 -8,-10\n");
      out.write("                  c0,0 0,-10 8,-10\" />\n");
      out.write("\n");
      out.write("            <path class=\"wiz wiz--hair\"\n");
      out.write("                  d=\"m50,48\n");
      out.write("                  c0,0 6,0 6,2\n");
      out.write("                  c0,0 0,3 2,3\n");
      out.write("                  c0,0 2,0 2,4\n");
      out.write("                  c0,0 2,0 2,4\n");
      out.write("                  c0,0 3,0 3,6\n");
      out.write("                  c0,0 2,4 -2,6\n");
      out.write("                  c0,0 -2,4 -2,6\n");
      out.write("                  c0,0 0,6 -3,6\n");
      out.write("                  c0,0 0,0 -8,0\n");
      out.write("                  c0,0 6,0 6,-2\n");
      out.write("                  c0,0 4,0 2,-4\n");
      out.write("                  c0,0 4,0 2,-4\n");
      out.write("                  c0,0 -2,-2 2,-6\n");
      out.write("                  c0,0 2,-4 -2,-6\n");
      out.write("                  c0,0 -4,0 -4,-4\n");
      out.write("                  c0,0 0,-4 -2,-4\n");
      out.write("                  c0,0 0,-6 -4,-3\" />\n");
      out.write("\n");
      out.write("\n");
      out.write("            <path class=\"wiz wiz--hair\"\n");
      out.write("                  d=\"m50,52\n");
      out.write("                  c0,0 -6,-4 -6,4\n");
      out.write("                  c0,0 0,4 -2,4\n");
      out.write("                  c0,0 0,4 -2,4\n");
      out.write("                  c0,0 -2,0 0,4\n");
      out.write("                  c0,0 0,2 0,4\n");
      out.write("                  c0,0 2,2 0,4\n");
      out.write("                  c0,0 -2,4 4,3\n");
      out.write("                  c0,0 -2,4 2,4\n");
      out.write("                  c0,0 0,2 4,2\n");
      out.write("                  c0,0 0,0, -8,0\n");
      out.write("                  c0,0 -3,0 -3,-6\n");
      out.write("                  c0,0 -2,-4 -2,-6\n");
      out.write("                  c0,0 -4,-2 -2,-6\n");
      out.write("                  c0,0 0,-6 3,-6\n");
      out.write("                  c0,0 0,-4 2,-4\n");
      out.write("                  c0,0 0,-4 2,-4\n");
      out.write("                  c0,0 -1,0 0,-4\n");
      out.write("                  c0,0 2,1 8,-1\" />\n");
      out.write("\n");
      out.write("            <path class=\"wiz wiz--beard\"\n");
      out.write("                  d=\"m50,69\n");
      out.write("                  c0,0 5,0 5,-1\n");
      out.write("                  c0,0 4,0 4,2\n");
      out.write("                  c0,0 2,0 1,4\n");
      out.write("                  c0,0 2,0 1,6\n");
      out.write("                  c0,0 2,0 1,6\n");
      out.write("                  c0,0 -2,4 -2,4\n");
      out.write("                  c0,0 -2,4 0,6\n");
      out.write("                  c0,0 -4,0 -4,-4\n");
      out.write("                  c0,0 0,4 -2,4\n");
      out.write("                  c0,0 0,2 -2,2\n");
      out.write("                  c0,0 -4,0 -4,4\n");
      out.write("                  c0,0 -4,0 -2,-6\n");
      out.write("                  c0,0 -2,4 -6,4\n");
      out.write("                  c0,0 4,-2 2,-6\n");
      out.write("                  c0,0 -4,0 -4,-4\n");
      out.write("                  c0,0 -4,0 -4,-4\n");
      out.write("                  c0,0 4,4 4,-4\n");
      out.write("                  c0,0 0,-6 2,-6\n");
      out.write("                  c0,0 0,-4 2,-4\n");
      out.write("                  c0,0 0,-4 2,-4\n");
      out.write("                  c0,0 0,1 6,1\" />\n");
      out.write("\n");
      out.write("            <path class=\"wiz wiz--mouth\"\n");
      out.write("                  d=\"m50,65\n");
      out.write("                  c0,0 5,0 5,3\n");
      out.write("                  c0,0 0,2 -5,2\n");
      out.write("                  c0,0 -5,0 -5,-2\n");
      out.write("                  c0,0 0,-4 5,-3\" />\n");
      out.write("\n");
      out.write("            <path class=\"wiz wiz--mustache\"\n");
      out.write("                  d=\"m50,64\n");
      out.write("                  c0,0 4,0 4,1\n");
      out.write("                  c0,0 2,0 2,2\n");
      out.write("                  c0,0 2,0 1,3\n");
      out.write("                  c0,0 2,0 0,3\n");
      out.write("                  c0,0 0,0 0,0\n");
      out.write("                  c0,0 0,-2 -2,-2\n");
      out.write("                  c0,0 1,-3 -1,-3\n");
      out.write("                  c0,0 0,-1 -4,-2\n");
      out.write("                  c0,0 -4,-2 -4,2\n");
      out.write("                  c0,0 -1,0 -1,2\n");
      out.write("                  c0,0 -2,0 -1,3\n");
      out.write("                  c0,0 -4,-2 -1,-4\n");
      out.write("                  c0,0 -2,-3 1,-3\n");
      out.write("                  c0,0 -1,-5 6,-2\" />\n");
      out.write("\n");
      out.write("            <path class=\"wiz wiz--eye wiz--left\"\n");
      out.write("                  d=\"m45,60\n");
      out.write("                  c0,0 2,0 2,1\n");
      out.write("                  c0,0 0,1 -2,0\n");
      out.write("                  c0,0 -1,0 0,-1\" />\n");
      out.write("\n");
      out.write("            <path class=\"wiz wiz--eye wiz--right\"\n");
      out.write("                  d=\"m52,60\n");
      out.write("                  c0,0 1,-1 2,0\n");
      out.write("                  c0,0 0,1 -2,1\n");
      out.write("                  c0,0 -1,0 0,-1\" />\n");
      out.write("\n");
      out.write("            <path class=\"wiz wiz--eye-brow wiz--left\"\n");
      out.write("                  d=\"m42,61\n");
      out.write("                  c0,0 0,-3 1,-3\n");
      out.write("                  c0,0 3,0 4,2\n");
      out.write("                  c0,0 -1,-1 -4,-1\n");
      out.write("                  c0,0 -1,0 -1,2\" />\n");
      out.write("\n");
      out.write("            <path class=\"wiz wiz--eye-brow wiz--right\"\n");
      out.write("                  d=\"m51,60\n");
      out.write("                  c0,0 2,-3 4,-3\n");
      out.write("                  c0,0 2,0 2,3\n");
      out.write("                  c0,0 -1,-2 -2,-2\n");
      out.write("                  c0,0 -2,0 -4,2\" />\n");
      out.write("\n");
      out.write("            <path class=\"wiz wiz--sword\"\n");
      out.write("                  d=\"m50,30\n");
      out.write("                  c0,0 2,2 2,6\n");
      out.write("                  l0,50\n");
      out.write("                  l6,0\n");
      out.write("                  c0,0 2,0 2,-2\n");
      out.write("                  l1,0\n");
      out.write("                  c0,0 0,4 -4,4\n");
      out.write("                  l-6,0\n");
      out.write("                  l0,14\n");
      out.write("                  c0,0 2,0 2,2\n");
      out.write("                  c0,0 0,2 -4,2\n");
      out.write("                  c0,0 -3,0 -4,-2\n");
      out.write("                  c0,0 0,-2 2,-2\n");
      out.write("                  l0,-14\n");
      out.write("                  l-6,0\n");
      out.write("                  c0,0 -4,0 -4,-4\n");
      out.write("                  l1,0\n");
      out.write("                  c0,0 0,2 2,2\n");
      out.write("                  l6,0\n");
      out.write("                  l0,-50\n");
      out.write("                  c0,0 0,-3 2,-6\n");
      out.write("                  z\" />\n");
      out.write("\n");
      out.write("            <path class=\"wiz wiz--staff\"\n");
      out.write("                  d=\"m46,30\n");
      out.write("                  l2,0\n");
      out.write("                  c0,0 1,0 1,1\n");
      out.write("                  l0,2\n");
      out.write("                  c0,0 2,0 2,-2\n");
      out.write("                  l1,0\n");
      out.write("                  c0,0 1,0 1,2\n");
      out.write("                  c0,0 2,0 2,-2\n");
      out.write("                  l2,0\n");
      out.write("                  c0,0 0,4 -2,4\n");
      out.write("                  c0,0 0,4 -2,4\n");
      out.write("                  c0,0 0,2 -1,2\n");
      out.write("                  l0,40\n");
      out.write("                  c0,0 0,4 -1,4\n");
      out.write("                  l0,40\n");
      out.write("                  c0,0 0,4 -1,4\n");
      out.write("                  c0,0 -1,0 -1,-4\n");
      out.write("                  c0,0 -2,0 -2,-4\n");
      out.write("                  l0,-60\n");
      out.write("                  c0,0 -1,0 -1,-4\n");
      out.write("                  l0,-20\n");
      out.write("                  c0,0 -1,0 -1,-4\n");
      out.write("                  c0,0 0,-3 1,-3\" />\n");
      out.write("\n");
      out.write("\n");
      out.write("            </svg>\n");
      out.write("\n");
      out.write("        </div>\n");
      out.write("        <!-- partial -->\n");
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}