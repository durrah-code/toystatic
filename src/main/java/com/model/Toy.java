package com.model;

import java.io.InputStream;

public class Toy {
    private String Id;
    private String Name;
    private String Price;
    private InputStream Image;

    public Toy(String Id, String Name,String Price, InputStream Image) {
        this.Id = Id;
        this.Name = Name;
        this.Price = Price;
        this.Image = Image;
    }
    public Toy( String Name,String Price, InputStream Image) {
        this.Name = Name;
        this.Price = Price;
        this.Image = Image;
    }
    public String getId() {
        return Id;
    }

    public void setId(String Id) {
        this.Id = Id;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public String getPrice() {
        return Price;
    }

    public void setPrice(String Price) {
        this.Price = Price;
    }

    public InputStream getImage() {
        return Image;
    }

    public void setImage(InputStream Image) {
        this.Image = Image;
    }
}