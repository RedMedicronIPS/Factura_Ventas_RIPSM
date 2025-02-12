<%-- 
    Document   : validacionUser
    Created on : 31/01/2025, 10:10:37 AM
    Author     : IPS OBRERO
--%>
<%@page import="clases.ConfiguracionGeneral.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String general_usu_num_identificacion = request.getParameter("general_usu_num_identificacion");
    String general_usu_clave = request.getParameter("general_usu_clave");

    Usuario usuario = Usuario.validar(general_usu_num_identificacion, general_usu_clave);

    if (usuario != null) {
        HttpSession sesion = request.getSession(); // Crear sesión solo si es válido
        sesion.setAttribute("usuario", usuario);
        response.sendRedirect(request.getContextPath() + "/main.jsp?CONTENIDO=inicio.jsp");
    } else {
        response.sendRedirect(request.getContextPath() + "/index.jsp?error=1");
    }
%>
