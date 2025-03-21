package org.example;

import java.math.BigInteger;
import java.util.InputMismatchException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {

        boolean continueProgram = true;
        int choice = 0;
        BigInteger convertedValue = BigInteger.valueOf(0);
        String convertedString = "";
        Scanner scanner = new Scanner(System.in);

        var conversionUnit = new ConversionUnit();

        do {

            boolean validType = true;

            do {
                try {
                    System.out.println("Welcome to the Unit Conversion Calculator");
                    System.out.println("1. Binary to Decimal\n2. Hexadecimal to Decimal" +
                            "\n3. Decimal to Binary\n4. Decimal to Hexadecimal\n9. Exit");
                    System.out.print("Enter your choice: ");
                    choice = scanner.nextInt();
                    scanner.nextLine();

                } catch (InputMismatchException e) {
                    System.out.println("Please enter an integer.");
                    System.out.print("Press enter to continue...");
                    scanner.nextLine();
                    scanner.nextLine();
                    validType = false;
                }

                if (choice == 9) {
                    break;
                }

            } while ((choice < 1 || choice > 4) && !validType);

            if (choice != 9) {

                boolean validInput = true;
                do {
                    conversionUnit.getNumber(scanner);

                    if (choice == 1){
                        validInput = conversionUnit.isBinary(conversionUnit.getUserInputData());
                    } else if (choice == 2){
                        validInput = conversionUnit.isHex(conversionUnit.getUserInputData());
                    } else {
                        validInput = conversionUnit.isDecimal(conversionUnit.getUserInputData());
                    }

                    if (!validInput) {
                        System.out.println("Please enter a valid number. Try again.");
                    }

                } while (!validInput);
            } else {
                break;
            }

            switch (choice){
                case 1:
                    convertedValue = BigInteger.valueOf(conversionUnit.getDecimalFromBinary(conversionUnit.getUserInputData()));
                    break;
                case 2:
                    convertedValue = conversionUnit.getDecimalFromHexadecimal(conversionUnit.getUserInputData());
                    break;
                case 3:
                    convertedString = conversionUnit.getBinaryFromDecimal(conversionUnit.getUserInputData());
                    break;
                case 4:
                    convertedString = conversionUnit.getHexadecimalFromDecimal(conversionUnit.getUserInputData());
                    break;
                default: System.out.println("Invalid choice. Please try again.");
            }

            if (choice == 1 || choice == 2) {
                System.out.println("The decimal value of " + conversionUnit.getUserInputData() + " is "
                        + convertedValue);
            } else if (choice == 3) {
                System.out.println("The binary string of " + conversionUnit.getUserInputData() + " is "
                        + convertedString);
            } else {
                System.out.println("The hexadecimal string of " + conversionUnit.getUserInputData() + " is "
                        + convertedString);
            }

            System.out.println("\nDo you want to continue? (Y/N)");
            continueProgram = scanner.nextLine().toUpperCase().trim().charAt(0) == 'Y';

        } while (continueProgram);

        System.out.println("\n***************************************************");
        System.out.println("Thank you for using the Unit Conversion Calculator");
        System.out.println("***************************************************\n");
        scanner.close();
    }
}