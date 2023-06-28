/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package crud;

import java.sql.*;

/**
 *
 * @author it
 */
public class User {
    private String username;
    private String password;
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public boolean login(String username, String password) {
        Koneksi koneksi = new Koneksi();
        Connection connection = koneksi.getConnection();
        if (connection != null) {
            try {
                String query = "SELECT * FROM user WHERE username = '" + username + "' AND password = '" + password + "' LIMIT 1";
                PreparedStatement statement = connection.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                ResultSet rs = statement.executeQuery();
                
                int rowCount = 0;
                if (rs.last()) {
                  rowCount = rs.getRow();
                  rs.beforeFirst();
                }
           
                return rowCount > 0;
            } catch (SQLException ex) {
                return false;
            }
        }
        
        return false;
    }
}
