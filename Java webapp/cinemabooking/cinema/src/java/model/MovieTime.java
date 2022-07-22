/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Time;

/**
 *
 * @author senan
 */
public class MovieTime {
    private int movieTimeId;
    private int slot;
    private Time start;
    private Time finish;
    private int DateRoomID;

    public MovieTime() {
    }

    public MovieTime(int movieTimeId, int slot, Time start, Time finish, int DateRoomID) {
        this.movieTimeId = movieTimeId;
        this.slot = slot;
        this.start = start;
        this.finish = finish;
        this.DateRoomID = DateRoomID;
    }

    public int getMovieTimeId() {
        return movieTimeId;
    }

    public void setMovieTimeId(int movieTimeId) {
        this.movieTimeId = movieTimeId;
    }

    public int getSlot() {
        return slot;
    }

    public void setSlot(int slot) {
        this.slot = slot;
    }



    public Time getStart() {
        return start;
    }

    public void setStart(Time start) {
        this.start = start;
    }

    public Time getFinish() {
        return finish;
    }

    public void setFinish(Time finish) {
        this.finish = finish;
    }

    public int getDateRoomID() {
        return DateRoomID;
    }

    public void setDateRoomID(int DateRoomID) {
        this.DateRoomID = DateRoomID;
    }

    
    
}
