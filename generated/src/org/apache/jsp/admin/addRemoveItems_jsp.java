package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import dao.DBConnection;

public final class addRemoveItems_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("\n");

    if(session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))){
        response.sendRedirect("../index.jsp");
    }

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <title>Manage Menu</title>\n");
      out.write("    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("</head>\n");
      out.write("<body class=\"bg-light\">\n");
      out.write("<div class=\"container mt-5\">\n");
      out.write("    <h2>Manage Menu Items</h2>\n");
      out.write("\n");
      out.write("    ");
 String msg = (String) session.getAttribute("menuMessage");
       if (msg != null) { 
      out.write("\n");
      out.write("        <div class=\"alert alert-info alert-dismissible fade show\" role=\"alert\">\n");
      out.write("            ");
      out.print( msg );
      out.write("\n");
      out.write("            <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\"></button>\n");
      out.write("        </div>\n");
      out.write("        ");

            session.removeAttribute("menuMessage");
       }
    
      out.write("\n");
      out.write("\n");
      out.write("    <form action=\"../MenuItemServlet\" method=\"post\" class=\"mb-4\">\n");
      out.write("        <input type=\"hidden\" name=\"action\" value=\"add\" />\n");
      out.write("        <div class=\"mb-3\">\n");
      out.write("            <label>Food Name</label>\n");
      out.write("            <input type=\"text\" name=\"name\" class=\"form-control\" required />\n");
      out.write("        </div>\n");
      out.write("        <div class=\"mb-3\">\n");
      out.write("            <label>Description</label>\n");
      out.write("            <textarea name=\"description\" class=\"form-control\" required></textarea>\n");
      out.write("        </div>\n");
      out.write("        <div class=\"mb-3\">\n");
      out.write("            <label>Price</label>\n");
      out.write("            <input type=\"number\" name=\"price\" step=\"0.01\" class=\"form-control\" required />\n");
      out.write("        </div>\n");
      out.write("        <div class=\"mb-3\">\n");
      out.write("            <label>Image URL</label>\n");
      out.write("            <input type=\"text\" name=\"image\" class=\"form-control\" required placeholder=\"/example.com/image.jpg\" />\n");
      out.write("        </div>\n");
      out.write("        <div class=\"mb-3\">\n");
      out.write("            <label>Food Category</label>\n");
      out.write("            <select name=\"category\" class=\"form-control\" required>\n");
      out.write("                <option value=\"\">Select Category</option>\n");
      out.write("                <option value=\"Soft Drink\">Soft Drink</option>\n");
      out.write("                <option value=\"Fast Food\">Fast Food</option>\n");
      out.write("                <option value=\"Thali\">Thali</option>\n");
      out.write("                <option value=\"Nasta\">Nasta</option>\n");
      out.write("                <option value=\"Ice-Cream\">Ice-Cream</option>\n");
      out.write("                <option value=\"Maggie\">Maggie</option>\n");
      out.write("                <option value=\"South Indian\">South Indian</option>\n");
      out.write("            </select>\n");
      out.write("        </div>\n");
      out.write("        <button type=\"submit\" class=\"btn btn-success\">Add Item</button>\n");
      out.write("    </form>\n");
      out.write("\n");
      out.write("    <h4>Current Menu Items</h4>\n");
      out.write("    <table class=\"table table-bordered\">\n");
      out.write("        <thead>\n");
      out.write("            <tr>\n");
      out.write("                <th>Food Name</th>\n");
      out.write("                <th>Description</th>\n");
      out.write("                <th>Price (₹)</th>\n");
      out.write("                <th>Category</th>\n");
      out.write("<!--                <th>Image</th>-->\n");
      out.write("                <th>Action</th>\n");
      out.write("            </tr>\n");
      out.write("        </thead>\n");
      out.write("        <tbody>\n");
      out.write("        ");

            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement("SELECT * FROM menu_items");
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
        
      out.write("\n");
      out.write("            <tr>\n");
      out.write("                <td>");
      out.print( rs.getString("name") );
      out.write("</td>\n");
      out.write("                <td>");
      out.print( rs.getString("description") );
      out.write("</td>\n");
      out.write("                <td>");
      out.print( rs.getDouble("price") );
      out.write("</td>\n");
      out.write("                <td>");
      out.print( rs.getString("TYPE_OF_FOOD") );
      out.write("</td>\n");
      out.write("                ");
      out.write("\n");
      out.write("                <td>\n");
      out.write("                    <form action=\"../MenuItemServlet\" method=\"post\" style=\"display:inline;\">\n");
      out.write("                        <input type=\"hidden\" name=\"action\" value=\"remove\">\n");
      out.write("                        <input type=\"hidden\" name=\"id\" value=\"");
      out.print( rs.getInt("id") );
      out.write("\">\n");
      out.write("                        <button type=\"submit\" class=\"btn btn-danger btn-sm\"\n");
      out.write("                                onclick=\"return confirm('Are you sure you want to delete this item?');\">\n");
      out.write("                            Delete\n");
      out.write("                        </button>\n");
      out.write("                    </form>\n");
      out.write("                </td>\n");
      out.write("            </tr>\n");
      out.write("        ");

                }
            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error loading menu: " + e.getMessage() + "</td></tr>");
            }
        
      out.write("\n");
      out.write("        </tbody>\n");
      out.write("    </table>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\n");
      out.write("</body>\n");
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
