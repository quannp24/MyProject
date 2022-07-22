/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Quan
 */
public class SeatRoomCart {

    private int seatRoomCartId;
    private int seatRoomId;
    private int cartId;

    public SeatRoomCart() {
    }

    public SeatRoomCart(int seatRoomId, int cartId) {
        this.seatRoomId = seatRoomId;
        this.cartId = cartId;
    }

    public SeatRoomCart(int seatRoomCartId, int seatRoomId, int cartId) {
        this.seatRoomCartId = seatRoomCartId;
        this.seatRoomId = seatRoomId;
        this.cartId = cartId;
    }

    public int getSeatRoomCartId() {
        return seatRoomCartId;
    }

    public void setSeatRoomCartId(int seatRoomCartId) {
        this.seatRoomCartId = seatRoomCartId;
    }

    public int getSeatRoomId() {
        return seatRoomId;
    }

    public void setSeatRoomId(int seatRoomId) {
        this.seatRoomId = seatRoomId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

}
