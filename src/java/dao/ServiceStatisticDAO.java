package dao;

import static dao.DAO.con;
import model.ServiceStatistic;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import model.Service;

public class ServiceStatisticDAO extends DAO {

    public ServiceStatisticDAO() {
        super();
    }

    public List<ServiceStatistic> getByDate(Date start, Date end) {
        List<ServiceStatistic> ans = new ArrayList<>();
        String sql = "SELECT s.id, s.name, s.price, s.description, s.status, "
                + "SUM(sid.quantity) as soldCount, "
                + "SUM(sid.sellprice * sid.quantity) AS total "
                + "FROM tblService s "
                + "JOIN tblServiceInvoiceDetail sid ON s.id = sid.tblServiceid "
                + "JOIN tblInvoice i ON sid.tblInvoiceid = i.id "
                + "WHERE i.createAt >= ? AND i.createAt < DATE_ADD(?, INTERVAL 1 DAY) "
                + "GROUP BY s.id, s.name, s.price, s.status, s.description "
                + "ORDER BY total DESC, soldCount DESC";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDate(1, start);
            ps.setDate(2, end);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ServiceStatistic serviceStat = new ServiceStatistic();
                serviceStat.setId(rs.getInt("id"));
                serviceStat.setName(rs.getString("name"));
                serviceStat.setPrice(rs.getDouble("price"));
                serviceStat.setDescription(rs.getString("description"));
                serviceStat.setStatus(rs.getString("status"));
                serviceStat.setSoldCount(rs.getInt("soldCount"));
                serviceStat.setTotal(rs.getDouble("total"));

                ans.add(serviceStat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ans;
    }

    public List<ServiceStatistic> getUseTime(Service service, Date start, Date end) {
        List<ServiceStatistic> ans = new ArrayList<>();

        String sql = "SELECT s.id, s.name, s.description, s.status, s.price, "
                + "sid.quantity AS soldCount, "
                + "(sid.sellprice * sid.quantity) AS total, "
                + "i.id as invoiceId, i.createAt, "
                + "c.tblMemberid AS customerId, m.name AS customerName "
                + "FROM tblService s "
                + "JOIN tblServiceInvoiceDetail sid ON s.id = sid.tblServiceid "
                + "JOIN tblInvoice i ON sid.tblInvoiceid = i.id "
                + "JOIN tblCustomer c ON i.tblCustomerid = c.tblMemberid "
                + "JOIN tblMember m ON c.tblMemberid = m.id "
                + "WHERE s.id = ? "
                + "AND i.createAt >= ? "
                + "AND i.createAt < DATE_ADD(?, INTERVAL 1 DAY) "
                + "ORDER BY i.createAt DESC";

        try {
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, service.getId());
            ps.setDate(2, start);
            ps.setDate(3, end);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ServiceStatistic serviceStat = new ServiceStatistic(service);

                serviceStat.setSoldCount(rs.getInt("soldCount"));
                serviceStat.setTotal(rs.getDouble("total"));
                serviceStat.setInvoiceId(rs.getInt("invoiceId"));
                serviceStat.setCreateAt(rs.getTimestamp("createAt").toLocalDateTime());
                serviceStat.setCustomerId(rs.getInt("customerId"));
                serviceStat.setCustomerName(rs.getString("customerName"));

                ans.add(serviceStat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ans;
    }
}
