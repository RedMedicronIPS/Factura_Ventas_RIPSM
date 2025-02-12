package clasesRespaldo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConectorBD {

    private String servidor;
    private String puerto;
    private String usuario;
    private String clave;
    private String baseDatos;
    
    private static Connection conexion;

    
    public ConectorBD() {
        servidor = "192.168.59.207";
        puerto = "1433";  // Verifica si este puerto es correcto
        usuario = "DbDesarrollo";
        clave = "TI.Desarrollo%*2024";
        baseDatos = "DbDesarrolloRM";
    }

    
    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            System.out.println("Controlador cargado correctamente.");
        } catch (ClassNotFoundException e) {
            System.out.println("Error al cargar el controlador de la base de datos: " + e.getMessage());
        }
    }

    
    public static Connection getConnection() throws SQLException {
        if (conexion == null || conexion.isClosed()) {
            ConectorBD conector = new ConectorBD();
            conector.conectarBD();
        }
        return conexion;
    }

    
    public boolean conectarBD() { 
        boolean conectado = false;
        try {
            if (conexion == null || conexion.isClosed()) {
                String cadenaConexion = "jdbc:sqlserver://"+ servidor+";databaseName="+ baseDatos+ ";user="+ usuario+";password="+ clave+ ";encrypt=false;trustServerCertificate=true;";
                conexion = DriverManager.getConnection(cadenaConexion, usuario, clave);
                System.out.println("Conexión exitosa a la base de datos: " + baseDatos);
                conectado = true;
            }
        } catch (SQLException ex) {
            System.out.println("Error al conectarse a la base de datos: " + ex.getMessage());
        }
        return conectado;
    }

    
    public void desconectar() {
        try {
            if (conexion != null && !conexion.isClosed()) {
                conexion.close();
                System.out.println("Se ha desconectado de la base de datos.");
            }
        } catch (SQLException ex) {
            System.out.println("Error al desconectarse de la base de datos: " + ex.getMessage());
        }
    }

    
    public static ResultSet consultar(String cadenaSQL) {
        ResultSet resultado = null;
        try {
            Connection conexion = getConnection();
            PreparedStatement sentencia = conexion.prepareStatement(cadenaSQL, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            resultado = sentencia.executeQuery();
        } catch (SQLException ex) {
            System.out.println("Error en la cadena SQL " + cadenaSQL + ": " + ex.getMessage());
        }
        return resultado;
    }

    
    public static boolean ejecutarQuery(String cadenaSQL, Object... params) {
        boolean resultado = false;
        try {
            Connection conexion = getConnection();
            PreparedStatement sentencia = conexion.prepareStatement(cadenaSQL);
            for (int i = 0; i < params.length; i++) {
                sentencia.setObject(i + 1, params[i]);
            }
            sentencia.execute();
            resultado = true;
        } catch (SQLException ex) {
            System.out.println("Error al ejecutar la consulta SQL: " + cadenaSQL + ": " + ex.getMessage());
        }
        return resultado;
    }
    
    
    public ResultSet ejecutarConsultaConParametros(String cadenaSQL, Object... params) {
        ResultSet resultado = null;
        try {
            Connection conexion = getConnection();
            PreparedStatement sentencia = conexion.prepareStatement(cadenaSQL);
            for (int i = 0; i < params.length; i++) {
                sentencia.setObject(i + 1, params[i]);
            }
            resultado = sentencia.executeQuery();
        } catch (SQLException ex) {
            System.out.println("Error al ejecutar la consulta SQL con parámetros: " + cadenaSQL + ": " + ex.getMessage());
        }
        return resultado;
    }
}