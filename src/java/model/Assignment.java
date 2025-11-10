package model;

public class Assignment {

    private Integer id;
    private String note;
    private Technician technician;
    private Invoice invoice;

    public Assignment() {
    }

    public Assignment(Integer id, String note, Technician technician, Invoice invoice) {
        this.id = id;
        this.note = note;
        this.technician = technician;
        this.invoice = invoice;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Technician getTechnician() {
        return technician;
    }

    public void setTechnician(Technician technician) {
        this.technician = technician;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }
}


