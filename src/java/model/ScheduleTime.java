package model;

import java.time.LocalDate;
import java.time.LocalTime;

public class ScheduleTime {

    private Integer id;
    private LocalDate date;
    private LocalTime start;
    private LocalTime end;
    private String status;

    public ScheduleTime() {
    }

    public ScheduleTime(Integer id, LocalDate date, LocalTime start, LocalTime end, String status) {
        this.id = id;
        this.date = date;
        this.start = start;
        this.end = end;
        this.status = status;
    }

    public ScheduleTime(LocalDate date, LocalTime start, LocalTime end) {
        this.date = date;
        this.start = start;
        this.end = end;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public LocalTime getStart() {
        return start;
    }

    public void setStart(LocalTime start) {
        this.start = start;
    }

    public LocalTime getEnd() {
        return end;
    }

    public void setEnd(LocalTime end) {
        this.end = end;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "ScheduleTime{" + "id=" + id + ", date=" + date + ", start=" + start + ", end=" + end + ", status=" + status + '}';
    }

    
    
    
}


