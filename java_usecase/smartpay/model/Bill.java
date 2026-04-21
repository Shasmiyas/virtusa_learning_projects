package java_usecase.smartpay.model;

import java.time.LocalDateTime;

public class Bill {
    private int unitsConsumed;
    private double taxAmount;
    private double totalAmount;
    private LocalDateTime createdOn= LocalDateTime.now();

    public int getUnitsConsumed() {
        return unitsConsumed;
    }

    public void setUnitsConsumed(int unitsConsumed) {
        this.unitsConsumed = unitsConsumed;
    }

    public double getTaxAmount() {
        return taxAmount;
    }

    public void setTaxAmount(double taxAmount) {
        this.taxAmount = taxAmount;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

    @Override
    public String toString() {
        return "Bill [unitsConsumed=" + unitsConsumed + ", taxAmount= $" + taxAmount + ", totalAmount= $" + totalAmount
                + ", createdOn=" + createdOn + "]";
    }

}
