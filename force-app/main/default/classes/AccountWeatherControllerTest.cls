@isTest
private class AccountWeatherControllerTest {
    
    @isTest
    static void testGetWeatherSuccess() {
        Test.setMock(HttpCalloutMock.class, new AccountWeatherMock());
        
        Test.startTest();
        String result = AccountWeatherController.getWeatherByCity('Sao Paulo');
        Test.stopTest();
        
        Assert.isNotNull(result, 'The result should not be null');
        Assert.isTrue(result.contains('25.5'), 'The JSON should contain the mocked temperature');
    }

    @isTest
    static void testGetWeatherEmptyCity() {
        try {
            AccountWeatherController.getWeatherByCity('');
            Assert.fail('The method should have thrown an exception for an empty city name');
        } catch (AuraHandledException e) {
            Assert.isTrue(e.getMessage().contains('Script-thrown exception'), 'Expected error message');
        }
    }
}