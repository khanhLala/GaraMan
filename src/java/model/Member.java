package model;

import java.time.LocalDate;

public class Member {

    private Integer id;
    private String username;
    private String password;
    private String name;
    private String email;
    private String phone;
    private String address;
    private LocalDate dob;

    public Member() {
    }

    public Member(Integer id, String username, String password, String name, String email, String phone, String address, LocalDate dob) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.dob = dob;
    }

    public Member(String username, String name, String email, String phone, String address) {
        this.username = username;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
    }

    public Member(Integer id, String username, String name, String email, String phone, String address, LocalDate dob) {
        this.id = id;
        this.username = username;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.dob = dob;
    }

    public Member(String username, String password, String name, String email, String phone, String address, LocalDate dob) {
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.dob = dob;
    }

    public Member(String username, String password) {
        this.username = username;
        this.password = password;
    }
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    @Override
    public String toString() {
        return "Member{" + "id=" + id + ", username=" + username + ", name=" + name + ", email=" + email + ", phone=" + phone + ", address=" + address + ", dob=" + dob + '}';
    }
    
}


