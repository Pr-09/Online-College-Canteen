package Order;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author prince rajput
 */
public class Order {
    public int id;
    private String username;
    private String mobile;
    private String tableNo;
    private String foodItems;
    private String orderStatus;
    public double price;

    public Order(int id, String username, String mobile, String tableNo, String foodItems, String orderStatus) {
        this.id = id;
        this.username = username;
        this.mobile = mobile;
        this.tableNo = tableNo;
        this.foodItems = foodItems;
        this.orderStatus = orderStatus;
    }

    // Getters
    public int getId() { return id; }
    public String getUsername() { return username; }
    public String getMobile() { return mobile; }
    public String getTableNo() { return tableNo; }
    public String getFoodItems() { return foodItems; }
    public String getOrderStatus() { return orderStatus;
    }
}
