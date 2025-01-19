import org.example.ConversionUnit;
import org.junit.jupiter.api.Test;

import java.util.Scanner;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.mockito.Mockito.*;

public class TestBinary {

    Scanner mockScanner = mock(Scanner.class);
    ConversionUnit conversion = new ConversionUnit();

    @Test
    public void testBinaryToGetInputCorrectly() {
        when(mockScanner.nextLine()).thenReturn("10110110 ");
        conversion.getNumber(mockScanner);

        assertEquals("10110110", conversion.getUserInputData());
        verify(mockScanner).nextLine();
    }

    @Test
    public void testBinaryWithCorrectInput() {
        assertEquals(182, conversion.getDecimalFromBinary("10110110"));
    }

    @Test
    public void testBinaryWithIncorrectInput() {
        assertFalse(conversion.isBinary("10119"));
    }

    @Test
    public void testDecimalToBinary() {
        assertEquals("1001101", conversion.getBinaryFromDecimal("77"));
    }
}
