package model;

public class ServiceInvoiceDetail {
    private Integer id;
    private double sellprice;
    private Integer quantity;
    private Service service;

    public ServiceInvoiceDetail() {
    }

    public ServiceInvoiceDetail(Integer id, double sellprice, Integer quantity, Service service) {
        this.id = id;
        this.sellprice = sellprice;
        this.quantity = quantity;
        this.service = service;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public double getSellprice() {
        return sellprice;
    }

    public void setSellprice(double sellprice) {
        this.sellprice = sellprice;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    @Override
    public String toString() {
        return "ServiceInvoiceDetail{" +
                "id=" + id +
                ", sellprice=" + sellprice +
                ", quantity=" + quantity +
                ", service=" + service +
                '}';
    }
}
