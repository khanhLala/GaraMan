package dao;

import model.Customer;
import java.sql.*;

public class CustomerDAO extends DAO{
    public CustomerDAO(){
        super();
    }
    
    public Customer getById(int id){    
        String sql = "SELECT m.id, m.username, m.name, m.email, m.phone, m.address, m.dob, c.customerId "
                    + "FROM tblCustomer c "
                    + "JOIN tblMember m on c.tblMemberId = m.id "
                    + "WHERE c.tblMemberId = ?";
        
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return new Customer(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("name"), 
                        rs.getString("email"), 
                        rs.getString("phone"), 
                        rs.getString("address"),
                        rs.getDate("dob").toLocalDate(),
                        rs.getInt("customerId")
                );
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        
        return null;
    }
    
    public Customer getCustomerInfo(int id){
        Customer currentCustomer = new Customer();
        
        String sql = "SELECT m.username, m.name, m.email, m.phone, m.address " +
                     "FROM tblCustomer c " +
                     "JOIN tblMember m ON c.tblMemberId = m.id " +
                     "WHERE c.tblMemberId = ?";
        
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                currentCustomer.setId(rs.getInt("id"));
                currentCustomer.setUsername(rs.getString("username"));
                currentCustomer.setName(rs.getString("name"));
                currentCustomer.setEmail(rs.getString("email"));
                currentCustomer.setPhone(rs.getString("phone"));
                currentCustomer.setAddress(rs.getString("address"));
                return currentCustomer;
                }
            } catch (SQLException e){
                e.printStackTrace();
            }
       
        return currentCustomer;
    }
}
