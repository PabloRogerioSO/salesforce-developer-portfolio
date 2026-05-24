public with sharing class AccountWeatherController {
    
    @AuraEnabled(cacheable=true)
    public static String getWeatherByCity(String cityName) {
        if (String.isBlank(cityName)) {
            throw new AuraHandledException('City name cannot be empty.');
        }

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('callout:OpenWeatherAPI/weather?q=' + EncodingUtil.urlEncode(cityName, 'UTF-8') + '&units=metric');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');

        try {
            HttpResponse response = http.send(request);
            
            if (response.getStatusCode() == 200) {
                return response.getBody();
            } else {
                throw new AuraHandledException('Error from Weather API. Status Code: ' + response.getStatusCode());
            }
        } catch (Exception e) {
            // Captura falhas de conexão ou timeouts e envia de forma limpa para a UI
            throw new AuraHandledException('Failed to connect to Weather Service: ' + e.getMessage());
        }
    }
}