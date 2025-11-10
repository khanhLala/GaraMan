package model;

import java.time.LocalDateTime;
import java.util.List;

public class InboundInvoice {

    private Integer id;
    private LocalDateTime createAt;
    private String paymentStatus;
    private Warehouseman warehouseman;
    private Provider provider;
    private List<InboundInvoiceDetail> inboundInvoiceDetail;

    public InboundInvoice() {
    }

    public InboundInvoice(Integer id, LocalDateTime createAt, String paymentStatus, Warehouseman warehouseman, Provider provider, List<InboundInvoiceDetail> inboundInvoiceDetail) {
        this.id = id;
        this.createAt = createAt;
        this.paymentStatus = paymentStatus;
        this.warehouseman = warehouseman;
        this.provider = provider;
        this.inboundInvoiceDetail = inboundInvoiceDetail;
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

    public Warehouseman getWarehouseman() {
        return warehouseman;
    }

    public void setWarehouseman(Warehouseman warehouseman) {
        this.warehouseman = warehouseman;
    }

    public Provider getProvider() {
        return provider;
    }

    public void setProvider(Provider provider) {
        this.provider = provider;
    }

    public List<InboundInvoiceDetail> getInboundInvoiceDetail() {
        return inboundInvoiceDetail;
    }

    public void setInboundInvoiceDetail(List<InboundInvoiceDetail> inboundInvoiceDetail) {
        this.inboundInvoiceDetail = inboundInvoiceDetail;
    }

    @Override
    public String toString() {
        return "InboundInvoice{" +
                "id=" + id +
                ", createAt=" + createAt +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", warehouseman=" + warehouseman +
                ", provider=" + provider +
                ", inboundInvoiceDetail=" + inboundInvoiceDetail +
                '}';
    }
}


