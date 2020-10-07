/**
 * @author walmeida
 */
@isTest
public class GetGeolocationSchedulableTest {

    @isTest
    static void givenAccountWithGeoLocationTrueWhenRunJobThenCallService() {
        String cronExpression = '0 0 0 28 2 ? 2022';
        List<CronTrigger> jobDetail;

        Account account = AccountFixtureFactory.createAccount('Teste Schelude', '63042326080', '27071665000142');
        account.GeolocationRequested__c=true;
        account = AccountFixtureFactory.updateAccount(account);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, prepareMock(account.Id));
        String jobId = System.schedule('Get Geolocations', cronExpression, new GetGeolocationSchedulable());
        jobDetail = [SELECT State, Id FROM CronTrigger WHERE id = :jobId];
        System.assertEquals('WAITING', jobDetail.get(0).State);
        Test.stopTest();        

    }


    private static HttpCalloutMock prepareMock(String id){
        Map<String, HttpCalloutMock> endpoints = new Map<String,HttpCalloutMock>();
        String payloadtoken='{"access_token": "00D4W0000048AiQ!AQoAQKgVN6E4i3uIec7RcHjSHfFcknDSEU6D2QKFybFmMrW566TwI1YxcA0aEEeVVsvfAUaUHv5r1PAZzPaFfPQ.XuImOXGt","instance_url": "https://bisso-topirun-20-dev-ed.my.salesforce.com","id": "https://login.salesforce.com/id/00D4W0000048AiQUAU/0054W00000B99edQAB","token_type": "Bearer","issued_at": "1601639269587","signature": "Y4PFBhk+5IhmznVJobqlK6rK8ggSOD41seY4auvYJzA="}';
        String payloadGetLocation='[{"shippingAddress": {"zipCode": "14350-970","street": "Rua Coronel Honório Palma 135","state": "SP","longitude": -47.37663,"latitude": -21.02352,"country": "Brasil","city": "Altinópolis"},"name": "Teste do Bisso","externalId": "' 
                                    + id + 
                                    '","billingAddress": {"zipCode": "18770-970","street": "Rua Pedro Dias Batista 70","state": "SP","longitude": -49.24069129319908,"latitude": -22.880184142428277,"country": "Brasil","city": "Águas de Santa Bárbara"}}]';

        GetTokenGeolocationServicesTest.GetTokenSuccessHttpMock responseToken = new GetTokenGeolocationServicesTest.GetTokenSuccessHttpMock(payloadtoken);
        GetGeoLocationSuccessHttpMock responseAddress =  new GetGeoLocationSuccessHttpMock(payloadGetLocation);
        endpoints.put('https://login.salesforce.com/services/oauth2/token',responseToken);
        endpoints.put('https://bisso-topirun-20-dev-ed.my.salesforce.com/services/apexrest/api/account/geolocation',responseAddress);
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoints);
        return multiCalloutMock;
    }

    public class GetGeoLocationSuccessHttpMock implements HttpCalloutMock{
        String payload;

        public GetGeoLocationSuccessHttpMock (String payload){
            this.payload = payload;
        }

        public HttpResponse respond (HttpRequest request){
            HttpResponse response = new HttpResponse();
            response.setBody(payload);
            response.setStatusCode(200);
            return response;
        }
    }
}