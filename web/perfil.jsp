<%-- 
    Document   : perfil
    Created on : 12/02/2025, 08:52:30 AM
    Author     : IPS OBRERO
--%>
<%@page import="clases.ConfiguracionGeneral.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect("index.jsp?error=2");
        return;
    }

    Usuario usuario = (Usuario) sesion.getAttribute("usuario");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Perfil</title>
</head>
<body>
    <h2>Editar Perfil</h2>
    <form action="actualizarPerfil.jsp" method="post">
        <input type="hidden" name="idUsuario" value="<%= usuario.getId() %>">
        
        <label>Nombre:</label>
        <input type="text" name="nombre" value="<%= usuario.getGeneral_usu_nombre() %>" required><br>

        <label>Apellido:</label>
        <input type="text" name="apellido" value="<%= usuario.getGeneral_usu_apellido() %>" required><br>
        
        <label>Correo:</label>
        <input type="email" name="correo" value="<%= usuario.getGeneral_usu_correo_electronico() %>" required><br>

        <label>Celular:</label>
        <input type="text" name="celular" value="<%= usuario.getGeneral_usu_num_celular() %>" required><br>

        <label>Número de Identificación:</label>
        <input type="text" name="numeroIdentificacion" value="<%= usuario.getGeneral_usu_num_identificacion() %>" required><br>

        <label>Nueva Contraseña (dejar vacío para no cambiar):</label>
        <input type="password" name="clave"><br>

        <button type="submit">Guardar cambios</button>
    </form>
</body>
</html>
