package model;

import java.time.LocalDateTime;

public interface ItemStatistic {
    public int getItemId();
    public String getItemName();
    public int getSoldCount();
    public double getTotal();
    public LocalDateTime getCreateAt();
    public int getInvoiceId();
    public int getCustomerId();
    public String getCustomerName();
}
