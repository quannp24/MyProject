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
public class ImportDetail {
    private Import iid;
    private String iproduct;
    private int iquantity;
    private int iunitprice;
    private int iprice;
    private String idescribe;
    private int num;

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }
    
    
    

    public Import getIid() {
        return iid;
    }

    public void setIid(Import iid) {
        this.iid = iid;
    }

    public String getIproduct() {
        return iproduct;
    }

    public void setIproduct(String iproduct) {
        this.iproduct = iproduct;
    }

    public int getIquantity() {
        return iquantity;
    }

    public void setIquantity(int iquantity) {
        this.iquantity = iquantity;
    }

    public int getIunitprice() {
        return iunitprice;
    }

    public void setIunitprice(int iunitprice) {
        this.iunitprice = iunitprice;
    }

    public int getIprice() {
        return iprice;
    }

    public void setIprice(int iprice) {
        this.iprice = iprice;
    }

    public String getIdescribe() {
        return idescribe;
    }

    public void setIdescribe(String idescribe) {
        this.idescribe = idescribe;
    }

    
    
}
