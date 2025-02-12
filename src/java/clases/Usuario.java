/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import clasesRespaldo.ConectorBD;
import java.util.logging.Logger;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

/**
 *
 * @author IPS OBRERO
 */
public class Usuario {

    private String id;
    private String general_usu_num_identificacion;
    private String general_usu_nombre;
    private String general_usu_apellido;
    private String general_usu_correo_electronico;
    private String general_usu_num_celular;
    private String general_usu_clave;
    private String general_usu_rol;
    private String general_usu_estado;
    private String general_usu_id_tipo_identificacion;

    public Usuario() {
    }

    public Usuario(String id) {
        String rowSql = "select general_usu_num_identificacion, general_usu_nombre, general_usu_apellido, general_usu_correo_electronico, general_usu_num_celular, general_usu_clave, general_usu_rol, general_usu_estado, general_usu_id_tipo_identificacion from dbo.generalUsuario where id= '" + id + "'";
        ResultSet result = ConectorBD.consultar(rowSql);

        try {
            if (result.next()) {
                this.id = id;
                this.general_usu_num_identificacion = result.getString("general_usu_num_identificacion");
                this.general_usu_nombre = result.getString("general_usu_nombre");
                this.general_usu_apellido = result.getString("general_usu_apellido");
                this.general_usu_correo_electronico = result.getString("general_usu_correo_electronico");
                this.general_usu_num_celular = result.getString("general_usu_num_celular");
                this.general_usu_clave = result.getString("general_usu_clave");
                this.general_usu_rol = result.getString("general_usu_rol");
                this.general_usu_estado = result.getString("general_usu_clave");
                this.general_usu_id_tipo_identificacion = result.getString("general_usu_id_tipo_identificacion");

            }
        } catch (SQLException ex) {
            Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getGeneral_usu_num_identificacion() {
        return general_usu_num_identificacion != null ? general_usu_num_identificacion : "";
    }

    public void setGeneral_usu_num_identificacion(String general_usu_num_identificacion) {
        this.general_usu_num_identificacion = general_usu_num_identificacion;
    }

    public String getGeneral_usu_nombre() {
        return general_usu_nombre != null ? general_usu_nombre : "";
    }

    public void setGeneral_usu_nombre(String general_usu_nombre) {
        this.general_usu_nombre = general_usu_nombre;
    }

    public String getGeneral_usu_apellido() {
        return general_usu_apellido != null ? general_usu_apellido : "";
    }

    public void setGeneral_usu_apellido(String general_usu_apellido) {
        this.general_usu_apellido = general_usu_apellido;
    }

    public String getGeneral_usu_correo_electronico() {
        return general_usu_correo_electronico != null ? general_usu_correo_electronico : "";
    }

    public void setGeneral_usu_correo_electronico(String general_usu_correo_electronico) {
        this.general_usu_correo_electronico = general_usu_correo_electronico;
    }

    public String getGeneral_usu_num_celular() {
        return general_usu_num_celular != null ? general_usu_num_celular : "";
    }

    public void setGeneral_usu_num_celular(String general_usu_num_celular) {
        this.general_usu_num_celular = general_usu_num_celular;
    }

    public String getGeneral_usu_clave() {
        return general_usu_clave != null ? general_usu_clave : "";
    }

    public void setGeneral_usu_clave(String general_usu_clave) {
        if (general_usu_clave == null || general_usu_clave.trim().length() == 0) {
            general_usu_clave = id;
        }
        if (general_usu_clave.length() < 32) {
            this.general_usu_clave = "md5('" + general_usu_clave + "')";
        } else {
            this.general_usu_clave = "'" + general_usu_clave + "'";
        }
    }

    public String getGeneral_usu_rol() {
        return general_usu_rol != null ? general_usu_rol : "";
    }

    public void setGeneral_usu_rol(String general_usu_rol) {
        this.general_usu_rol = general_usu_rol;
    }

    public String getGeneral_usu_estado() {
        return general_usu_estado != null ? general_usu_estado : "";
    }

    public void setGeneral_usu_estado(String general_usu_estado) {
        this.general_usu_estado = general_usu_estado;
    }

    public String getGeneral_usu_id_tipo_identificacion() {
        return general_usu_id_tipo_identificacion != null ? general_usu_id_tipo_identificacion : "";
    }

    public void setGeneral_usu_id_tipo_identificacion(String general_usu_id_tipo_identificacion) {
        this.general_usu_id_tipo_identificacion = general_usu_id_tipo_identificacion;
    }

    @Override
    public String toString() {
        return general_usu_num_identificacion != null ? general_usu_num_identificacion + " - " + general_usu_nombre + " " + general_usu_apellido : "";
    }

    public TipoUsuario typeObject() {
        return new TipoUsuario(general_usu_rol);
    }

    public int getIdRol() {
        try {
            return Integer.parseInt(general_usu_rol);
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    public static Usuario validar(String identificacion, String clave) {
        Usuario user = null;
        String sql = "SELECT * FROM dbo.generalUsuario WHERE general_usu_num_identificacion='" + identificacion
                + "' AND general_usu_clave=CONVERT(VARCHAR(32), HASHBYTES('MD5', '" + clave + "'), 2)";
        ResultSet rs = ConectorBD.consultar(sql);
        try {
            if (rs.next()) {
                user = new Usuario(rs.getString("id"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public boolean create() {
        String sql = "INSERT INTO dbo.generalUsuario (general_usu_num_identificacion, general_usu_nombre, general_usu_apellido, "
                + "general_usu_correo_electronico, general_usu_num_celular, general_usu_clave, general_usu_rol, general_usu_estado, general_usu_id_tipo_identificacion) VALUES ('"
                + general_usu_num_identificacion + "', '" + general_usu_nombre + "', '" + general_usu_apellido + "', '" + general_usu_correo_electronico + "', '"
                + general_usu_num_celular + "', CONVERT(VARCHAR(32), HASHBYTES('MD5', '" + general_usu_clave + "'), 2), '" + general_usu_rol + "', '" + general_usu_estado + "','" + general_usu_id_tipo_identificacion + ")";
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean update() {
        String sql = "UPDATE dbo.generalUsuario SET general_usu_num_identificacion='" + general_usu_num_identificacion + "', "
                + "general_usu_nombre='" + general_usu_nombre + "', general_usu_apellido='" + general_usu_apellido + "', "
                + "general_usu_correo_electronico='" + general_usu_correo_electronico + "', general_usu_num_celular='" + general_usu_num_celular + "', "
                + "general_usu_clave=CONVERT(VARCHAR(32), HASHBYTES('MD5', '" + general_usu_clave + "'), 2), "
                + "general_usu_rol='" + general_usu_rol + "', general_usu_estado='" + general_usu_estado + "', general_usu_id_tipo_identificacion='" + general_usu_id_tipo_identificacion + "' WHERE id='" + id + "'";
        return ConectorBD.ejecutarQuery(sql);
    }

    public static ResultSet readList(String filtro, String orden) {
        if (filtro != null && !filtro.isEmpty()) {
            filtro = " where " + filtro;
        } else {
            filtro = "";
        }
        if (orden != null && !orden.isEmpty()) {
            orden = " order by " + orden;
        } else {
            orden = "";
        }
        String rowSql = "select id, general_usu_num_identificacion, general_usu_nombre, general_usu_apellido, general_usu_correo_electronico, general_usu_num_celular, general_usu_clave, general_usu_rol, general_usu_estado, general_usu_id_tipo_identificacion from dbo.generalUsuario" + filtro + orden;
        return ConectorBD.consultar(rowSql);
    }

    public boolean delete() {
        String sql = "DELETE FROM dbo.generalUsuario WHERE id='" + id + "'";
        return ConectorBD.ejecutarQuery(sql);
    }

    public static List<Usuario> getListaEnObjetos(String filtro, String orden) {
        List<Usuario> lista = new ArrayList<>();
        String rowSql = "select id, general_usu_num_identificacion, general_usu_nombre, general_usu_apellido, general_usu_correo_electronico, general_usu_num_celular, general_usu_clave, general_usu_rol, general_usu_estado,general_usu_id_tipo_identificacion from dbo.generalUsuario";
        if (filtro != null && !filtro.isEmpty()) {
            rowSql += " where " + filtro;
        }
        if (orden != null && !orden.isEmpty()) {
            rowSql += " order by " + orden;
        }
        ResultSet resultado = ConectorBD.consultar(rowSql);
        try {
            while (resultado.next()) {
                Usuario user = new Usuario();
                user.setId(resultado.getString("id"));
                user.setGeneral_usu_num_identificacion(resultado.getString("general_usu_num_identificacion"));
                user.setGeneral_usu_nombre(resultado.getString("general_usu_nombre"));
                user.setGeneral_usu_apellido(resultado.getString("general_usu_apellido"));
                user.setGeneral_usu_correo_electronico(resultado.getString("general_usu_correo_electronico"));
                user.setGeneral_usu_num_celular(resultado.getString("general_usu_num_celular"));
                user.setGeneral_usu_clave(resultado.getString("general_usu_clave"));
                user.setGeneral_usu_rol(resultado.getString("general_usu_rol"));
                user.setGeneral_usu_estado(resultado.getString("general_usu_estado"));
                user.setGeneral_usu_id_tipo_identificacion(resultado.getString("general_usu_id_tipo_identificacion"));
                lista.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }
}
