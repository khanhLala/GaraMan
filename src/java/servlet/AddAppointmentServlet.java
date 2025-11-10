package servlet;

import dao.ScheduleTimeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.ScheduleTime;

@WebServlet(name = "AddAppointmentServlet", urlPatterns = {"/addAppointment"})
public class AddAppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ScheduleTimeDAO scheduleTimeDAO = new ScheduleTimeDAO();
        List<ScheduleTime> freeTimes = scheduleTimeDAO.getAllFreeScheduleTime();
        HttpSession session = request.getSession();
        session.setAttribute("times", freeTimes);
        request.setAttribute("freeTimes", freeTimes);

        request.getRequestDispatcher("AddAppointmentView.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String selectedTime = request.getParameter("appointmentSlot");

        if (selectedTime == null || selectedTime.isEmpty()) {
            response.sendRedirect("add-appointment?error=NoSlotSelected");
            return;
        }

        try {
            int timeId = Integer.parseInt(selectedTime);
            HttpSession session = request.getSession();     
            List<ScheduleTime> times = (List<ScheduleTime>)session.getAttribute("times");
            
            ScheduleTime choosedTime = new ScheduleTime();
            
            if(times != null){
                for(ScheduleTime time : times){
                    if(time.getId() == timeId){
                        choosedTime = time;
                        break;
                    }
                }
            }
            session.setAttribute("selectedTime", choosedTime);
            request.setAttribute("selectedTime", choosedTime);
            session.removeAttribute("times");

            request.getRequestDispatcher("AppointmentInfoView.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("view-appointments?error=InvalidFormat");
        }
    }
}