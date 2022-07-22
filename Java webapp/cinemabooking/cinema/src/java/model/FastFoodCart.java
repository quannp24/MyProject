/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;


public class FastFoodCart {
    private int fastfoodCartId;
    private int fastfoodId;
    private int quantity;
    private int cartId ;
    
  

    public FastFoodCart() {
    }

    public FastFoodCart(int fastfoodCartId, int fastfoodId, int quantity, int cartId) {
        this.fastfoodCartId = fastfoodCartId;
        this.fastfoodId = fastfoodId;
        this.quantity = quantity;
        this.cartId = cartId;
    }

    public int getFastfoodCartId() {
        return fastfoodCartId;
    }

    public void setFastfoodCartId(int fastfoodCartId) {
        this.fastfoodCartId = fastfoodCartId;
    }

    public int getFastfoodId() {
        return fastfoodId;
    }

    public void setFastfoodId(int fastfoodId) {
        this.fastfoodId = fastfoodId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    

}
