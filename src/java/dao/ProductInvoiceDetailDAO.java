package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Invoice;
import model.Product; 
import model.ProductInvoiceDetail;

public class ProductInvoiceDetailDAO extends DAO {

    public ProductInvoiceDetailDAO() {
        super();
    }

    public List<ProductInvoiceDetail> getAllByInvoice(Invoice i) {
        String sql = "SELECT pid.sellprice, pid.quantity, "
                + "p.name "
                + "FROM tblProductInvoiceDetail pid " 
                + "JOIN tblProduct p ON pid.tblProductid = p.id "
                + "WHERE pid.tblInvoiceid = ?";
        
        List<ProductInvoiceDetail> ans = new ArrayList<>();
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, i.getId());
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(); 
                p.setName(rs.getString("name"));
                ProductInvoiceDetail pid = new ProductInvoiceDetail();
                pid.setSellprice(rs.getDouble("sellprice"));
                pid.setQuantity(rs.getInt("quantity"));
                pid.setProduct(p); 

                ans.add(pid);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ans;
    }
}