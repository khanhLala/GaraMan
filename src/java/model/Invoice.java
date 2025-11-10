package model;

import java.time.LocalDateTime;
import java.util.List;

public class Invoice {

    private Integer id;
    private LocalDateTime createAt;
    private String paymentStatus;
    private Sales sale;
    private Customer customer;
    private List<ProductInvoiceDetail> productDetail;
    private List<ServiceInvoiceDetail> serviceDetail;

    public Invoice() {
    }

    public Invoice(Integer id, LocalDateTime createAt, String paymentStatus, Sales sale, Customer customer) {
        this.id = id;
        this.createAt = createAt;
        this.paymentStatus = paymentStatus;
        this.sale = sale;
        this.customer = customer;
    }

    public Invoice(Integer id, LocalDateTime createAt, String paymentStatus, Sales sale, Customer customer, List<ProductInvoiceDetail> productDetail, List<ServiceInvoiceDetail> serviceDetail) {
        this.id = id;
        this.createAt = createAt;
        this.paymentStatus = paymentStatus;
        this.sale = sale;
        this.customer = customer;
        this.productDetail = productDetail;
        this.serviceDetail = serviceDetail;
    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public LocalDateTime getCreateAt() {
        return createAt;
    }

    public void setCreateAt(LocalDateTime createAt) {
        this.createAt = createAt;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Sales getSale() {
        return sale;
    }

    public void setSale(Sales sale) {
        this.sale = sale;
    }

    public List<ProductInvoiceDetail> getProductDetail() {
        return productDetail;
    }

    public void setProductDetail(List<ProductInvoiceDetail> productDetail) {
        this.productDetail = productDetail;
    }

    public List<ServiceInvoiceDetail> getServiceDetail() {
        return serviceDetail;
    }

    public void setServiceDetail(List<ServiceInvoiceDetail> serviceDetail) {
        this.serviceDetail = serviceDetail;
    }

    @Override
    public String toString() {
        return "Invoice{" +
                "id=" + id +
                ", createAt=" + createAt +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", sale=" + sale +
                ", customer=" + customer +
                ", productDetail=" + productDetail +
                ", serviceDetail=" + serviceDetail +
                '}';
    }
}


