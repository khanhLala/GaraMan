package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Invoice;
import model.Product;
import model.Service;
import model.ServiceInvoiceDetail;

public class ServiceInvoiceDetailDAO extends DAO{

    public ServiceInvoiceDetailDAO() {
        super();
    }
    
    public List<ServiceInvoiceDetail> getAllByInvoice(Invoice i){
        String sql = "SELECT sid.sellprice, sid.quantity, "
                + "s.name "
                + "FROM tblServiceInvoiceDetail sid "
                + "JOIN tblService s ON sid.tblServiceId = s.id "
                + "WHERE sid.tblInvoiceid = ?";
        List<ServiceInvoiceDetail> ans = new ArrayList<>();
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, i.getId());
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                Service s = new Service();
                s.setName(rs.getString("name"));
                
                ServiceInvoiceDetail sid = new ServiceInvoiceDetail();
                sid.setSellprice(rs.getDouble("sellprice"));
                sid.setQuantity(rs.getInt("quantity"));
                sid.setService(s);
                
                ans.add(sid);
                
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return ans;
    }
}
