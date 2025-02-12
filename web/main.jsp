<%-- 
    Document   : main
    Created on : 31/01/2025, 09:48:16 AM
    Author     : IPS OBRERO
--%>



<%@page import="clases.ConfiguracionGeneral.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Evitar caché del navegador
    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect("index.jsp?error=2");
        return;
    }
    // Obtener el usuario correctamente desde la sesión
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Red IPS Medicron</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate, max-age=0">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            /* Estilos generales */
            * {
                font-family: "Dosis", sans-serif;
                box-sizing: border-box;
            }

            body {
                margin: 0;
                padding: 0;
                overflow-x: hidden;
            }

            /* Barra de navegación superior */
            .navbar {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                height: 50px;
                background-color: #3333ff;
                color: white;
                z-index: 1000;
            }

            /* Menú lateral */
            #menu {
                position: fixed;
                top: 50px;
                left: 0;
                width: 250px;
                height: calc(100vh - 50px);
                background-color: #ffffff;
                color: white;
                padding: 20px;
                overflow-y: auto;
            }

            /* Contenido principal */
            .content {
                margin-left: 250px;
                margin-top: 0px;
                padding: 20px;
                width: calc(100% - 250px);
                transition: margin-left 0.3s ease;
            }

            .menu {
                list-style: none;
                padding: 0;
            }

            .menu li {
                list-style: none;
            }

            .menu a {
                display: block;
                padding: 15px 20px;
                text-decoration: none;
                color: black;
                font-size: 1em;
                transition: background 0.3s ease;
            }

            .menu a:hover {
                background: rgb(173, 216, 230); 
            }

            .menu li.submenu > a {
                font-weight: bold;
                color: black;
                font-size: 0.9em !important;
            }

            .menu li.submenu ul {
                padding-left: 10px;
                display: none;
            }

            .menu li.submenu:hover ul {
                display: block;
            }

            .menu li.submenu ul li a {
                color: black;
                padding: 8px 15px;
                display: block;
                font-size: 0.8em !important;
                text-align: left;
            }

            .menu li.submenu ul li a:hover {
                background: rgb(144, 238, 144);
            }

            .menu a {
                display: flex;
                align-items: center;
                padding: 15px 20px;
                text-decoration: none;
                color: black;
                font-size: 0.9em !important;
                transition: background 0.3s ease;
            }

            .menu a::before {
                margin-right: 10px;
                color: black;
            }

            .icon-home::before {
                content: "\f015";
                font-family: "Font Awesome 5 Free";
                font-weight: 900;
            }

            .fas.fa-wallet::before {
                content: "\f555";
            }

            .fas.fa-truck::before {
                content: "\f0d1"; 
            }

            .fas.fa-dollar-sign::before {
                content: "\f155"; 
            }
            .fas.fa-user::before {
                content: "\f007"; 
            }

            .fas.fa-cogs::before {
                content: "\f085"; 
            }

            /* Contenido principal */
            .content > * {
                margin-top: 0%;
                width: 100%;
            }

            @media (max-width: 768px) {
                #menu {
                    width: 100%;
                    height: auto;
                    position: relative;
                    top: 50px;
                }

                .content {
                    margin-top: 0%;
                    margin-left: 0;
                    width: 100%;
                }
            }

            .navbar-brand {
                font-size: 1.5em;
                font-weight: bold;
            }

            .navbar-nav .nav-link {
                color: white;
            }

            .navbar-nav .nav-link:hover {
                background-color: #3399ff;
            }

            .dropdown-menu {
                min-width: 180px;
            }

            .dropdown-item {
                color: black;
            }

            .dropdown-item:hover {
                background-color: #f8f9fa;
            }

            /* Footer */
            footer.footer {
                background-color: #3333ff;
                color: white;
                padding: 5px 0;
                text-align: center;
                width: 100%;
                position: fixed;
                bottom: 0;
                left: 0;
                font-size: 12px;
            }

            footer p {
                margin: 5px 0;
            }

            footer b {
                color: #ffffff;
            }

            @media (max-width: 768px) {
                .content {
                    margin-left: 0; 
                    padding: 20px;
                }

                .navbar-brand {
                    font-size: 1.2em;
                }
            }

            .dark-mode {
                background-color: #121212;
                color: #ffffff;
            }

            .dark-mode .navbar, .dark-mode footer {
                background-color: #1e1e1e;
            }

            .dark-mode .menu a {
                color: white;
            }

            .dark-mode .menu a:hover {
                background: #444;
            }

            /* Estilos para la tabla responsiva */
            .table-responsive {
                overflow-x: auto;
            }

            .table {
                margin-top: 0%;
                width: 100%;
                margin-bottom: 1rem;
                color: #212529;
            }

            .table th,
            .table td {
                padding: 0.75rem;
                vertical-align: top;
                border-top: 1px solid #dee2e6;
            }

            .table thead th {
                vertical-align: bottom;
                border-bottom: 2px solid #dee2e6;
            }

            .table tbody + tbody {
                border-top: 2px solid #dee2e6;
            }

            .table-bordered {
                border: 1px solid #dee2e6;
            }

            .table-bordered th,
            .table-bordered td {
                border: 1px solid #dee2e6;
            }

            .table-bordered thead th,
            .table-bordered thead td {
                border-bottom-width: 2px;
            }
            .container-wrapper {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                gap: 20px; /* Espacio entre la tarjeta y la tabla */
                padding: 20px;
                flex-wrap: wrap; /* Permite que se ajusten en pantallas pequeñas */
                max-width: 100%;
                margin: 0 auto;
                margin-top: 0%;
            }

            .container-card, .table-container {
                flex: 1;
                min-width: 48%;
                max-width: 100%;
            }

            .table-container {
                overflow-x: auto; /* Evita desbordamientos */
                border-radius: 10px;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
                background: white;
                padding: 10px;
                width: 100%; /* Asegura que ocupe el espacio disponible */
            }

            .table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                table-layout: fixed; /* Hace que las columnas se distribuyan de manera uniforme */
            }

            .table th, .table td {
                padding: 10px;
                text-align: left;
                word-wrap: break-word; /* Evita desbordamientos en texto largo */
            }

            .dataTables_paginate {
                margin-top: -10px; /* Ajusta el valor según necesites */
                display: flex;
                justify-content: center;
                width: 100%;
                position: static; /* Evita desplazamientos extraños */
            }

            .dataTables_wrapper .dataTables_info {
                margin-bottom: 0; /* Reduce espacio adicional entre info y paginación */
            }


            /* Ajuste para pantallas pequeñas */
            @media (max-width: 1024px) {
                .container-wrapper {
                    flex-direction: column;
                    align-items: center;
                }
                .container-card, .table-container {
                    width: 100%;
                    min-width: unset;
                }
                .table {
                    display: block;
                    overflow-x: auto;
                }
            }
            



        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark px-3">
            <a class="navbar-brand" href="#"><img src="recursos/Logo.jpg" alt="Logo de RMIPS" width="10%" height="10%"></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <!-- Menú desplegable de perfil -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                            <img src="recursos/user_avatar.png" alt="Usuario" class="rounded-circle" width="35" height="35" 
                                 style="border: 2px solid green; margin-right: 5px;">
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li>
                                <a class="dropdown-item" href="main.jsp?CONTENIDO=inicio.jsp">
                                    <i class="fas fa-home"></i> Inicio
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="#" id="toggleTheme">
                                    <i class="fas fa-adjust"></i> Modo Oscuro/Claro
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="perfil.jsp">
                                    <i class="fas fa-user"></i> Ver tu información
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item text-danger" href="logout.jsp">
                                    <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </nav>


        <div id="menu">
            <ul class="menu">
                <%= usuario.typeObject().obtenerMenuOpcionesRolUsuario(usuario.getIdRol())%>
            </ul>

        </div>
        <div class="content">        
            <jsp:include page='<%=request.getParameter("CONTENIDO")%>' flush='true'/>
        </div>


        <footer class="footer">
            <p><b>Línea atención al usuario:</b> 6027380070
                <b>Red IPS Medicron</b> - Todos los derechos reservados
            </p>

        </footer>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>

            document.querySelectorAll('.toggle-menu').forEach(item => {
                item.addEventListener('click', function () {
                    let submenu = this.nextElementSibling;
                    if (submenu.style.display === 'block') {
                        submenu.style.display = 'none';
                    } else {
                        submenu.style.display = 'block';
                    }
                });
            });
            // Función para reinicializar los menús desplegables
            function initializeDropdowns() {
                var dropdownElementList = [].slice.call(document.querySelectorAll('.dropdown-toggle'));
                dropdownElementList.map(function (dropdownToggleEl) {
                    return new bootstrap.Dropdown(dropdownToggleEl);
                });
            }

            document.addEventListener('DOMContentLoaded', function () {
                // Inicializa todos los dropdowns en la página
                function initializeDropdowns() {
                    var dropdownElementList = [].slice.call(document.querySelectorAll('.dropdown-toggle'));
                    dropdownElementList.map(function (dropdownToggleEl) {
                        return new bootstrap.Dropdown(dropdownToggleEl);
                    });
                }

                initializeDropdowns();

                // Vuelve a inicializar los dropdowns cuando se cambia el contenido dinámico
                document.querySelector('.content').addEventListener('DOMNodeInserted', function () {
                    initializeDropdowns();
                });
            });


            document.getElementById("toggleTheme").addEventListener("click", function () {
                document.body.classList.toggle("dark-mode");
                localStorage.setItem("theme", document.body.classList.contains("dark-mode") ? "dark" : "light");
            });

            document.addEventListener("DOMContentLoaded", function () {
                if (localStorage.getItem("theme") === "dark") {
                    document.body.classList.add("dark-mode");
                }
            });
        </script>

    </body>
</html> 


