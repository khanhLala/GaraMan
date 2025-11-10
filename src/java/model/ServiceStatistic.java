package model;

import java.util.*;
import java.math.*;
import java.time.LocalDateTime;

public class ServiceStatistic extends Service implements ItemStatistic{
    private int soldCount;
    private double total;
    private int invoiceId;
    private LocalDateTime createAt;
    private int customerId;
    private String customerName;

    public ServiceStatistic() {
        super();
    }

    public ServiceStatistic(int soldCount, double total, int useTime, Integer id, String name, double price, String description, String status) {
        super(id, name, price, description, status);
        this.soldCount = soldCount;
        this.total = total;
    }
    
    public ServiceStatistic(Service service) {
        super(service.getId(), 
              service.getName(), 
              service.getPrice(), 
              service.getDescription(), 
              service.getStatus());
    }

    @Override
    public int getSoldCount() {
        return soldCount;
    }

    public void setSoldCount(int soldCount) {
        this.soldCount = soldCount;
    }

    @Override
    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    @Override
    public String toString() {
        return "ServiceStat{" + super.toString() + ", soldCount=" + soldCount + ", total=" + total + '}';
    }

    @Override
    public int getItemId() {
        return this.getId();
    }

    @Override
    public String getItemName() {
        return this.getName();
    }

    @Override
    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    @Override
    public LocalDateTime getCreateAt() {
        return createAt;
    }

    public void setCreateAt(LocalDateTime createAt) {
        this.createAt = createAt;
    }

    @Override
    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    @Override
    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }
    
    
}
