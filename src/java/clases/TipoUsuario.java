/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import clasesRespaldo.ConectorBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author IPS OBRERO
 */
public class TipoUsuario {

    private String codigo;

    public TipoUsuario(String codigo) {
        this.codigo = codigo;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getNombre() {
        String nombre = null;
        switch (codigo) {
            case "D":
                nombre = "Development";
                break;
            case "A":
                nombre = "Admin";
                break;
            case "U":
                nombre = "User";
                break;
            default:
                nombre = "Desconocido";
                break;
        }
        return nombre;
    }

    @Override
    public String toString() {
        return getNombre();
    }

    public String obtenerMenuOpcionesRolUsuario(int idRol) {
        String menuRoles = "<ul class='menu'>";

        String rowSql = "SELECT gm.menu_nombre, gmo.opcion_nombre, gmo.opcion_destino, gmo.opcion_icono "
                + "FROM generalmenuopcion gmo "
                + "INNER JOIN generalmenu gm ON gmo.id_generales_menu = gm.id "
                + "INNER JOIN generalUsuarioRolOpcion guro ON gmo.id = guro.id_menu_opcion "
                + "WHERE guro.id_rol = ? "
                + "AND guro.opcion_estado = 1 "
                + "ORDER BY gm.menu_nombre, gmo.opcion_nombre";

        Map<String, List<String>> menus = new HashMap<>();

        try (Connection conexion = ConectorBD.getConnection();
                PreparedStatement declaracionPreparadaSql = conexion.prepareStatement(rowSql)) {
            declaracionPreparadaSql.setInt(1, idRol);
            ResultSet resultadoRowSql = declaracionPreparadaSql.executeQuery();

            while (resultadoRowSql.next()) {
                String nombreMenuPrincipal = resultadoRowSql.getString("menu_nombre");
                String nombreOpcionSubmenu = resultadoRowSql.getString("opcion_nombre");
                String direccionDestino = resultadoRowSql.getString("opcion_destino");
                String icono = resultadoRowSql.getString("opcion_icono");

                if (!nombreMenuPrincipal.equals("Salir") && !nombreOpcionSubmenu.equals("Inicio")) {
                    menus.putIfAbsent(nombreMenuPrincipal, new ArrayList<>());
                    menus.get(nombreMenuPrincipal).add("<a href='main.jsp?CONTENIDO=" + direccionDestino + "'>"
                            + "<i class='" + icono + "'></i> " + nombreOpcionSubmenu + "</a>");
                }
            }
            resultadoRowSql.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return "<p>Error al generar el menú.</p>";
        }

        for (Map.Entry<String, List<String>> entry : menus.entrySet()) {
            String nombreMenu = entry.getKey();
            menuRoles += "<li class='submenu'><a href='#'>" + nombreMenu + "</a>";
            menuRoles += "<ul>";
            for (String subMenu : entry.getValue()) {
                menuRoles += "<li>" + subMenu + "</li>";
            }
            menuRoles += "</ul></li>";
        }

        if (idRol == 1) {
            menuRoles += "<li><a href='agregarOpcionMenu.jsp'>Agregar opción al menú</a></li>";
        }

        menuRoles += "</ul>";
        return menuRoles;
    }

}
