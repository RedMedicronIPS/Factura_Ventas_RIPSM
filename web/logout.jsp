<%-- 
    Document   : logout
    Created on : 12/02/2025, 08:07:47 AM
    Author     : IPS OBRERO
--%>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion != null) {
        sesion.invalidate(); // Cerrar sesión
    }
    
    // Evitar caché del navegador
    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    response.sendRedirect("index.jsp");
%>
