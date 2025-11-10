package dao;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.Appointment;
import model.Customer;
import model.Manager;
import model.Member;
import model.ScheduleTime;

public class testDAO {
    
    // Helper method to parse date string to LocalDate
    public static LocalDate parseDate(String dateString) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        return LocalDate.parse(dateString, formatter);
    }
    
    public static void main(String[] args) {
        CustomerDAO cDao = new CustomerDAO();
        AppointmentDAO aDao =  new AppointmentDAO();
        ScheduleTimeDAO stDao = new ScheduleTimeDAO();
        MemberDAO mDAO = new MemberDAO();
        
        ManagerDAO dao = new ManagerDAO();
        Customer c = cDao.getById(1);
        System.out.println(c);
    }
}
