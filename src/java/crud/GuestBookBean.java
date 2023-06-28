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
public class GuestBookBean {

    private int id;
    private String name, address, company, email, created_at;
    private final Koneksi koneksi = new Koneksi();
    private String pesan;
    private Object[][] list;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCreatedAt() {
        return created_at;
    }

    public void setCreatedAt(String created_at) {
        this.created_at = created_at;
    }

    public boolean simpan() {
        boolean result = false;
        Connection connection;

        if ((connection = koneksi.getConnection()) != null) {
            try {
                String sqlStatement = "insert into guest_book(name,address,company,email) values('" + name + "'  ,'" + address + "' ,'" + company + "' ,'" + email + "')";
                Statement statement = connection.createStatement();
                int jumlahSimpan = statement.executeUpdate(sqlStatement);

                if (jumlahSimpan < 1) {
                    pesan = "Gagal menyimpan data guest_book";
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

    public Object[][] listData(int mulai, int jumlah) {
        Connection connection;
        boolean adaKesalahan = false;

        if ((connection = koneksi.getConnection()) != null) {
            String SQLStatemen;
            Statement sta;
            ResultSet rset;
            try {
                SQLStatemen = "select * from guest_book order by created_at desc limit " + mulai + "," + jumlah + " ";
                sta = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                        ResultSet.CONCUR_READ_ONLY);
                rset = sta.executeQuery(SQLStatemen);
                rset.next();
                rset.last();
                list = new Object[rset.getRow()][];
                rset.first();
                int i = 0;
                do {
                    if (!rset.getString("email").equals("")) {
                        list[i] = new Object[]{rset.getString("id"), rset.getString("name"),
                            rset.getString("address"), rset.getString("company"), rset.getString("email"), rset.getString("created_at")};
                    }
                    i++;
                } while (rset.next());
                sta.close();
                rset.close();
                connection.close();
            } catch (SQLException ex) {
                adaKesalahan = true;
                pesan = "Tidak dapat membaca guest_book\n" + ex.getMessage();
            }
        } else {
            adaKesalahan = true;
            pesan = "Tidak dapat melakukan koneksi ke server\n" + koneksi.getError();
        }
        
        if (adaKesalahan) {
            System.out.println(pesan);
        }
        
        return list;
    }

    public boolean update(int id) {
        boolean adaKesalahan = false;
        Connection connection;
        if ((connection = koneksi.getConnection()) != null) {
            int jumlahSimpan = 0;
            boolean simpan = false;
            Statement sta;
            ResultSet rset;
            try {
                simpan = true;
                String SQLStatemen = "update guest_book set name='" + name + "',address='"
                        + address + "',company='" + company + "',email='" + email + "' where id=" + id + " ";
                sta = connection.createStatement();
                jumlahSimpan = sta.executeUpdate(SQLStatemen);
                if (simpan) {
                    if (jumlahSimpan < 1) {
                        adaKesalahan = true;
                        pesan = "Gagal menyimpan data guest_book";
                        System.out.println(pesan);
                    }
                } else {
                    adaKesalahan = true;
                    pesan = "Tidak dapat melakukan koneksi keserver\n"
                            + koneksi.getError();
                    System.out.println(pesan);
                }
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
        return !adaKesalahan;
    }

    public boolean delete(int id) {
        boolean adaKesalahan = false;
        Connection connection;
        if ((connection = koneksi.getConnection()) != null) {
            int jumlahSimpan = 0;
            boolean simpan = false;
            Statement sta;
            ResultSet rset;
            try {
                simpan = true;
                String SQLStatemen = "delete from guest_book where id=" + id + " ";
                sta = connection.createStatement();
                jumlahSimpan = sta.executeUpdate(SQLStatemen);
                if (simpan) {
                    if (jumlahSimpan < 1) {
                        adaKesalahan = true;
                        pesan = "Gagal menghapus data guest_book";
                        System.out.println(pesan);
                    }
                } else {
                    adaKesalahan = true;
                    pesan = "Tidak dapat melakukan koneksi keserver\n"
                            + koneksi.getError();
                    System.out.println(pesan);
                }
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
        return !adaKesalahan;
    }
}
