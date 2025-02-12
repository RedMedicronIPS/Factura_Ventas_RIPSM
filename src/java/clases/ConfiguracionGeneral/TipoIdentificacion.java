/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases.ConfiguracionGeneral;

import clases.*;
import clasesRespaldo.ConectorBD;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author IPS OBRERO
 */
public class TipoIdentificacion {

    private String id;
    private String general_tip_ident_codigo;
    private String general_tip_ident_nombre;
    private String general_tip_ident_estado;

    public TipoIdentificacion() {
    }

    public TipoIdentificacion(String id) {
        String rowSql = "select general_tip_ident_codigo, general_tip_ident_nombre, general_tip_ident_estado from dbo.generalTipoIdentificacion where id='" + id + "'";
        ResultSet result = ConectorBD.consultar(rowSql);
        try {

            if (result.next()) {
                this.id = id;
                this.general_tip_ident_codigo = result.getString("general_tip_ident_codigo");
                this.general_tip_ident_nombre = result.getString("general_tip_ident_nombre");
                this.general_tip_ident_estado = result.getString("general_tip_ident_estado");
            }
        } catch (SQLException ex) {
            Logger.getLogger(TipoIdentificacion.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getGeneral_tip_ident_codigo() {
        return general_tip_ident_codigo != null ? general_tip_ident_codigo : "";
    }

    public void setGeneral_tip_ident_codigo(String general_tip_ident_codigo) {
        this.general_tip_ident_codigo = general_tip_ident_codigo;
    }

    public String getGeneral_tip_ident_nombre() {
        return general_tip_ident_nombre != null ? general_tip_ident_nombre : "";
    }

    public void setGeneral_tip_ident_nombre(String general_tip_ident_nombre) {
        this.general_tip_ident_nombre = general_tip_ident_nombre;
    }

    public String getGeneral_tip_ident_estado() {
        return general_tip_ident_estado;
    }

    public void setGeneral_tip_ident_estado(String general_tip_ident_estado) {
        this.general_tip_ident_estado = general_tip_ident_estado;
    }
    @Override 
    public String toString(){
        return general_tip_ident_nombre;
    }
    public boolean create() {
        String rowSql = "insert into dbo.generalTipoIdentificacion(general_tip_ident_codigo, general_tip_ident_nombre, general_tip_ident_estado) values ('" + general_tip_ident_codigo + "','"
                + general_tip_ident_nombre + "','" + general_tip_ident_estado + ")";
        return ConectorBD.ejecutarQuery(rowSql);

    }
    public boolean update() {
        String rowSql = "UPDATE dbo.generalTipoIdentificacion SET general_tip_ident_codigo='" + general_tip_ident_codigo + "', "
                + "general_tip_ident_nombre='" + general_tip_ident_nombre + "', general_tip_ident_estado='" + general_tip_ident_estado +  "' WHERE id='" + id + "'";
        return ConectorBD.ejecutarQuery(rowSql);

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
        String rowSql = "select id, general_tip_ident_codigo, general_tip_ident_nombre, general_tip_ident_estado from dbo.generalTipoIdentificacion" + filtro + orden;
        return ConectorBD.consultar(rowSql);
    }
    public boolean delete() {
        String rowSql = "delete from dbo.generalTipoIdentificacion where id='" + id + "'";
        return ConectorBD.ejecutarQuery(rowSql);
    }
     public static List<TipoIdentificacion> listInObjects(String filtro, String orden) {
        List<TipoIdentificacion> list = new ArrayList<>();
        ResultSet data = TipoIdentificacion.readList(filtro, orden);
        if (data != null) {
            try {
                while (data.next()) {
                    TipoIdentificacion ti = new TipoIdentificacion();
                    ti.setId(data.getString("id"));
                    ti.setGeneral_tip_ident_codigo(data.getString("general_tip_ident_codigo"));
                    ti.setGeneral_tip_ident_nombre(data.getString("general_tip_ident_nombre"));
                    ti.setGeneral_tip_ident_estado(data.getString("general_tip_ident_estado"));
                    list.add(ti);
                }

            } catch (SQLException ex) {
                Logger.getLogger(TipoIdentificacion.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return list;
    }
        public static String getListaEnOption(String preseleccionado){
        String lista="";
            List<TipoIdentificacion> data= TipoIdentificacion.listInObjects(null, "general_tip_ident_nombre");
            for (int i = 0; i < data.size(); i++) {
            TipoIdentificacion ti = data.get(i);
            String auxiliar="";
            if(preseleccionado.equals(ti.getId())) auxiliar=" selected";
            lista+="<option value='" + ti.getId() + "'" + auxiliar + ">" + ti.getGeneral_tip_ident_nombre() + "</option>";
           }
        return lista;
    } 
}
