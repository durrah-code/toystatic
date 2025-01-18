package com.model;

public class Cart {
    private int Id;
    private int prodId;
    private int userId;

    public Cart(int Id, int prodId, int userId) {
        this.Id = Id;
        this.prodId = prodId;
        this.userId = userId;
    }

    public Cart(int prodId, int userId) {

        this.prodId = prodId;
        this.userId = userId;
    }

    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public int getProdId() {
        return prodId;
    }

    public void setProdId(int prodId) {
        this.prodId = prodId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}