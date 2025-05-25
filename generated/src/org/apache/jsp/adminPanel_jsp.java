package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import dao.DBConnection;
import Order.Order;
import java.sql.*;

public final class adminPanel_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("\n");

    List<Order> orders = new ArrayList<>();

    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT id, username, mobile, table_no, food_items, order_status FROM orders ORDER BY order_time DESC");
        ResultSet rs = ps.executeQuery();

        while(rs.next()) {
            int id = rs.getInt("id");
            String username = rs.getString("username");
            String mobile = rs.getString("mobile");
            String tableNo = rs.getString("table_no");
            String foodItems = rs.getString("food_items");
            String orderStatus = rs.getString("order_status");

            // Convert item IDs to names
            List<String> itemNames = new ArrayList<>();
            String[] ids = foodItems.split(",");

            if (ids.length > 0) {
              StringBuilder sql = new StringBuilder("SELECT name FROM menu_items WHERE id IN (");
for (int i = 0; i < ids.length; i++) {
    sql.append("?,");
}
sql.setLength(sql.length() - 1); // remove last comma
sql.append(")");

                PreparedStatement itemStmt = con.prepareStatement(sql.toString());
                for (int i = 0; i < ids.length; i++) {
                    itemStmt.setInt(i + 1, Integer.parseInt(ids[i]));
                }

                ResultSet itemsRs = itemStmt.executeQuery();
                while (itemsRs.next()) {
                    itemNames.add(itemsRs.getString("name"));
                }
                itemsRs.close();
                itemStmt.close();
            }

            orders.add(new Order(id, username, mobile, tableNo, String.join(", ", itemNames), orderStatus));
        }
        rs.close();
        ps.close();
        con.close();

    } catch(Exception e) {
        e.printStackTrace();
    }

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <title>Admin Panel - Order Status</title>\n");
      out.write("    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("</head>\n");
      out.write("<body class=\"bg-light\">\n");
      out.write("<div class=\"container mt-5\">\n");
      out.write("    <h2 class=\"text-center\">Admin Panel - Order Status</h2>\n");
      out.write("\n");
      out.write("    <div class=\"table-responsive mt-4\">\n");
      out.write("        <table class=\"table table-bordered\">\n");
      out.write("            <thead>\n");
      out.write("                <tr>\n");
      out.write("                    <th>ID</th>\n");
      out.write("                    <th>Username</th>\n");
      out.write("                    <th>Mobile No</th>\n");
      out.write("                    <th>Table No</th>\n");
      out.write("                    <th>Food Items</th>\n");
      out.write("                    <th>Order Status</th>\n");
      out.write("                    <th>Update Status</th>\n");
      out.write("                </tr>\n");
      out.write("            </thead>\n");
      out.write("            <tbody>\n");
      out.write("                ");
 for (Order order : orders) { 
      out.write("\n");
      out.write("                <tr>\n");
      out.write("                    <td>");
      out.print( order.getId() );
      out.write("</td>\n");
      out.write("                    <td>");
      out.print( order.getUsername() );
      out.write("</td>\n");
      out.write("                    <td>");
      out.print( order.getMobile() );
      out.write("</td> <!-- This now holds mobile number -->\n");
      out.write("                    <td>");
      out.print( order.getTableNo() );
      out.write("</td>\n");
      out.write("                    <td>");
      out.print( order.getFoodItems() );
      out.write("</td>\n");
      out.write("                    <td>");
      out.print( order.getOrderStatus() );
      out.write("</td>\n");
      out.write("                    <td>\n");
      out.write("                        <form action=\"updateOrderStatus.jsp\" method=\"post\">\n");
      out.write("                            <input type=\"hidden\" name=\"orderId\" value=\"");
      out.print( order.getId() );
      out.write("\">\n");
      out.write("                            <select name=\"status\" class=\"form-select\">\n");
      out.write("                                <option value=\"Preparing\" ");
      out.print( "Preparing".equals(order.getOrderStatus()) ? "selected" : "" );
      out.write(">Preparing</option>\n");
      out.write("                                <option value=\"Ready\" ");
      out.print( "Ready".equals(order.getOrderStatus()) ? "selected" : "" );
      out.write(">Ready</option>\n");
      out.write("                                <option value=\"Delivered\" ");
      out.print( "Delivered".equals(order.getOrderStatus()) ? "selected" : "" );
      out.write(">Delivered</option>\n");
      out.write("                            </select>\n");
      out.write("                            <button type=\"submit\" class=\"btn btn-success mt-2\">Update</button>\n");
      out.write("                        </form>\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("                ");
 } 
      out.write("\n");
      out.write("            </tbody>\n");
      out.write("        </table>\n");
      out.write("    </div>\n");
      out.write("</div>\n");
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
