@IsTest
private class AwesomeCalculatorTest {
  @isTest
  private static void testCallout() {
    // this causes a fake response to be generated
    CalculatorCalloutMock mock = new CalculatorCalloutMock();
    Test.setMock(WebServiceMock.class, mock);

    // call the method that invokes a callout
    Double x = 1.0;
    Double y = 2.0;
    Double result = AwesomeCalculator.add(x, y);

    // verify the fake result is returned
    Assert.areEqual(3.0, result, 'result of add operation should be 3');
  }
}
