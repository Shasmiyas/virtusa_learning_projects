package java_usecase.smartpay.model;

import java.util.LinkedList;

public class User {
    private String name;
    private LinkedList<Bill> bills = new LinkedList<Bill>();
    private int lastReading=0;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public LinkedList<Bill> getBills() {
        return bills;
    }

    public void setBills(LinkedList<Bill> bills) {
        this.bills = bills;
    }

    public void addBill(Bill bill) {
        bills.add(bill);
    }
    public void setLastReading(int units){
        this.lastReading=units;
    }
    public int getLastReading(){
        return lastReading;
    }

    @Override
    public String toString() {
        return "User [name=" + name + ", bills=" + bills + ", lastReading=" + lastReading + "]";
    }

   

}
