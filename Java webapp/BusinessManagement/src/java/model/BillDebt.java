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
public class BillDebt {
    private Bill idbill;
    private boolean status;
    private String time;

    public Bill getIdbill() {
        return idbill;
    }

    public void setIdbill(Bill idbill) {
        this.idbill = idbill;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }



    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
    
}
