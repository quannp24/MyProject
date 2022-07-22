/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author senan
 */
public class TimeRoom {
    private int timeRoomId;
    private int roomId;
    private int movieId;
    private int movieTimeId;

    public TimeRoom() {
    }

    public TimeRoom(int timeRoomId, int roomId, int movieId, int movieTimeId) {
        this.timeRoomId = timeRoomId;
        this.roomId = roomId;
        this.movieId = movieId;
        this.movieTimeId = movieTimeId;
    }

    public int getTimeRoomId() {
        return timeRoomId;
    }

    public void setTimeRoomId(int timeRoomId) {
        this.timeRoomId = timeRoomId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public int getMovieTimeId() {
        return movieTimeId;
    }

    public void setMovieTimeId(int movieTimeId) {
        this.movieTimeId = movieTimeId;
    }
    
}
