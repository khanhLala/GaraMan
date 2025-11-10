package model;

public class ProductInvoiceDetail {

    private Integer id;
    private double sellprice;
    private Integer quantity;
    private Product product;

    public ProductInvoiceDetail() {
    }

    public ProductInvoiceDetail(Integer id, double sellprice, Integer quantity, Product product) {
        this.id = id;
        this.sellprice = sellprice;
        this.quantity = quantity;
        this.product = product;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public double getSellprice() {
        return sellprice;
    }

    public void setSellprice(double sellprice) {
        this.sellprice = sellprice;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}


