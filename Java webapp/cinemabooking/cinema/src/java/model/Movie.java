/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author MSI
 */
public class Movie {
    private int movieId;
    private String movieName;
    private String category;
    private Date startdate;
    private int duration;
    private String language;
    private String rate;
    private String description;
    private String image;
    private Date enddate;
    
    public Movie() {
    }

    public Movie(int movieId, String movieName, String category, Date startdate, int duration, String language, String rate, String description, String image, Date enddate) {
        this.movieId = movieId;
        this.movieName = movieName;
        this.category = category;
        this.startdate = startdate;
        this.duration = duration;
        this.language = language;
        this.rate = rate;
        this.description = description;
        this.image = image;
        this.enddate = enddate;
    }

    public Date getEnddate() {
        return enddate;
    }

    public void setEnddate(Date enddate) {
        this.enddate = enddate;
    }

    

    
    
    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Date getStartdate() {
        return startdate;
    }

    public void setStartdate(Date startdate) {
        this.startdate = startdate;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getRate() {
        return rate;
    }

    public void setRate(String rate) {
        this.rate = rate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "Movie{" + "movieId=" + movieId + ", movieName=" 
                + movieName + ", category=" + category + ", startdate=" 
                + startdate + ", duration=" + duration + ", language=" 
                + language + ", rate=" + rate + ", description=" + description 
                + ", image=" + image + '}';
    }
    
    
}
