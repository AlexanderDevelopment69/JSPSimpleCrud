package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionMySQL {
    private static ConexionMySQL instancia = null;
    private Connection conexion;

    // Información de la base de datos
    private static final String URL = "jdbc:mysql://localhost:3306/ventas";
    private static final String USUARIO = "root";
    private static final String CONTRASEÑA = "root";

    private ConexionMySQL() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection(URL, USUARIO, CONTRASEÑA);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Manejo de la excepción (puedes lanzar una excepción personalizada aquí si lo deseas)
        }
    }

    public static synchronized ConexionMySQL getInstance() {
        if (instancia == null) {
            instancia = new ConexionMySQL();
        }
        return instancia;
    }

    public Connection getConnection() {
        try {
            if (conexion.isClosed()) {
                conexion = DriverManager.getConnection(URL, USUARIO, CONTRASEÑA);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Manejo de la excepción (puedes lanzar una excepción personalizada aquí si lo deseas)
        }
        return conexion;
    }
}
