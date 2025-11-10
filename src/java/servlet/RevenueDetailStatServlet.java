package servlet;

import dao.ProductStatisticDAO;
import dao.ServiceStatisticDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import model.ItemStatistic;
import model.Product;
import model.Service;

@WebServlet(name = "RevenueDetailStatServlet", urlPatterns = {"/revenueDetailStat"})
public class RevenueDetailStatServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<? extends ItemStatistic> detailList = new ArrayList<>();
        String itemName = "Không xác định";
        double detailTotal = 0;

        HttpSession session = request.getSession();

        String itemId = request.getParameter("itemId");

        String type = (String) session.getAttribute("selectedType");
        String startStr = (String) session.getAttribute("selectedStart");
        String endStr = (String) session.getAttribute("selectedEnd");
        List<? extends ItemStatistic> statList = (List<? extends ItemStatistic>) session.getAttribute("statList");

        if (itemId != null && type != null && startStr != null && endStr != null && statList != null) {
            try {
                ItemStatistic clickedItem = null;
                for (ItemStatistic item : statList) {
                    if (item.getItemId() == Integer.parseInt(itemId)) {
                        clickedItem = item;
                        itemName = item.getItemName();
                        break;
                    }
                }

                if (clickedItem != null) {
                    Date start = Date.valueOf(startStr);
                    Date end = Date.valueOf(endStr);

                    if (type.equals("service")) {
                        ServiceStatisticDAO ssDao = new ServiceStatisticDAO();
                        detailList = ssDao.getUseTime((Service) clickedItem, start, end);

                    } else if (type.equals("product")) {
                        ProductStatisticDAO psDao = new ProductStatisticDAO();
                        detailList = psDao.getUseTime((Product) clickedItem, start, end);
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        for (ItemStatistic item : detailList) {
            detailTotal += item.getTotal();
        }

        request.setAttribute("itemName", itemName);
        request.setAttribute("detailList", detailList);
        request.setAttribute("detailTotal", detailTotal);

        request.getRequestDispatcher("RevenueDetailStatView.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
