package model;

public class Appointment {

    private Integer id;
    private ScheduleTime scheduleTime;
    private Customer customer;
    private String name;
    private String email;
    private String phone;
    private String description;
    private String address;

    public Appointment() {
    }

    public Appointment(Integer id, ScheduleTime scheduleTime, Customer customer, String name, String email, String phone, String description, String address) {
        this.id = id;
        this.scheduleTime = scheduleTime;
        this.customer = customer;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.description = description;
        this.address = address;
    }

    public Appointment(ScheduleTime scheduleTime, Customer customer, String name, String email, String phone, String description, String address) {
        this.scheduleTime = scheduleTime;
        this.customer = customer;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.description = description;
        this.address = address;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public ScheduleTime getScheduleTime() {
        return scheduleTime;
    }

    public void setScheduleTime(ScheduleTime scheduleTime) {
        this.scheduleTime = scheduleTime;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "Appointment{" + "id=" + id + ", scheduleTime=" + scheduleTime + ", customer=" + customer + ", name=" + name + ", email=" + email + ", phone=" + phone + ", description=" + description + ", address=" + address + '}';
    }
}


