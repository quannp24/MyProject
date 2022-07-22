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
public class Bill {
    private Account bid;
    private String billcode;
    private String name;
    private String phone;
    private String address;
    private int payment;
    private String paytype;
    private int debt;
    private int total;
    private String time;
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
    
    
    
    public Bill(){
        
    }

    public Bill(Account bid, String billcode, String name, String phone, String address, int payment, String paytype, int debt, int total) {
        this.bid = bid;
        this.billcode = billcode;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.payment = payment;
        this.paytype = paytype;
        this.debt = debt;
        this.total = total;
    }
    
    

    public int getDebt() {
        return debt;
    }

    public void setDebt(int debt) {
        this.debt = debt;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }
    
    

    public Account getBid() {
        return bid;
    }

    public void setBid(Account bid) {
        this.bid = bid;
    }

    public String getBillcode() {
        return billcode;
    }

    public void setBillcode(String billcode) {
        this.billcode = billcode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getPayment() {
        return payment;
    }

    public void setPayment(int payment) {
        this.payment = payment;
    }

    public String getPaytype() {
        return paytype;
    }

    public void setPaytype(String paytype) {
        this.paytype = paytype;
    }

    
    
}
