import org.example.ConversionUnit;
import org.junit.jupiter.api.Test;

import java.util.Scanner;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

public class TestBinary {

    Scanner mockScanner = mock(Scanner.class);
    ConversionUnit conversion = new ConversionUnit();

    @Test
    public void testBinary() {
        when(mockScanner.nextLine()).thenReturn("10110110 ");
        conversion.getNumber(mockScanner);

        assertEquals(182, conversion.getDecimalFromBinary(conversion.getUserInputData()));
        verify(mockScanner).nextLine();
    }
}
