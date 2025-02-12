package clases.VentaActivo;

import clases.VentaActivo.Cliente;
import clasesRespaldo.ConectorBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Cliente {

    private String id;
    private String id_tipo_identificacion;
    private String cliente_numero_identificacion;
    private String cliente_digito_verificacion;
    private String cliente_nombre;
    private String cliente_apellido;
    private String cliente_direccion;
    private String cliente_numero_celular;
    private String cliente_correo_electronico;
    private String cliente_estado;

    public Cliente() {
    }

    public Cliente(String id) {
        String rowSql = "SELECT id_tipo_identificacion, cliente_numero_identificacion, cliente_digito_verificacion, cliente_nombre, cliente_apellido, cliente_direccion, cliente_numero_celular, cliente_correo_electronico, cliente_estado FROM dbo.ventaActivoCliente WHERE id= ?";
        try (PreparedStatement stmt = ConectorBD.getConnection().prepareStatement(rowSql)) {
            stmt.setString(1, id);
            ResultSet result = stmt.executeQuery();
            if (result.next()) {
                this.id = id;
                this.id_tipo_identificacion = result.getString("id_tipo_identificacion");
                this.cliente_numero_identificacion = result.getString("cliente_numero_identificacion");
                this.cliente_digito_verificacion = result.getString("cliente_digito_verificacion");
                this.cliente_nombre = result.getString("cliente_nombre");
                this.cliente_apellido = result.getString("cliente_apellido");
                this.cliente_direccion = result.getString("cliente_direccion");
                this.cliente_numero_celular = result.getString("cliente_numero_celular");
                this.cliente_correo_electronico = result.getString("cliente_correo_electronico");
                this.cliente_estado = result.getString("cliente_estado");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Cliente.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId_tipo_identificacion() {
        return id_tipo_identificacion != null ? id_tipo_identificacion : "";
    }

    public void setId_tipo_identificacion(String id_tipo_identificacion) {
        this.id_tipo_identificacion = id_tipo_identificacion;
    }

    public String getCliente_numero_identificacion() {
        return cliente_numero_identificacion != null ? cliente_numero_identificacion : "";
    }

    public void setCliente_numero_identificacion(String cliente_numero_identificacion) {
        this.cliente_numero_identificacion = cliente_numero_identificacion;
    }

    public String getCliente_digito_verificacion() {
        return cliente_digito_verificacion != null ? cliente_digito_verificacion : "";
    }

    public void setCliente_digito_verificacion(String cliente_digito_verificacion) {
        this.cliente_digito_verificacion = cliente_digito_verificacion;
    }

    public String getCliente_nombre() {
        return cliente_nombre != null ? cliente_nombre : "";
    }

    public void setCliente_nombre(String cliente_nombre) {
        this.cliente_nombre = cliente_nombre;
    }

    public String getCliente_apellido() {
        return cliente_apellido != null ? cliente_apellido : "";
    }

    public void setCliente_apellido(String cliente_apellido) {
        this.cliente_apellido = cliente_apellido;
    }

    public String getCliente_direccion() {
        return cliente_direccion != null ? cliente_direccion : "";
    }

    public void setCliente_direccion(String cliente_direccion) {
        this.cliente_direccion = cliente_direccion;
    }

    public String getCliente_numero_celular() {
        return cliente_numero_celular != null ? cliente_numero_celular : "";
    }

    public void setCliente_numero_celular(String cliente_numero_celular) {
        this.cliente_numero_celular = cliente_numero_celular;
    }

    public String getCliente_correo_electronico() {
        return cliente_correo_electronico != null ? cliente_correo_electronico : "";
    }

    public void setCliente_correo_electronico(String cliente_correo_electronico) {
        this.cliente_correo_electronico = cliente_correo_electronico;
    }

    public String getCliente_estado() {
        return cliente_estado != null ? cliente_estado : "1";  // Asignamos un valor por defecto "1" si es null
    }

    public void setCliente_estado(String cliente_estado) {
        this.cliente_estado = cliente_estado;
    }

    public clases.ConfiguracionGeneral.TipoIdentificacion getTI() {
        return new clases.ConfiguracionGeneral.TipoIdentificacion(id_tipo_identificacion);
    }

    @Override
    public String toString() {
        return cliente_numero_identificacion + "-" + cliente_nombre + " " + cliente_apellido;
    }

    public boolean create() {
        if (cliente_estado == null || cliente_estado.trim().isEmpty()) {
            cliente_estado = "1";
        }

        String rowSql = "INSERT INTO dbo.ventaActivoCliente (id_tipo_identificacion, cliente_numero_identificacion, cliente_digito_verificacion, cliente_nombre, cliente_apellido, cliente_direccion, cliente_numero_celular, cliente_correo_electronico, cliente_estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = ConectorBD.getConnection().prepareStatement(rowSql)) {
            stmt.setString(1, id_tipo_identificacion);
            stmt.setString(2, cliente_numero_identificacion);
            stmt.setString(3, cliente_digito_verificacion);
            stmt.setString(4, cliente_nombre);
            stmt.setString(5, cliente_apellido);
            stmt.setString(6, cliente_direccion);
            stmt.setString(7, cliente_numero_celular);
            stmt.setString(8, cliente_correo_electronico);
            stmt.setString(9, cliente_estado);
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Cliente.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean update() {
        String rowSql = "UPDATE dbo.ventaActivoCliente SET id_tipo_identificacion=?, cliente_numero_identificacion=?, cliente_digito_verificacion=?, cliente_nombre=?, cliente_apellido=?, cliente_direccion=?, cliente_numero_celular=?, cliente_correo_electronico=?, cliente_estado=? WHERE id=?";
        try (PreparedStatement stmt = ConectorBD.getConnection().prepareStatement(rowSql)) {
            stmt.setString(1, id_tipo_identificacion);
            stmt.setString(2, cliente_numero_identificacion);
            stmt.setString(3, cliente_digito_verificacion);
            stmt.setString(4, cliente_nombre);
            stmt.setString(5, cliente_apellido);
            stmt.setString(6, cliente_direccion);
            stmt.setString(7, cliente_numero_celular);
            stmt.setString(8, cliente_correo_electronico);
            stmt.setString(9, cliente_estado);
            stmt.setString(10, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Cliente.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static ResultSet readList(String filtro, String orden) {
        if (filtro == null || filtro.trim().equalsIgnoreCase("null") || filtro.trim().isEmpty()) {
            filtro = "";
        } else {
            filtro = " WHERE " + filtro;
        }
        if (orden == null || orden.trim().equalsIgnoreCase("null") || orden.trim().isEmpty()) {
            orden = "";
        } else {
            orden = " ORDER BY " + orden;
        }

        String rowSql = "SELECT id, id_tipo_identificacion, cliente_numero_identificacion, cliente_digito_verificacion, cliente_nombre, cliente_apellido, cliente_direccion, cliente_numero_celular, cliente_correo_electronico, cliente_estado FROM dbo.ventaActivoCliente" + filtro + orden;

        try {
            PreparedStatement stmt = ConectorBD.getConnection().prepareStatement(rowSql);
            return stmt.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(Cliente.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean delete() {
        String rowSql = "DELETE FROM dbo.ventaActivoCliente WHERE id=?";
        try (PreparedStatement stmt = ConectorBD.getConnection().prepareStatement(rowSql)) {
            stmt.setString(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Cliente.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static List<Cliente> listInObjects(String filtro, String orden) {
        List<Cliente> list = new ArrayList<>();
        ResultSet data = Cliente.readList(filtro, orden);
        if (data != null) {
            try {
                while (data.next()) {
                    Cliente cliente = new Cliente();
                    cliente.setId(data.getString("id"));
                    cliente.setId_tipo_identificacion(data.getString("id_tipo_identificacion"));
                    cliente.setCliente_numero_identificacion(data.getString("cliente_numero_identificacion"));
                    cliente.setCliente_digito_verificacion(data.getString("cliente_digito_verificacion"));
                    cliente.setCliente_nombre(data.getString("cliente_nombre"));
                    cliente.setCliente_apellido(data.getString("cliente_apellido"));
                    cliente.setCliente_direccion(data.getString("cliente_direccion"));
                    cliente.setCliente_numero_celular(data.getString("cliente_numero_celular"));
                    cliente.setCliente_correo_electronico(data.getString("cliente_correo_electronico"));
                    cliente.setCliente_estado(data.getString("cliente_estado"));
                    list.add(cliente);
                }
            } catch (SQLException ex) {
                Logger.getLogger(Cliente.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return list;
    }

    public static List<Cliente> buscarClientes(String query) {
    // Asumiendo que tienes un método para consultar la BD
    // Este es un ejemplo simplificado, ajusta según tu lógica y acceso a la BD
    String sql = "SELECT * FROM clientes WHERE cliente_nombre LIKE ? OR cliente_numero_identificacion LIKE ?";
    List<Cliente> clientes = new ArrayList<>();
    try (Connection con = ConectorBD.getConnection(); 
         PreparedStatement stmt = con.prepareStatement(sql)) {
        
        stmt.setString(1, "%" + query + "%");
        stmt.setString(2, "%" + query + "%");
        
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Cliente cliente = new Cliente();
            cliente.setId(rs.getString("id"));  // "id" es el nombre de la columna en la base de datos
            cliente.setCliente_nombre(rs.getString("cliente_nombre"));
            cliente.setCliente_apellido(rs.getString("cliente_apellido"));
            cliente.setCliente_numero_identificacion(rs.getString("cliente_numero_identificacion"));
            // Agregar los demás campos del cliente
            clientes.add(cliente);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return clientes;
}

}
