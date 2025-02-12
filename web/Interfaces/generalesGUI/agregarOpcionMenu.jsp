<%@page import="clasesRespaldo.ConectorBD"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Agregar Opción al Menú</title>
</head>
<body>
    <h2>Agregar Nueva Opción al Menú</h2>

    <form action="agregarOpcionMenu.jsp" method="post">
        <label for="nombrePagina">Nombre de la Página:</label><br>
        <input type="text" id="nombrePagina" name="nombrePagina" required><br><br>

        <label for="nombreOpcion">Nombre de la Opción:</label><br>
        <input type="text" id="nombreOpcion" name="nombreOpcion" required><br><br>

        <input type="submit" value="Agregar Opción">
    </form>

    <%

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String nombrePagina = request.getParameter("nombrePagina");
            String nombreOpcion = request.getParameter("nombreOpcion");

            if (nombrePagina != null && !nombrePagina.isEmpty() && nombreOpcion != null && !nombreOpcion.isEmpty()) {
                
                String sql = "INSERT INTO generalUsuariorolopcion (nombre_pagina, nombre_opcion, id_rol) VALUES (?, ?, ?)";

                try (Connection conexion = ConectorBD.getConnection();
                     PreparedStatement ps = conexion.prepareStatement(sql)) {
                    
                    ps.setString(1, nombrePagina);
                    ps.setString(2, nombreOpcion);
                    ps.setInt(3, 1);  

                    int filasAfectadas = ps.executeUpdate();
                    if (filasAfectadas > 0) {
                        out.println("<p>La opción se agregó correctamente al menú.</p>");
                    } else {
                        out.println("<p>No se pudo agregar la opción. Inténtalo nuevamente.</p>");
                    }
                } catch (SQLException e) {
                    out.println("<p>Error al agregar la opción: " + e.getMessage() + "</p>");
                }
            } else {
                out.println("<p>Por favor, complete ambos campos.</p>");
            }
        }
    %>

    <br>
    <a href="main.jsp?CONTENIDO=inicio.jsp">Volver al inicio</a>

</body>
</html>
