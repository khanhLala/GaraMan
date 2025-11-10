package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.ItemStatistic;
import dao.ServiceStatisticDAO;
import dao.ProductStatisticDAO;
import java.sql.Date;
import java.util.ArrayList;

@WebServlet(name = "RevenueStatServlet", urlPatterns = {"/revenueStat"})
public class RevenueStatServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        
        String type = request.getParameter("type");
        String startStr = request.getParameter("start");
        String endStr = request.getParameter("end");
        List<? extends ItemStatistic> statList = new ArrayList<>();
        double totalRev = 0;
        if(type != null && startStr != null && endStr != null){
            try{
                Date start = Date.valueOf(startStr);
                Date end = Date.valueOf(endStr);
                if (type.equals("service")){
                    ServiceStatisticDAO ssDao = new ServiceStatisticDAO();
                    statList = ssDao.getByDate(start, end);
                }
                else if (type.equals("product")){
                    ProductStatisticDAO psDao = new ProductStatisticDAO();
                    statList = psDao.getByDate(start, end);
                }
                for(ItemStatistic item : statList){
                    totalRev += item.getTotal();
                }
            } catch (Exception e){
                e.printStackTrace();
            }
        }
        
        HttpSession session = request.getSession();
        session.setAttribute("statList", statList);
        session.setAttribute("selectedType", type);
        session.setAttribute("selectedStart", startStr);
        session.setAttribute("selectedEnd", endStr);
        
        request.setAttribute("statList", statList);
        request.setAttribute("total", totalRev);        
        request.setAttribute("selectedType", type);
        request.setAttribute("selectedStart", startStr);
        request.setAttribute("selectedEnd", endStr);
        
        request.getRequestDispatcher("RevenueStatView.jsp").forward(request, response);
    }
}