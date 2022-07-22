/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Quan
 */
public class BillDetail {
    private Account bid;
    private Bill billcode;
    private String product;
    private String describe;
    private int quantity;
    private int unitprice;
    private int price;
    private int num;
    private Bill idbill;

    public Bill getIdbill() {
        return idbill;
    }

    public void setIdbill(Bill idbill) {
        this.idbill = idbill;
    }
    
    
    
    

    public Account getBid() {
        return bid;
    }

    public void setBid(Account bid) {
        this.bid = bid;
    }

    public Bill getBillcode() {
        return billcode;
    }

    public void setBillcode(Bill billcode) {
        this.billcode = billcode;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getUnitprice() {
        return unitprice;
    }

    public void setUnitprice(int unitprice) {
        this.unitprice = unitprice;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }
    
}
