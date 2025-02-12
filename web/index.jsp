<%-- 
    Document   : index
    Created on : 30/01/2025, 07:15:41 AM
    Author     : IPS OBRERO
--%>

<%@page import="clasesRespaldo.ConectorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String mensaje = "";
    if (request.getParameter("error") != null) {
        switch (request.getParameter("error")) {
            case "1":
                mensaje = "Usuario o contraseña no válida";
                break;
            case "2":
                mensaje = "Acceso denegado";
                break;
            default:
                mensaje = "Error desconocido";
        }
    }
   
    HttpSession sesion = request.getSession(false);
    if (sesion != null && sesion.getAttribute("usuario") != null) {
        response.sendRedirect("main.jsp?CONTENIDO=inicio.jsp");
        return;
    }
%>

%>
<!DOCTYPE html>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Factura - Ventas Red IPS Medicron</title>


    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="estilo/log_in.css">  
    <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate, max-age=0">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">

</head>


        

    <body>
  
    <div class="wrapper">
        <form name="form" method="post" action="validacionUser.jsp">           
              <center><img src="recursos/Logo.jpg" width="40%" height="5%"></center>
            <h1>Iniciar Sesión</h1>
            <div class="input-box">
                <input type="text" name="general_usu_num_identificacion" required placeholder="Usuario">
            </div>
            <div class="input-box">
                <input type="password" name="general_usu_clave" required placeholder="Contraseña">
            </div>
            <p id="error"><%= mensaje %></p>
            <button type="submit" class="btn">Ingresar</button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>
