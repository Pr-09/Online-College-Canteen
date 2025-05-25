package servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;
import servlet.PlaceOrderServlet.OrderLine;

@WebServlet(name = "UpdateOrderServlet", urlPatterns = {"/UpdateOrderServlet"})
public class UpdateOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<OrderLine> orderLines = (List<OrderLine>) session.getAttribute("orderLines");
        Double totalAmount = (Double) session.getAttribute("orderTotal");

        if (orderLines == null || orderLines.isEmpty()) {
            response.sendRedirect("menu.jsp?error=emptyOrder");
            return;
        }

        // Get item names to remove
        String[] removeItemNames = request.getParameterValues("removeItemIds");

        if (removeItemNames != null && removeItemNames.length > 0) {
            Set<String> removeSet = new HashSet<>(Arrays.asList(removeItemNames));
            double newTotal = 0;
            List<OrderLine> updatedLines = new ArrayList<>();

            for (OrderLine line : orderLines) {
                 System.out.println("removed item"+line.name);
                
                if (!removeSet.contains(line.name)) {
                     System.out.println("removed item"+line.name);
                      System.out.println("removed item"+line.id);
                    updatedLines.add(line);
                    newTotal += line.price;
                }
            }
          System.out.println("");
            // Update session
            session.setAttribute("orderLines", updatedLines);
            session.setAttribute("orderTotal", newTotal);
        }

        response.sendRedirect("payment.jsp");
    }
}
