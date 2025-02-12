<%-- 
    Document   : clientesActualizar
    Created on : 5/02/2025, 03:07:50 PM
    Author     : IPS OBRERO
--%>
<%@page import="clases.VentaActivo.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
     String accion = request.getParameter("accion");
    String id = request.getParameter("id");
    String id_tipo_identificacion = request.getParameter("id_tipo_identificacion");
    String cliente_numero_identificacion = request.getParameter("cliente_numero_identificacion");
    String cliente_digito_verificacion = request.getParameter("cliente_digito_verificacion");
    String cliente_nombre = request.getParameter("cliente_nombre");
    String cliente_apellido = request.getParameter("cliente_apellido");
    String cliente_direccion = request.getParameter("cliente_direccion");
    String cliente_numero_celular = request.getParameter("cliente_numero_celular");
    String cliente_correo_electronico = request.getParameter("cliente_correo_electronico");

    Cliente cliente = new Cliente(id);  
    cliente.setId_tipo_identificacion(id_tipo_identificacion);
    cliente.setCliente_numero_identificacion(cliente_numero_identificacion);
    cliente.setCliente_digito_verificacion(cliente_digito_verificacion);
    cliente.setCliente_nombre(cliente_nombre);
    cliente.setCliente_apellido(cliente_apellido);
    cliente.setCliente_direccion(cliente_direccion);
    cliente.setCliente_numero_celular(cliente_numero_celular);
    cliente.setCliente_correo_electronico(cliente_correo_electronico);

    if (accion != null) {
        switch(accion){
            case "Create":
                cliente.create();
                break;
            case "Actualizar":
                cliente.update(); 
                break;
            case "Delete":
                cliente.delete();
                break;
        }
    }

%>
<script type="text/javascript">
    document.location = "/main.jsp?CONTENIDO=Interfaces/ventaActivos/clientes.jsp&mensaje=Cliente actualizado";
</script>


