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
public class Book {

    private int product_id, price, categoryId;
    private String title, author, description, image;
    private final Koneksi koneksi = new Koneksi();
    private String pesan;
    private Object[][] list;

    public int getId() {
        return product_id;
    }

    public void setId(int product_id) {
        this.product_id = product_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public boolean simpan() {
        boolean result = false;
        Connection connection;

        if ((connection = koneksi.getConnection()) != null) {
            try {
                String query = "INSERT INTO books(title, author, description, price, category_id, image) VALUES('" + title + "', '" + author + "', '" + description + "', " + price + ", " + categoryId + ", '" + image + "')";
                Statement statement = connection.createStatement();
                int jumlahSimpan = statement.executeUpdate(query);

                if (jumlahSimpan < 1) {
                    pesan = "Gagal menyimpan data books";
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

    public Object[][] listData(int start, int jumlah) {
        Connection connection;
        boolean error = false;

        if ((connection = koneksi.getConnection()) != null) {
            try {
                String query = "SELECT * FROM books LIMIT " + start + ", " + jumlah + " ";
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
                        resultSet.getString("product_id"), 
                        resultSet.getString("title"),
                        resultSet.getString("author"), 
                        resultSet.getString("description"), 
                        resultSet.getString("price"), 
                        resultSet.getString("category_id"),
                        resultSet.getString("image")
                    };
                    i++;
                } while (resultSet.next());

                statement.close();
                resultSet.close();
                connection.close();
            } catch (SQLException ex) {
                error = true;
                pesan = "Tidak dapat membaca books\n" + ex.getMessage();
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

    public boolean update(int product_id) {
        boolean result = false;
        Connection connection;

        if ((connection = koneksi.getConnection()) != null) {
            try {
                String query = "UPDATE books SET title = '" + title + "', author = '" + author + "', description = '" + description + "', price = " + price + ", category_id = " + categoryId + ", image = '" + image + "' WHERE product_id = " + product_id;
                Statement statement = connection.createStatement();
                int jumlahSimpan = statement.executeUpdate(query);
                
                if (jumlahSimpan < 1) {
                    pesan = "Gagal menyimpan data books";
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

    public boolean delete(int product_id) {
        boolean result = false;
        Connection connection;

        if ((connection = koneksi.getConnection()) != null) {
            try {
                String SQLStatemen = "DELETE FROM books WHERE product_id = " + product_id;
                Statement sta = connection.createStatement();
                int jumlahSimpan = sta.executeUpdate(SQLStatemen);

                if (jumlahSimpan < 1) {
                    pesan = "Gagal menghapus data books";
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
