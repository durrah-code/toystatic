package com.model;

public class User {
    private int Id;
    private String Name;
    private String Email;
    private String Password;
    private String Address;

    public User(int Id, String Name, String Email, String Password) {
        this.Id = Id;
        this.Name = Name;
        this.Email = Email;
        this.Password = Password;
    }

    public User(String Name, String Email, String Password, String Address) {
        this.Name = Name;
        this.Email = Email;
        this.Password = Password;
        this.Address = Address;
    }

    public User(int Id,String Name, String Email, String Password, String Address) {
        this.Id = Id;
        this.Name = Name;
        this.Email = Email;
        this.Password = Password;
        this.Address = Address;
    }

    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String adminPassword) {
        this.Password = Password;
    }

    public String getAddress() {
        return Address;
    }

    public void getAddress(String Address) {
        this.Address = Address;
    }
}