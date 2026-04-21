package java_usecase.smartpay;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

import java_usecase.smartpay.model.Bill;
import java_usecase.smartpay.model.User;
import java_usecase.smartpay.service.exception.InvalidReadingException;
import java_usecase.smartpay.service.impl.UtilityBillService;

public class Main {
    public static void main(String args[]) {

        Scanner sc = new Scanner(System.in);

        Map<String, User> users = new HashMap<>();
        UtilityBillService service = new UtilityBillService();
        System.out.println("Digital Receipt Generator System");

        while (true) {
            System.out.println("Enter Customer name (or Exit):");
            String name = sc.nextLine();
            if (name.equalsIgnoreCase("exit")) {
                break;
            }

            User user;
            if (!users.containsKey(name)) {
                System.out.print("Enter Initial Reading: ");
                int initial = sc.nextInt();
                sc.nextLine();
                user = new User();
                user.setName(name);
                user.setLastReading(initial);
                users.put(name, user);
            } else {
                user = users.get(name);
                System.out.println("Previous Reading: " + user.getLastReading());
            }
            int curr;
            while (true) {
                System.out.print("Enter Current Reading: ");
                curr = sc.nextInt();
                sc.nextLine();

                try {
                    int units = service.calculateUnits(user.getLastReading(), curr);

                    double base = service.calculateTotal(units);
                    double tax = 0;
                    double total = base + tax;

                    Bill bill = new Bill();
                    bill.setTaxAmount(tax);
                    bill.setTotalAmount(total);
                    bill.setUnitsConsumed(units);
                    user.addBill(bill);

                    user.setLastReading(curr);

                    System.out.println("Receipt:");
                    System.out.println(bill);
                    System.out.println("---------------------------");
                    break;
                } catch (InvalidReadingException e) {
                    System.out.println("Exception:" + e.getMessage());
                } catch (Exception e) {
                    System.out.println("Exception:" + e.getMessage());
                }
            }
        }
        sc.close();
    }

}
