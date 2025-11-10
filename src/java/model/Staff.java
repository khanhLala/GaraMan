package model;

import java.time.LocalDate;

public class Staff extends Member {

    private String position;
    private String status;

    public Staff() {
    }

    public Staff(Integer id, String username, String password, String name, String email, String phone, String address, LocalDate dob) {
        super(id, username, password, name, email, phone, address, dob);
    }

    public Staff(Integer id, String username, String password, String name, String email, String phone, String address, LocalDate dob, String position, String status) {
        super(id, username, password, name, email, phone, address, dob);
        this.position = position;
        this.status = status;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Staff{" + super.toString() + ", position='" + position + '\'' + ", status='" + status + '\'' + '}';
    }
}
