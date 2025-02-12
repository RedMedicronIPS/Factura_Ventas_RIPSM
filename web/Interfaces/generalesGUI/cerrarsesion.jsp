<%-- 
    Document   : cerrarsesion
    Created on : 12/02/2025, 07:50:56 AM
    Author     : IPS OBRERO
--%>


    <%
    HttpSession sesion = request.getSession(false);
    if (sesion != null) {
        sesion.invalidate(); // Destruye la sesión
    }
    response.sendRedirect("index.jsp");
%>

    