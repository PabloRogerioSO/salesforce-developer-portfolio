@isTest
global class AccountWeatherMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"main": {"temp": 25.5}, "weather": [{"description": "clear sky"}]}');
        response.setStatusCode(200);
        return response;
    }
}