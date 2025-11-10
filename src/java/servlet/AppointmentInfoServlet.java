package servlet;

import dao.AppointmentDAO;
import dao.ScheduleTimeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Appointment;
import model.Customer;
import model.ScheduleTime;

@WebServlet(name = "AppointmentInfoServlet", urlPatterns = {"/appointmentInfo"})
public class AppointmentInfoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String fullname = (String) request.getParameter("fullname");
        String phone = (String) request.getParameter("phoneNumber");
        String email = (String) request.getParameter("email");
        String address = (String) request.getParameter("address");
        String description = (String) request.getParameter("description");
        
        HttpSession session = request.getSession();
        ScheduleTime time = (ScheduleTime) session.getAttribute("selectedTime");
        Customer customer = (Customer) session.getAttribute("account");
        
        Appointment newAppointment = new Appointment(time, customer, fullname, email, phone, description, address);
        AppointmentDAO aDao = new AppointmentDAO();
        if(aDao.addAppointment(newAppointment)){
            request.setAttribute("addSuccess", "Thêm lịch hẹn thành công");
            ScheduleTimeDAO stDao = new ScheduleTimeDAO();
            stDao.changeStatus(time, "BOOKED");
        }
        else{
            request.setAttribute("addFailure", "Thêm lịch hẹn thất bại!");
        }
        request.getRequestDispatcher("AppointmentInfoView.jsp").forward(request, response);
        
    }
}