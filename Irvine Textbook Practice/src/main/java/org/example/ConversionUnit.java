package org.example;

import java.math.BigInteger;
import java.util.Scanner;

public class ConversionUnit {
    private String userInput;

    public ConversionUnit() {
    }

    public void getNumber(Scanner scanner) {

        System.out.print("Enter the number: ");
        userInput = scanner.nextLine().trim();
    }

    public String getUserInputData(){
        return this.userInput;
    }

    public boolean isBinary(String userInput) {
        String binary = "[01]+";

        return userInput.matches(binary);
    }

    public boolean isHex(String userInput) {
        String hex = "[0-9a-fA-F]+";
        return userInput.matches(hex);
    }

    public boolean isDecimal(String userInput) {
        String decimal = "[0-9]+";
        return userInput.matches(decimal);
    }

    public long getDecimalFromBinary(String userInput) {
        int length, power = 0;
        long total = 0;

        length = userInput.length();

        for (int pos = length - 1; pos >= 0; pos--) {
            if (userInput.charAt(pos) == '1') {
                total += (int) Math.pow(2, power);
            }
            power++;
        }

        return total;
    }

    public BigInteger getDecimalFromHexadecimal(String userInput) {

        return new BigInteger(userInput, 16);
    }

    public String getBinaryFromDecimal(String userInput) {

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

    public String getHexadecimalFromDecimal(String userInput) {

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
