<%@page import="clases.ConfiguracionGeneral.TipoIdentificacion"%>
<%@ page import="java.util.List" %>
<%@ page import="clases.VentaActivo.Cliente" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión de Clientes</title>
        <link rel="stylesheet" href="estilo/interfacesCrd.css">
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Agregar Bootstrap desde CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Agregar DataTables CSS desde CDN -->
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

        
    </head>
    <style>
        body, .table, .form-control, .form-label {
            font-size: 16px;
        }

        .table th, .table td {
            padding: 5px; 
            text-align: center;
        }

        .form-control-sm {
            padding: 4px;
            font-size: 16px; 
        }

        h6, h2 {
            font-size: 18px;
        }
        h2{
            text-align: left;
        }
       .table table-striped table-bordered {
            flex-wrap: wrap; 
        }       
    
       .table-responsive {
    width: 100%;
    overflow-x: auto; /* Habilita el desplazamiento horizontal solo si es necesario */
}

.table {
    width: auto; /* Permite que la tabla se ajuste automáticamente */
    min-width: unset; /* Elimina el ancho mínimo fijo */
    table-layout: auto; /* Permite que las columnas se ajusten al contenido */
    white-space: nowrap; /* Evita que el texto se divida en varias líneas */
}

.table th, .table td {
    padding: 8px;
    text-align: center;
    word-wrap: normal; /* No fuerza saltos de línea */
}


    </style>

    <%
        String accion = request.getParameter("accion");
        String id = request.getParameter("id");
        Cliente cliente = new Cliente();

        if ("Actualizar".equals(accion) && id != null && !id.trim().isEmpty() && id.matches("\\d+")) {
            cliente = new Cliente(id);
        } else {
            cliente = new Cliente();
        }


    %>
    <%        String lista = "";
        List<Cliente> data = Cliente.listInObjects("", "");
        for (Cliente cliente1 : data) {
            lista += "<tr>";
            lista += "<td>" + cliente1.getId() + "</td>";
            lista += "<td>" + cliente1.getTI() + "</td>";
            lista += "<td>" + cliente1.getCliente_numero_identificacion() + "</td>";
            lista += "<td>" + cliente1.getCliente_digito_verificacion() + "</td>";
            lista += "<td>" + cliente1.getCliente_nombre() + "</td>";
            lista += "<td>" + cliente1.getCliente_apellido() + "</td>";
            lista += "<td>" + cliente1.getCliente_direccion() + "</td>";
            lista += "<td>" + cliente1.getCliente_numero_celular() + "</td>";
            lista += "<td>" + cliente1.getCliente_correo_electronico() + "</td>";
            lista += "<td><a href='main.jsp?CONTENIDO=Interfaces/ventaActivos/clientes.jsp&accion=Actualizar&id=" + cliente1.getId() + "' title='Modificar'><img src='recursos/update.png' class='icon'></a><a href='javascript:eliminar(" + cliente1.getId() + ")' title='Eliminar'><img src='recursos/delete.png' class='icon'></a></td>";
            lista += "</tr>";
        }
    %>
    <body>
    <center>                                    
        <div class="container-wrapper">
           <div class="container-card">
    <div class="card border-info bg-light">

                    <div class="card-header bg-light text-primary">
                        <h6 class="mb-0"><%= accion != null ? accion.toUpperCase() : ""%> CLIENTES DEL SISTEMA RMIPS</h6>
                    </div>
                    <div class="card-body p-2">
                        <form id="form" method="post" action="Interfaces/ventaActivos/clientesActualizar.jsp" onsubmit="return validarFormulario()">

                            <input type="hidden" name="id" value="<%= cliente.getId() != null ? cliente.getId() : "" %>">

                            <input type="hidden" name="accion" value="<%= accion != null && accion.equals("Actualizar") ? "Actualizar" : "Create"%>">

                            <div class="row align-items-end">

                                <div class="col-sm-1">
                                    <label class="form-label small">ID</label>
                                    <input type="text" class="form-control form-control-sm" value="<%= (cliente.getId() == null || cliente.getId().isEmpty()) ? "" : cliente.getId()%>" disabled>
                                </div>

                                <div class="col-sm-2">
                                    <label class="col-form-label col-form-label-sm">Tipo Documento:</label>
                                    <select class="form-control form-control-sm model" name="id_tipo_identificacion">
                                        <%= TipoIdentificacion.getListaEnOption(cliente.getId_tipo_identificacion())%>
                                    </select>
                                </div>
                                <div class="col-sm-2">
                                    <label class="col-form-label col-form-label-sm">Número Documento: <span class="required">*</span></label>
                                    <input type="text" class="form-control form-control-sm model" name="cliente_numero_identificacion" value="<%=cliente.getCliente_numero_identificacion()%>" maxlength="12" required>
                                </div>
                                <div class="col-sm-1">
                                    <label class="col-form-label col-form-label-sm">Dígito Verif.</label>
                                    <input type="number" class="form-control form-control-sm model" name="cliente_digito_verificacion" value="<%=cliente.getCliente_digito_verificacion()%>">
                                </div>
                                <div class="col-sm-3">
                                    <label class="col-form-label col-form-label-sm">Nombre: <span class="required">*</span></label>
                                    <input type="text" class="form-control form-control-sm model" name="cliente_nombre" value="<%=cliente.getCliente_nombre()%>" required>
                                </div>
                                <div class="col-sm-3">
                                    <label class="col-form-label col-form-label-sm">Apellido: <span class="required">*</span></label>
                                    <input type="text" class="form-control form-control-sm model" name="cliente_apellido" value="<%=cliente.getCliente_apellido()%>" required>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <label class="col-form-label col-form-label-sm">Dirección:</label>
                                    <input type="text" class="form-control form-control-sm model" name="cliente_direccion" value="<%=cliente.getCliente_direccion()%>">
                                </div>
                                <div class="col-sm-3">
                                    <label class="col-form-label col-form-label-sm">Celular:</label>
                                    <input type="tel" class="form-control form-control-sm model" name="cliente_numero_celular" value="<%=cliente.getCliente_numero_celular()%>" maxlength="10">
                                </div>
                                <div class="col-sm-3">
                                    <label class="col-form-label col-form-label-sm">Correo:</label>
                                    <input type="email" class="form-control form-control-sm model" name="cliente_correo_electronico" value="<%=cliente.getCliente_correo_electronico()%>" required>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="card-footer text-end">
                        <button type="submit" class="btn btn-primary btn-sm" form="form">
                            <%= accion != null && accion.equals("Actualizar") ? "Actualizar Cliente" : "Agregar Cliente"%>
                        </button>
                    </div>
                </div>
            </div>
        </div>



<div class="card-body p-2">
    <div class="table-responsive">
        <table id="miTabla" class="table table-striped table-bordered w-100">

        <thead>
            <tr>
                <th>ID</th>
                <th>T.I</th>
                <th>N° Identificación</th>
                <th>Dig.Ver</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Direccion</th>
                <th>Numero de celular</th>
                <th>Correo electronico</th>    
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <%= lista%>
        </tbody>
    </table>
</div>
</div>




    </center>                                 

    <script>
        function eliminar(id) {
            if (confirm("Realmente desea eliminar el registro?")) {
                document.location = "main.jsp?CONTENIDO=Interfaces/ventaActivos/clientesActualizar.jsp&accion=Delete&id=" + id;
            }
        }

        function validarFormulario() {
            var form = document.forms["form"];
            if (!form.cliente_numero_identificacion.value || !form.cliente_nombre.value || !form.cliente_apellido.value || !form.cliente_correo_electronico.value) {
                alert("Todos los campos obligatorios deben ser completados.");
                return false;
            }
            return true;
        }
        $(document).ready(function () {
            $('#miTabla').DataTable({
                "paging": true,
                "searching": true,
                "info": true,
                "pagingType": "full_numbers",
                "lengthMenu": [5, 10, 25, 50],
                "language": {
                    "lengthMenu": "Mostrar _MENU_ registros por página",
                    "zeroRecords": "No se encontraron resultados",
                    "info": "Mostrando página _PAGE_ de _PAGES_",
                    "infoEmpty": "No hay registros disponibles",
                    "infoFiltered": "(filtrado de _MAX_ registros totales)",
                    "search": "Buscar:",
                    "paginate": {
                        "first": "&#171;",
                        "last": "&#187;",
                        "next": "&#9658;",
                        "previous": "&#9668;"
                    }
                }
            });
        });
    </script>
</body>
</html>




