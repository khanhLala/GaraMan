package dao;

import static dao.DAO.con;
import model.ServiceStatistic;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.ProductStatistic;

public class ProductStatisticDAO extends DAO {

    public ProductStatisticDAO() {
        super();
    }

    public List<ProductStatistic> getByDate(Date start, Date end) {
        List<ProductStatistic> ans = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.price, p.description, p.status, p.quantity, "
                + "SUM(pid.quantity) as soldCount, "
                + "SUM(pid.sellprice * pid.quantity) AS total "
                + "FROM tblProduct p "
                + "JOIN tblProductInvoiceDetail pid ON p.id = pid.tblProductid "
                + "JOIN tblInvoice i ON pid.tblInvoiceid = i.id "
                + "WHERE i.createAt >= ? AND i.createAt < DATE_ADD(?, INTERVAL 1 DAY) "
                + "GROUP BY p.id, p.name, p.price, p.status, p.description, p.quantity "
                + "ORDER BY total, soldCount DESC";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDate(1, start);
            ps.setDate(2, end);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductStatistic productStat = new ProductStatistic();
                productStat.setId(rs.getInt("id"));
                productStat.setName(rs.getString("name"));
                productStat.setPrice(rs.getDouble("price"));
                productStat.setDescription(rs.getString("description"));
                productStat.setStatus(rs.getString("status"));
                productStat.setQuantity(rs.getInt("quantity"));
                productStat.setSoldCount(rs.getInt("soldCount"));
                productStat.setTotal(rs.getDouble("total"));
                ans.add(productStat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ans;
    }
    
    public List<ProductStatistic> getUseTime(Product product, Date start, Date end){
        List<ProductStatistic> ans = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.description, p.status, p.price, "
                + "pid.quantity AS soldCount, "
                + "(pid.sellprice * pid.quantity) AS total, "
                + "i.id as invoiceId, i.createAt, "
                + "c.tblMemberid AS customerId, m.name AS customerName "
                + "FROM tblProduct p "
                + "JOIN tblProductInvoiceDetail pid ON p.id = pid.tblProductid "
                + "JOIN tblInvoice i ON pid.tblInvoiceid = i.id "
                + "JOIN tblCustomer c ON i.tblCustomerid = c.tblMemberid "
                + "JOIN tblMember m ON c.tblMemberid = m.id "
                + "WHERE p.id = ? "
                + "AND i.createAt >= ? "
                + "AND i.createAt < DATE_ADD(?, INTERVAL 1 DAY) "
                + "ORDER BY i.createAt DESC";
        
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, product.getId());
            ps.setDate(2, start);
            ps.setDate(3, end);
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                ProductStatistic productStat = new ProductStatistic(product);
                productStat.setSoldCount(rs.getInt("soldCount"));
                productStat.setTotal(rs.getDouble("total"));
                productStat.setInvoiceId(rs.getInt("invoiceId"));
                productStat.setCreateAt(rs.getTimestamp("createAt").toLocalDateTime());
                productStat.setCustomerId(rs.getInt("customerId"));
                productStat.setCustomerName(rs.getString("customerName"));
                
                ans.add(productStat);
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return ans;
    }
}
