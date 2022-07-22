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
public class Import {
    private int iid;
    private Account bid;
    private String iname;
    private String iphone;
    private String iaddress;
    private String iconfirm;
    private int itotal;
    private int idebt;
    private int payment;
    private String time;

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
    
    public Import(){
        
    }
    

    public Import(int iid,Account bid, String iname, String iphone, String iaddress, String iconfirm, int itotal, int idebt, int payment) {
        this.iid=iid;
        this.bid = bid;
        this.iname = iname;
        this.iphone = iphone;
        this.iaddress = iaddress;
        this.iconfirm = iconfirm;
        this.itotal = itotal;
        this.idebt = idebt;
        this.payment = payment;
        
    }
    
    

    public int getIid() {
        return iid;
    }

    public void setIid(int iid) {
        this.iid = iid;
    }

    public Account getBid() {
        return bid;
    }

    public void setBid(Account bid) {
        this.bid = bid;
    }

    public String getIname() {
        return iname;
    }

    public void setIname(String iname) {
        this.iname = iname;
    }

    public String getIphone() {
        return iphone;
    }

    public void setIphone(String iphone) {
        this.iphone = iphone;
    }

    public String getIaddress() {
        return iaddress;
    }

    public void setIaddress(String iaddress) {
        this.iaddress = iaddress;
    }

    public String getIconfirm() {
        return iconfirm;
    }

    public void setIconfirm(String iconfirm) {
        this.iconfirm = iconfirm;
    }

    public int getItotal() {
        return itotal;
    }

    public void setItotal(int itotal) {
        this.itotal = itotal;
    }

    public int getIdebt() {
        return idebt;
    }

    public void setIdebt(int idebt) {
        this.idebt = idebt;
    }

    public int getPayment() {
        return payment;
    }

    public void setPayment(int payment) {
        this.payment = payment;
    }

    
    
}
