package org.example;

import java.math.BigInteger;
import java.util.Scanner;

public class ConversionUnit {
    private String userInput;

    ConversionUnit() {
    }

    void getNumber(Scanner scanner) {

        System.out.print("Enter the number: ");
        userInput = scanner.nextLine().trim();
    }

    public String getUserInputData(){
        return this.userInput;
    }

    boolean isBinary(String userInput) {
        String binary = "[01]+";

        return userInput.matches(binary);
    }

    boolean isHex(String userInput) {
        String hex = "[0-9a-fA-F]+";
        return userInput.matches(hex);
    }

    boolean isDecimal(String userInput) {
        String decimal = "[0-9]+";
        return userInput.matches(decimal);
    }

    int getDecimalFromBinary(String userInput) {
        int value, total = 0, position = 0;

        long convertedLong = Long.parseLong(userInput);

        while (convertedLong != 0) {
            value = (int) (convertedLong % 2) ;
            total += value * (int) Math.pow(2, position);
            convertedLong = convertedLong / 10;
            position++;
        }

        return total;
    }

    BigInteger getDecimalFromHexadecimal(String userInput) {

        return new BigInteger(userInput, 16);
    }

    String getBinaryFromDecimal(String userInput) {

        StringBuilder binary = new StringBuilder();
        int remainder;

        BigInteger convertedLong = BigInteger.valueOf(Long.parseLong(userInput));

        while (convertedLong.longValue() != 0) {

            remainder= (int) (convertedLong.longValue() % 2);
            binary.append(remainder);
            convertedLong = BigInteger.valueOf(convertedLong.longValue() / 2);
        }

        return binary.reverse().toString();
    }

    String getHexadecimalFromDecimal(String userInput) {

        StringBuilder hexadecimal = new StringBuilder();
        int remainder;
        char remainderChar;

        BigInteger convertedLong = BigInteger.valueOf(Long.parseLong(userInput));

        while (convertedLong.longValue() != 0) {

            remainder= (int) (convertedLong.longValue() % 16);
            if (remainder > 9){
                remainderChar = (char) (remainder + 55);
                hexadecimal.append(remainderChar);
            } else {
                hexadecimal.append(remainder);
            }

            convertedLong = BigInteger.valueOf(convertedLong.longValue() / 16);
        }

        return hexadecimal.reverse().toString();
    }
}
