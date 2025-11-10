package model;

public class InboundInvoiceDetail {

    private Integer id;
    private double cost;
    private Integer quantity;
    private Product product;

    public InboundInvoiceDetail() {
    }

    public InboundInvoiceDetail(Integer id, double cost, Integer quantity, Product product) {
        this.id = id;
        this.cost = cost;
        this.quantity = quantity;
        this.product = product;
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

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}


