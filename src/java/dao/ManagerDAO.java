package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Manager;

public class ManagerDAO extends DAO{
    public ManagerDAO(){
        super();
    }
    
    public Manager getById(int id){
        String sql = "SELECT m.id, m.username, m.name, m.email, m.phone, m.address, m.dob, " +
                "s.position, s.status " +
                "FROM tblMember m " +
                "JOIN tblStaff s ON m.id = s.tblMemberid " +
                "JOIN tblManager mn ON s.tblMemberid = mn.tblStaffid " +
                "WHERE m.id = ?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Manager manager = new Manager();
                manager.setId(id);
                manager.setUsername(rs.getString("username"));
                manager.setName(rs.getString("name"));
                manager.setEmail(rs.getString("email"));
                manager.setPhone(rs.getString("phone"));
                manager.setAddress(rs.getString("address"));
                manager.setDob(rs.getDate("dob").toLocalDate());
                manager.setPosition(rs.getString("position"));
                manager.setStatus(rs.getString("status"));

                return manager;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    public static void main() {
        ManagerDAO dao = new ManagerDAO();
        Manager manager = dao.getById(5);
        System.out.println(manager);
    }
}
