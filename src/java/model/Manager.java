package model;

import java.time.LocalDate;

public class Manager extends Staff{

    public Manager() {
        super();
    }

    public Manager(Integer id, String username, String password, String name, String email, String phone, String address, LocalDate dob, String position, String status) {
        super(id, username, password, name, email, phone, address, dob, position, status);
    }

    @Override
    public String toString() {
        return "Manager{" + super.toString() + "}";
    }
}
