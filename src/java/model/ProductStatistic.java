package model;

import java.time.LocalDateTime;
import java.util.*;

public class ProductStatistic extends Product implements ItemStatistic{
    private int soldCount;
    private double total;
    private int invoiceId;
    private LocalDateTime createAt;
    private int customerId;
    private String customerName;

    public ProductStatistic() {
    }
    
    public ProductStatistic(Product product) {
        super(product.getId(), 
              product.getName(), 
              product.getPrice(), 
              product.getDescription(), 
              product.getStatus(),
              product.getQuantity());
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
    public int getSoldCount() {
        return this.soldCount;
    }

    public void setSoldCount(int soldCount) {
        this.soldCount = soldCount;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    @Override
    public double getTotal() {
        return this.total;
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
