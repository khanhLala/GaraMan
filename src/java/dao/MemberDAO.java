package dao;

import java.sql.*;
import java.time.*;
import model.Member;

public class MemberDAO extends DAO{
    public MemberDAO(){
        super();
    }
    
    public boolean register(Member newMember){
        String sql = "INSERT INTO tblMember (username, password, name, phone, email, address, dob) "
                + "VALUES (? , ?, ?, ?, ?, ?, ?)";
        
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, newMember.getUsername());
            ps.setString(2, newMember.getPassword());
            ps.setString(3, newMember.getName());
            ps.setString(4, newMember.getPhone());
            ps.setString(5, newMember.getEmail());
            ps.setString(6, newMember.getAddress());
            ps.setDate(7, Date.valueOf(newMember.getDob()));    
            ps.executeUpdate();
            
            return true;
        } catch (SQLException e){
            e.printStackTrace();
        }
        return false;
    }
    
    public Member login(Member member){    
        String sql = "SELECT id, username, password "
                + "FROM tblMember "
                + "WHERE username = ? AND password = ?";
        
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, member.getUsername());
            ps.setString(2, member.getPassword());
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                Member loginMember = new Member();
                loginMember.setId(rs.getInt("id"));
                loginMember.setUsername(rs.getString("username"));
                loginMember.setPassword(rs.getString("password"));
                return loginMember;
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        
        return null;
    }
}
