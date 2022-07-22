/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author Quan
 */
public class DateRoom {
    private int DateRoomID;
    private Date DateRoom;

    public DateRoom(int DateRoomID, Date DateRoom) {
        this.DateRoomID = DateRoomID;
        this.DateRoom = DateRoom;
    }
    
    public DateRoom(){
        
    }

    public int getDateRoomID() {
        return DateRoomID;
    }

    public void setDateRoomID(int DateRoomID) {
        this.DateRoomID = DateRoomID;
    }

    public Date getDateRoom() {
        return DateRoom;
    }

    public void setDateRoom(Date DateRoom) {
        this.DateRoom = DateRoom;
    }
    
    
}
