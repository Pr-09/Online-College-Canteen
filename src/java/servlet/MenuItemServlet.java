//package servlet;
//
//import dao.DBConnection;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//
//@WebServlet(name = "MenuItemServlet", urlPatterns = {"/MenuItemServlet"})
//public class MenuItemServlet extends HttpServlet {
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession();
//        String action = request.getParameter("action");
//
//        try (Connection conn = DBConnection.getConnection()) {
//
//            if ("remove".equalsIgnoreCase(action)) {
//                int id = Integer.parseInt(request.getParameter("id"));
//                try (PreparedStatement ps = conn.prepareStatement("DELETE FROM menu_items WHERE id = ?")) {
//                    ps.setInt(1, id);
//                    ps.executeUpdate();
//                    session.setAttribute("menuMessage", "Item removed successfully.");
//                }
//
//            } else if ("add".equalsIgnoreCase(action)) {
//                String name = request.getParameter("name");
//                String description = request.getParameter("description");
//                double price = Double.parseDouble(request.getParameter("price"));
//
//                try (PreparedStatement ps = conn.prepareStatement(
//                        "INSERT INTO menu_items (name, description, price) VALUES (?, ?, ?)")) {
//                    ps.setString(1, name);
//                    ps.setString(2, description);
//                    ps.setDouble(3, price);
//                    ps.executeUpdate();
//                    session.setAttribute("menuMessage", "Item added successfully.");
//                }
//
//            }
//
//        } catch (Exception e) {
//            session.setAttribute("menuMessage", "An error occurred: " + e.getMessage());
//            e.printStackTrace();
//        }
//
//        response.sendRedirect("admin/addRemoveItems.jsp");
//    }
//}



package servlet;

import dao.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "MenuItemServlet", urlPatterns = {"/MenuItemServlet"})
public class MenuItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        try (Connection conn = DBConnection.getConnection()) {

            if ("remove".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                try (PreparedStatement ps = conn.prepareStatement("DELETE FROM menu_items WHERE id = ?")) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                    session.setAttribute("menuMessage", "Item removed successfully.");
                }

            } else if ("add".equalsIgnoreCase(action)) {
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                String image = request.getParameter("image");
                String category = request.getParameter("category");

                try (PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO menu_items (name, description, price, image_path, TYPE_OF_FOOD) VALUES (?, ?, ?, ?, ?)")) {
                    ps.setString(1, name);
                    ps.setString(2, description);
                    ps.setDouble(3, price);
                    ps.setString(4, image);
                    ps.setString(5, category);
                    ps.executeUpdate();
                    session.setAttribute("menuMessage", "Item added successfully.");
                }

            }

        } catch (Exception e) {
            session.setAttribute("menuMessage", "An error occurred: " + e.getMessage());
            e.printStackTrace();
        }

        response.sendRedirect("admin/addRemoveItems.jsp");
    }
}
