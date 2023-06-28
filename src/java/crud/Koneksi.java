/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package crud;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author it
 */
public class Koneksi {
    private Connection connection;
    private String error;
    private static final String url = "jdbc:mysql://localhost:3306/crud_java";
    private static final String user = "root";
    private static final String password = "";
    
    public static void main(String[] args) {
        Koneksi koneksi = new Koneksi();
        koneksi.getConnection();
    }
    
    public String getError() {
        return error;
    }
    
    public Connection getConnection() {
        connection = null;
        
        try {
            connection = DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            error = "Koneksi ke jsp_web gagal\n" + e;
            System.out.println(e.toString());
        }
        
        return connection;
    }
}
