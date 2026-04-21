package java_usecase.smartpay.service.impl;

import java_usecase.smartpay.service.exception.InvalidReadingException;
import java_usecase.smartpay.service.interfaces.Billable;

public class UtilityBillService implements Billable {
    public int calculateUnits(int prev, int curr) {
        if (curr < prev) {
            throw new InvalidReadingException(
                    "Current reading cannot be less than previous reading");
        }
        return curr - prev;
    }

    public double calculateTotal(int units) {
        double amount = 0.0;
        if (units < 101) {
            amount = units * 1.00;
        } else if (units > 100 && units < 301) {
            amount = units * 2.00;
        } else {
            amount = units * 5.00;
        }
        return amount;
    }
}
