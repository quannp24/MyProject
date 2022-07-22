/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Quan
 */
public class Seat {
    private int SeatId;
    private int SeatNumber;
    private float SeatPrice;
    private String SeatRow;
    
    public Seat(){
        
    }
    public Seat(int SeatId, int SeatNumber, float SeatPrice, String SeatRow) {
        this.SeatId = SeatId;
        this.SeatNumber = SeatNumber;
        this.SeatPrice = SeatPrice;
        this.SeatRow = SeatRow;
    }

    public int getSeatId() {
        return SeatId;
    }

    public void setSeatId(int SeatId) {
        this.SeatId = SeatId;
    }

    public int getSeatNumber() {
        return SeatNumber;
    }

    public void setSeatNumber(int SeatNumber) {
        this.SeatNumber = SeatNumber;
    }

    public float getSeatPrice() {
        return SeatPrice;
    }

    public void setSeatPrice(float SeatPrice) {
        this.SeatPrice = SeatPrice;
    }

    public String getSeatRow() {
        return SeatRow;
    }

    public void setSeatRow(String SeatRow) {
        this.SeatRow = SeatRow;
    }
    
}
