package servlet;

import dao.CustomerDAO;
import dao.InvoiceDAO;
import dao.ProductInvoiceDetailDAO;
import dao.ServiceInvoiceDetailDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Customer;
import model.Invoice;
import model.ProductInvoiceDetail;
import model.ServiceInvoiceDetail;

@WebServlet(name = "InvoiceServlet", urlPatterns = {"/invoice"})
public class InvoiceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("invoiceId");

        try {
            int invoiceId = Integer.parseInt(idStr);

            InvoiceDAO invoiceDAO = new InvoiceDAO();
            ServiceInvoiceDetailDAO sDetailDAO = new ServiceInvoiceDetailDAO();
            ProductInvoiceDetailDAO pDetailDAO = new ProductInvoiceDetailDAO();

            Invoice invoice = invoiceDAO.getInvoiceById(invoiceId);
            
            if (invoice != null) {
                List<ServiceInvoiceDetail> serviceDetails = sDetailDAO.getAllByInvoice(invoice);
                List<ProductInvoiceDetail> productDetails = pDetailDAO.getAllByInvoice(invoice);
                invoice.setServiceDetail(serviceDetails);
                invoice.setProductDetail(productDetails);

                double totalAmount = 0;
                for (ServiceInvoiceDetail detail : serviceDetails) {
                    totalAmount += detail.getQuantity() * detail.getSellprice();
                }
                for (ProductInvoiceDetail detail : productDetails) {
                    totalAmount += detail.getQuantity() * detail.getSellprice();
                }

                request.setAttribute("invoice", invoice);
                request.setAttribute("totalAmount", totalAmount);
                
            } else {
                request.setAttribute("errorMessage", "Không tìm thấy hóa đơn với ID: " + idStr);
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("/InvoiceView.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}