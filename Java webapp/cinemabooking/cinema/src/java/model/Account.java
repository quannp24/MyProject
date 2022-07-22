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
public class Account {
    private int accId;
    private String email;
    private String password;
    private String fullname;
    private boolean Gender ;
    private Date dob;
    private String address;
    private String phone;
    private String img;
    private String role;
    private boolean status;
    
    public Account(){
        
    }

    public Account(int accId, String email, String password, String fullname, boolean Gender, Date dob, String address, String phone, String img, String role, boolean status) {
        this.accId = accId;
        this.email = email;
        this.password = password;
        this.fullname = fullname;
        this.Gender = Gender;
        this.dob = dob;
        this.address = address;
        this.phone = phone;
        this.img = img;
        this.role = role;
        this.status = status;
    }

    public Account(String email, String password, String fullname, boolean Gender, Date dob, String address, String phone, String img, String role, boolean status) {
        this.email = email;
        this.password = password;
        this.fullname = fullname;
        this.Gender = Gender;
        this.dob = dob;
        this.address = address;
        this.phone = phone;
        this.img = img;
        this.role = role;
        this.status = status;
    }
    

    public int getAccId() {
        return accId;
    }

    public void setAccId(int accId) {
        this.accId = accId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public boolean isGender() {
        return Gender;
    }

    public void setGender(boolean Gender) {
        this.Gender = Gender;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

   
    
    
}
