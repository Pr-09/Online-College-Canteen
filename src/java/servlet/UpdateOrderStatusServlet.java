/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;




import dao.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "UpdateOrderStatusServlet", urlPatterns = {"/UpdateOrderStatusServlet"})
public class UpdateOrderStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("newStatus");
        
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE orders SET order_status = ? WHERE id = ?");
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            int updated = ps.executeUpdate();
            
            if(updated > 0){
                response.sendRedirect("kitchen.jsp");
            } else {
                response.getWriter().println("Error updating status.");
            }
        } catch(Exception e) {
            System.out.println("Error in Update order Servlet");
            e.printStackTrace();
        }
    }
}
