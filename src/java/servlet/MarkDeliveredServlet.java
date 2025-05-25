/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;



import dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "MarkDeliveredServlet", urlPatterns = {"/MarkDeliveredServlet"})
public class MarkDeliveredServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");

        if (orderIdStr != null) {
            int orderId = Integer.parseInt(orderIdStr);

            try {
                Connection conn = DBConnection.getConnection();
                String sql = "UPDATE orders SET order_status = 'Delivered' WHERE id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, orderId);

                int updated = stmt.executeUpdate();

                stmt.close();
                conn.close();

                if (updated > 0) {
                    // Redirect back to waiter dashboard or confirmation
                    response.sendRedirect("waiter/waiter_Dashboard.jsp");
                } else {
                    response.getWriter().println("Failed to update order.");
                }

            } catch (Exception e) {
                System.out.println("MarkDeliverd servlet is failed:");
                e.printStackTrace();
                response.getWriter().println("Database error: " + e.getMessage());
            }
        } else {
            response.getWriter().println("Invalid order ID.");
        }
    }
}
