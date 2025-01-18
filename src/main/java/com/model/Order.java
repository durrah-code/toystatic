package com.model;

public class Order {
    private int id; // Changed 'Id' to 'id' to follow Java naming conventions
    private String date;
    private String status;
    private String totalPrice; // Changed 'totalprice' to 'totalPrice' for consistency
    private String shipAddress;
    private int custId;

    // Default constructor
    public Order() {
    }

    // Parameterized constructor
    public Order(int id, String date, String status, String totalPrice, String shipAddress, int custId) {
        this.id = id;
        this.date = date;
        this.status = status;
        this.totalPrice = totalPrice;
        this.shipAddress = shipAddress;
        this.custId = custId;
    }

    public Order(int id,String status) {
        this.id = id;
        this.status = status;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(String totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getShipAddress() {
        return shipAddress;
    }

    public void setShipAddress(String shipAddress) {
        this.shipAddress = shipAddress;
    }

    public int getCustId() {
        return custId;
    }

    public void setCustId(int custId) {
        this.custId = custId;
    }


}
