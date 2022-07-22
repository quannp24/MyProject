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
public class Banner {
    private int id;
    private String img;
    private String title;
    private String desc;
    private Date start;
    private Date finish;
    

    public Banner() {
    }

    public Banner(int id, String img, String title, String desc, Date start, Date finish) {
        this.id = id;
        this.img = img;
        this.title = title;
        this.desc = desc;
        this.start = start;
        this.finish = finish;
    }

    public Date getStart() {
        return start;
    }

    public void setStart(Date start) {
        this.start = start;
    }

    public Date getFinish() {
        return finish;
    }

    public void setFinish(Date finish) {
        this.finish = finish;
    }



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    @Override
    public String toString() {
        return "Banner{" + "id=" + id + ", img=" + img + ", title=" + title + ", desc=" + desc + '}';
    }
    
    
}
