/**
 * @author walmeida
 */
@isTest
public with sharing class PutAccountAddressOutboundServiceTest {
    @isTest
    public static void givenAccountAddressWhenChangeAddressThenCallService(){
        String requestSample = '{"name": "Teste do Bisso","billingAddress" : {"street": "Rua Pedro Dias Batista 70","city": "Águas de Santa Bárbara","zipCode": "18770-970","state": "SP","country": "Brasil"},"shippingAddress" : {"street": "Rua Coronel Honório Palma 135","city": "Altinópolis","zipCode": "14350-970","state": "SP","country": "Brasil"}}';
        String payloadtoken='{"access_token": "00D4W0000048AiQ!AQoAQKgVN6E4i3uIec7RcHjSHfFcknDSEU6D2QKFybFmMrW566TwI1YxcA0aEEeVVsvfAUaUHv5r1PAZzPaFfPQ.XuImOXGt","instance_url": "https://bisso-topirun-20-dev-ed.my.salesforce.com","id": "https://login.salesforce.com/id/00D4W0000048AiQUAU/0054W00000B99edQAB","token_type": "Bearer","issued_at": "1601639269587","signature": "Y4PFBhk+5IhmznVJobqlK6rK8ggSOD41seY4auvYJzA="}';
        String payloadsuccess='{}';
        String payloaderror = '{"errorCode": "APEX_ERROR","message": "Error Message"}';
        
        PutAccountAddressTransformer transformer = new PutAccountAddressTransformer();
        Map<String, HttpCalloutMock> endpoints = new Map<String,HttpCalloutMock>();
        PutAccountAddressOutboundService service = new PutAccountAddressOutboundService();

        PutAccountAddressFailHttpMock responseAddressErro =  new PutAccountAddressFailHttpMock(payloaderror);
        GetTokenGeolocationServicesTest.GetTokenSuccessHttpMock responseToken = new GetTokenGeolocationServicesTest.GetTokenSuccessHttpMock(payloadtoken);
        PutAccountAddressResponse response;
        Account account = transformer.toAccountFromRequest((PutAccountAddressRequest) 
                                                            JSON.deserialize(requestSample, PutAccountAddressRequest.class));

        endpoints.put('https://bisso-topirun-20-dev-ed.my.salesforce.com/services/apexrest/api/account/geolocation',responseAddressErro);
        endpoints.put('https://login.salesforce.com/services/oauth2/token',responseToken);
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoints);

        account = AccountFixtureFactory.createAccount(account);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        
        response = service.publishAddress(account.Id);
        System.assertEquals('Error Message', response.message);

        endpoints.remove('https://bisso-topirun-20-dev-ed.my.salesforce.com/services/apexrest/api/account/geolocation');
        try {
            response = service.publishAddress(account.Id);
        } catch (MultiRequestMock.MultiMockException e) {
            System.assertEquals('HTTP callout not supported for test methods', e.getMessage());
        }

        PutAccountAddressSuccessHttpMock responseAddress =  new PutAccountAddressSuccessHttpMock(payloadsuccess);
        endpoints.put('https://bisso-topirun-20-dev-ed.my.salesforce.com/services/apexrest/api/account/geolocation',responseAddress);
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        response = service.publishAddress(account.Id);
       
        Test.stopTest();
    }

    public class PutAccountAddressSuccessHttpMock implements HttpCalloutMock{
        String payload;

        public PutAccountAddressSuccessHttpMock (String payload){
            this.payload = payload;
        }

        public HttpResponse respond (HttpRequest request){
            HttpResponse response = new HttpResponse();
            response.setBody(payload);
            response.setStatusCode(200);
            return response;
        }
    }


    public class PutAccountAddressFailHttpMock implements HttpCalloutMock{
        String payload;

        public PutAccountAddressFailHttpMock (String payload){
            this.payload = payload;
        }

        public HttpResponse respond (HttpRequest request){
            HttpResponse response = new HttpResponse();
            response.setBody(payload);
            response.setStatusCode(400);
            return response;
        }
    }

}