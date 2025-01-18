package com.model;

public class Admin {
    private String Id;
    private String Email;
    private String Password;

    public Admin(String Id, String Email, String Password) {
        this.Id = Id;
        this.Email = Email;
        this.Password = Password;
    }

    public Admin( String Email, String Password) {

        this.Email = Email;
        this.Password = Password;
    }

    public String getId() {
        return Id;
    }

    public void setId(String Id) {
        this.Id = Id;
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
}