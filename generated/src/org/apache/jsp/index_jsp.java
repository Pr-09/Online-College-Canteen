package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html; charset=UTF-8");
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

    if (session.getAttribute("username") != null) {
        response.sendRedirect("menu.jsp?tableNo=1"); // redirect if already logged in
        return;
    }

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("  <meta charset=\"UTF-8\" />\n");
      out.write("  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n");
      out.write("  <title>Admin Login Page</title>\n");
      out.write("  <link rel=\"stylesheet\" href=\"index.css\" />\n");
      out.write("  <link\n");
      out.write("    rel=\"stylesheet\"\n");
      out.write("    href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css\"\n");
      out.write("    integrity=\"sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==\"\n");
      out.write("    crossorigin=\"anonymous\"\n");
      out.write("    referrerpolicy=\"no-referrer\"\n");
      out.write("  />\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("<h2>Admin Login Page</h2>\n");
      out.write("<div class=\"container\" id=\"container\">\n");
      out.write("  <div class=\"form-container sign-up-container\">\n");
      out.write("    <form action=\"RegisterServlet\" method=\"post\">\n");
      out.write("      <h1>Create Account</h1>\n");
      out.write("      <div class=\"social-container\">\n");
      out.write("        <a href=\"https://www.facebook.com\" class=\"social\"><i class=\"fa-brands fa-facebook\"></i></a>\n");
      out.write("        <a href=\"https://www.google.com\" class=\"social\"><i class=\"fa-brands fa-google\"></i></a>\n");
      out.write("        <a href=\"https://www.linkedin.com\" class=\"social\"><i class=\"fa-brands fa-linkedin\"></i></a>\n");
      out.write("      </div>\n");
      out.write("      <span>or use your email for registration</span>\n");
      out.write("      <input type=\"text\" name=\"name\" placeholder=\"Name\" required />\n");
      out.write("      <input type=\"email\" name=\"email\" placeholder=\"Email\" required />\n");
      out.write("      <input type=\"password\" name=\"password\" placeholder=\"Password\" required />\n");
      out.write("      <button type=\"submit\">Sign Up</button>\n");
      out.write("    </form>\n");
      out.write("  </div>\n");
      out.write("\n");
      out.write("  <div class=\"form-container sign-in-container\">\n");
      out.write("    <form action=\"LoginServlet\" method=\"post\">\n");
      out.write("      <h1>Sign in</h1>\n");
      out.write("      <div class=\"social-container\">\n");
      out.write("        <a href=\"https://www.facebook.com/\" class=\"social\" style=\"background-image: url('fblogo.png')\">\n");
      out.write("          <i class=\"fab fa-facebook-f\"></i>\n");
      out.write("        </a>\n");
      out.write("        <a href=\"https://www.google.com\" class=\"social\" style=\"background-image: url('glogo.png')\">\n");
      out.write("          <i class=\"fab fa-google-plus-g\"></i>\n");
      out.write("        </a>\n");
      out.write("        <a href=\"https://www.linkedin.com\" class=\"social\" style=\"background-image: url('inslogo.png')\">\n");
      out.write("          <i class=\"fab fa-linkedin-in\"></i>\n");
      out.write("        </a>\n");
      out.write("      </div>\n");
      out.write("      <span>or use your account</span>\n");
      out.write("      <input type=\"text\" name=\"username\" placeholder=\"UserName\" id=\"username\" required />\n");
      out.write("      <input type=\"password\" name=\"password\" placeholder=\"Password\" id=\"password\" required />\n");
      out.write("      <a href=\"#\">Forgot your password?</a>\n");
      out.write("      <button type=\"submit\">Sign In</button>\n");
      out.write("\n");
      out.write("      ");
 String error = (String) request.getAttribute("error");
         if (error != null) { 
      out.write("\n");
      out.write("         <div class=\"error-message\" style=\"color:red; margin-top:10px;\">");
      out.print( error );
      out.write("</div>\n");
      out.write("      ");
 } 
      out.write("\n");
      out.write("    </form>\n");
      out.write("  </div>\n");
      out.write("\n");
      out.write("  <div class=\"overlay-container\">\n");
      out.write("    <div class=\"overlay\">\n");
      out.write("      <div class=\"overlay-panel overlay-left\">\n");
      out.write("        <h1>Welcome Back!</h1>\n");
      out.write("        <p>To keep connected with us please login with your personal info</p>\n");
      out.write("        <button class=\"ghost\" id=\"signIn\">Sign In</button>\n");
      out.write("      </div>\n");
      out.write("      <div class=\"overlay-panel overlay-right\">\n");
      out.write("        <h1>Hello, Foodies!</h1>\n");
      out.write("        <p>\n");
      out.write("          Enter your personal details and satisfy your every craving with us.\n");
      out.write("        </p>\n");
      out.write("<!--        <button class=\"ghost\" id=\"signUp\">Sign Up</button>-->\n");
      out.write("      </div>\n");
      out.write("    </div>\n");
      out.write("  </div>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("  const signUpButton = document.getElementById('signUp');\n");
      out.write("  const signInButton = document.getElementById('signIn');\n");
      out.write("  const container = document.getElementById('container');\n");
      out.write("\n");
      out.write("  signUpButton.addEventListener('click', () => {\n");
      out.write("    container.classList.add(\"right-panel-active\");\n");
      out.write("  });\n");
      out.write("\n");
      out.write("  signInButton.addEventListener('click', () => {\n");
      out.write("    container.classList.remove(\"right-panel-active\");\n");
      out.write("  });\n");
      out.write("</script>\n");
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
