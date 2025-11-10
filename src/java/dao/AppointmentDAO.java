package dao;

import java.sql.*;
import model.Appointment;

public class AppointmentDAO extends DAO{
    public AppointmentDAO(){
        super();
    }
    
    public boolean addAppointment(Appointment newAppointment){
        String sql = "INSERT INTO tblAppointment (tblScheduleTimeId, tblCustomerId, name, email, phone, description, address) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, newAppointment.getScheduleTime().getId());
            ps.setInt(2, newAppointment.getCustomer().getId());
            ps.setString(3, newAppointment.getName());
            ps.setString(4, newAppointment.getEmail());
            ps.setString(5, newAppointment.getPhone());
            ps.setString(6, newAppointment.getDescription());
            ps.setString(7, newAppointment.getAddress());
            
            ps.executeUpdate();
            return true;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
