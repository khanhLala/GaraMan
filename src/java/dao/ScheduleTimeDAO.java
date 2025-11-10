package dao;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import model.ScheduleTime;

public class ScheduleTimeDAO extends DAO {
    public ScheduleTimeDAO(){
        super();
    }
    
    public ScheduleTime getById(Integer id){
        String sql = "SELECT * FROM tblScheduleTime WHERE id = ?";
        
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return new ScheduleTime(
                    rs.getInt("id"),
                    rs.getDate("date").toLocalDate(),
                    rs.getTime("start").toLocalTime(),
                    rs.getTime("end").toLocalTime(),
                    rs.getString("status")
                );
            }
        } catch(SQLException e){
            e.printStackTrace();
        }
        return null;
    }
    
    public List<ScheduleTime> getAllFreeScheduleTime(){
        String sql = "SELECT * FROM tblScheduleTime WHERE status = 'AVAILABLE'";
        List<ScheduleTime> freeTime = new ArrayList<ScheduleTime>();
        
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                freeTime.add(new ScheduleTime(
                    rs.getInt("id"),
                    rs.getDate("date").toLocalDate(),
                    rs.getTime("start").toLocalTime(),
                    rs.getTime("end").toLocalTime(),
                    rs.getString("status")
                ));
            }
        } catch(SQLException e){
            e.printStackTrace();
        }
        return freeTime;
    }
    
    public boolean changeStatus(ScheduleTime time, String status){
        String sql = "UPDATE tblScheduleTime SET status = ? WHERE id = ?";
        
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, time.getId());
            ps.executeUpdate();
            return true;
        } catch(SQLException e){
            e.printStackTrace();
        }
        return false;
    }
}
