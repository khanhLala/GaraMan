package model;

import java.time.LocalDate;

public class Customer extends Member {

    private Integer customerId;

    public Customer() {
        super();
    }

    public Customer(String username, String name, String email, String phone, String address) {
        super(username, name, email, phone, address);
    }

    public Customer(Integer id, String username, String name, String email, String phone, String address, LocalDate dob, Integer customerId) {
        super(id, username, name, email, phone, address, dob);
        this.customerId = customerId;
    }
    
    public Customer(Integer id, String username, String name, String email, String phone, String address, LocalDate dob) {
        super(id, username, name, email, phone, address, dob);
    }

    public Customer(Integer customerId) {
        this.customerId = customerId;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    @Override
    public String toString() {
        return "Customer{" + super.toString() + ", customerId=" + customerId + '}';
    }
}
