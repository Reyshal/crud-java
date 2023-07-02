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
public class Category {

    private int id;
    private String title, description;
    private final Koneksi koneksi = new Koneksi();
    private String pesan;
    private Object[][] list;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean simpan() {
        boolean result = false;
        Connection connection;

        if ((connection = koneksi.getConnection()) != null) {
            try {
                String sqlStatement = "INSERT INTO categories(title, description) VALUES('" + title + "', '" + description + "')";
                Statement statement = connection.createStatement();
                int jumlahSimpan = statement.executeUpdate(sqlStatement);

                if (jumlahSimpan < 1) {
                    pesan = "Gagal menyimpan data categories";
                    System.out.println(pesan);
                } else {
                    result = true;
                }
            } catch (SQLException ex) {
                pesan = "Tidak dapat melakukan koneksi keserver\n" + koneksi.getError() + "\n" + ex;
                System.out.println(pesan);
            }
        }
        return result;
    }

    public Object[][] listData(int start, int size) {
        Connection connection;
        boolean error = false;

        if ((connection = koneksi.getConnection()) != null) {
            try {
                String query = "SELECT * FROM categories LIMIT " + start + ", " + size;
                Statement statement = connection.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY
                );
                ResultSet resultSet = statement.executeQuery(query);

                resultSet.next();
                resultSet.last();

                list = new Object[resultSet.getRow()][];
                resultSet.first();
                
                int i = 0;
                do {
                    list[i] = new Object[]{
                        resultSet.getString("category_id"), 
                        resultSet.getString("title"),
                        resultSet.getString("description")
                    };
                    i++;
                } while (resultSet.next());

                statement.close();
                resultSet.close();
                connection.close();
            } catch (SQLException ex) {
                error = true;
                pesan = "Tidak dapat membaca categories\n" + ex.getMessage();
            }
        } else {
            error = true;
            pesan = "Tidak dapat melakukan koneksi ke server\n" + koneksi.getError();
        }
        
        if (error) {
            System.out.println(pesan);
        }
        
        return list;
    }

    public boolean update(int category_id) {
        boolean result = false;
        Connection connection;

        if ((connection = koneksi.getConnection()) != null) {
            try {
                String query = "UPDATE categories SET title = '" + title + "', description = '" + description + "' WHERE category_id = " + category_id;
                Statement statement = connection.createStatement();
                int jumlahSimpan = statement.executeUpdate(query);

                if (jumlahSimpan < 1) {
                    pesan = "Gagal menyimpan data categories";
                    System.out.println(pesan);
                } else {
                    result = true;
                }
            } catch (SQLException ex) {
                pesan = "Tidak dapat melakukan koneksi keserver\n" + koneksi.getError() + "\n" + ex;
                System.out.println(pesan);
            }
        }

        return result;
    }

    public boolean delete(int id) {
        boolean result = false;
        Connection connection;
        
        if ((connection = koneksi.getConnection()) != null) {
            try {
                String query = "DELETE FROM categories WHERE category_id = " + id;
                Statement statement = connection.createStatement();
                int jumlahSimpan = statement.executeUpdate(query);

                if (jumlahSimpan < 1) {
                    pesan = "Gagal menghapus data categories";
                    System.out.println(pesan);
                } else {
                    result = true;
                }
            } catch (SQLException ex) {
                pesan = "Tidak dapat melakukan koneksi keserver\n" + koneksi.getError() + "\n" + ex;
                System.out.println(pesan);
            }
        }

        return result;
    }
}
