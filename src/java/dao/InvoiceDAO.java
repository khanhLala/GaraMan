package dao;

import java.sql.*;
import model.Customer;
import model.Invoice;
import model.Member;

public class InvoiceDAO extends DAO{

    public InvoiceDAO() {
        super();
    }
    
    public Invoice getInvoiceById(int id){
        String sql = "SELECT i.id, i.createAt, i.paymentStatus, "
                + "c.customerId, "
                + "m.name, m.phone, m.email, m.address "
                + "FROM tblInvoice i "
                + "JOIN tblCustomer c on i.tblCustomerid = c.tblMemberid "
                + "JOIN tblMember m on c.tblMemberid = m.id "
                + "WHERE i.id = ?";
        
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                Customer c = new Customer();
                c.setId(rs.getInt("customerId"));
                c.setName(rs.getString("name"));
                c.setPhone(rs.getString("phone"));
                c.setEmail(rs.getString("email"));
                c.setAddress(rs.getString("address"));
                
                Invoice i = new Invoice();
                i.setId(rs.getInt("id"));
                i.setCreateAt(rs.getTimestamp("createAt").toLocalDateTime());
                i.setPaymentStatus(rs.getString("paymentStatus"));
                i.setCustomer(c);
                
                return i;
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return null;
    }
    
    public static void main(String[] args) {
        InvoiceDAO dao = new InvoiceDAO();
        Invoice i = dao.getInvoiceById(1);
        System.out.println(i);
    }
}
