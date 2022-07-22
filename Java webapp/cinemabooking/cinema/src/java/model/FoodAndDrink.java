/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author MSI
 */
public class FoodAndDrink {
    private int fadId;
    private String category;
    private String fadName;
    private float price;
    private String image;

    public FoodAndDrink() {
    }

    public FoodAndDrink(int fadId, String category, String fadName, float price, String image) {
        this.fadId = fadId;
        this.category = category;
        this.fadName = fadName;
        this.price = price;
        this.image = image;
    }

    public FoodAndDrink(String category, String fadName, float price, String image) {
        this.category = category;
        this.fadName = fadName;
        this.price = price;
        this.image = image;
    }

    
    
    public int getFadId() {
        return fadId;
    }

    public void setFadId(int fadId) {
        this.fadId = fadId;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getFadName() {
        return fadName;
    }

    public void setFadName(String fadName) {
        this.fadName = fadName;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "FoodAndDrink{" + "fadId=" + fadId + ", category=" + category + ", fadName=" + fadName + ", price=" + price + ", image=" + image + '}';
    }
    
    
}
