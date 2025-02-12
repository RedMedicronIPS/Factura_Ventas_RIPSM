<%-- 
    Document   : actualizarPerfil
    Created on : 12/02/2025, 08:52:53 AM
    Author     : IPS OBRERO
--%>
<%@page import="clases.ConfiguracionGeneral.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="clases.ConfiguracionGeneral.Usuario" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%
    // Obtener los parámetros del formulario
    String idUsuario = request.getParameter("idUsuario");
    String nuevoNombre = request.getParameter("nombre");
    String nuevoApellido = request.getParameter("apellido");
    String nuevoCorreo = request.getParameter("correo");
    String nuevoCelular = request.getParameter("celular");
    String nuevaClave = request.getParameter("clave");
    String nuevoNumeroIdentificacion = request.getParameter("numeroIdentificacion");

    // Validar que el usuario existe
    Usuario usuario = new Usuario(idUsuario);

    if (usuario.getId() != null) {
        // Actualizar los datos básicos
        usuario.setGeneral_usu_nombre(nuevoNombre);
        usuario.setGeneral_usu_apellido(nuevoApellido);
        usuario.setGeneral_usu_correo_electronico(nuevoCorreo);
        usuario.setGeneral_usu_num_celular(nuevoCelular);
        usuario.setGeneral_usu_num_identificacion(nuevoNumeroIdentificacion);

        // Solo actualizar la contraseña si el usuario ingresó una nueva
        if (nuevaClave != null && !nuevaClave.trim().isEmpty()) {
            usuario.setGeneral_usu_clave(nuevaClave);
        }

        // Guardar cambios
        boolean actualizado = usuario.update();

        if (actualizado) {
            out.println("<script>alert('Perfil actualizado correctamente'); window.location.href='perfil.jsp';</script>");
        } else {
            out.println("<script>alert('Error al actualizar el perfil'); window.history.back();</script>");
        }
    } else {
        out.println("<script>alert('Usuario no encontrado'); window.history.back();</script>");
    }
%>
