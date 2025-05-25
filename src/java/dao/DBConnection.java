/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author prince rajput
 */
public class DBConnection {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(
                    "jdbc:oracle:thin:@//LAPTOP-N2GI2VLF:1521/xe", "Canteen_DB", "Canteen_DB");
            
            System.out.println("Canteen Project Connection has opened: ");
            
        } catch (Exception e) {
            
            System.out.println("Canteen Project Connection has Failed: ");
            
            e.printStackTrace();
        }
        
        return conn;
    }
}
