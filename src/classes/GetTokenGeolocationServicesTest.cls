/**
 * @author walmeida
 */
@isTest
public class GetTokenGeolocationServicesTest {

    @isTest
    static void givenCallWhenGetTokenThenGiveToken(){
        String payloadsuccess='{"access_token": "00D4W0000048AiQ!AQoAQKgVN6E4i3uIec7RcHjSHfFcknDSEU6D2QKFybFmMrW566TwI1YxcA0aEEeVVsvfAUaUHv5r1PAZzPaFfPQ.XuImOXGt","instance_url": "https://bisso-topirun-20-dev-ed.my.salesforce.com","id": "https://login.salesforce.com/id/00D4W0000048AiQUAU/0054W00000B99edQAB","token_type": "Bearer","issued_at": "1601639269587","signature": "Y4PFBhk+5IhmznVJobqlK6rK8ggSOD41seY4auvYJzA="}';
        String payloaderror = '{}';

        Test.setMock(HttpCallOutMock.class, new GetTokenSuccessHttpMock(payloadsuccess));
        Test.startTest();
        GetTokenGeolocationServices service = new GetTokenGeolocationServices();
        
        String response = service.getToken();
        System.assertEquals('00D4W0000048AiQ!AQoAQKgVN6E4i3uIec7RcHjSHfFcknDSEU6D2QKFybFmMrW566TwI1YxcA0aEEeVVsvfAUaUHv5r1PAZzPaFfPQ.XuImOXGt'
                            ,response);
        Test.setMock(HttpCallOutMock.class, new GetTokenFailHttpMock(payloaderror));
        try{
            response = service.getToken();

        }catch(CalloutException e ){

            System.assert(true);
        }        
        Test.stopTest();
    }

    public class GetTokenSuccessHttpMock implements HttpCalloutMock{
        String payload;

        public GetTokenSuccessHttpMock (String payload){
            this.payload = payload;
        }

        public HttpResponse respond (HttpRequest request){
            HttpResponse response = new HttpResponse();
            response.setBody(payload);
            response.setStatusCode(200);
            return response;
        }
    }


    public class GetTokenFailHttpMock implements HttpCalloutMock{
        String payload;

        public GetTokenFailHttpMock (String payload){
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