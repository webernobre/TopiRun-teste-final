/**
 * @author walmeida
 */
public class GetAccountGeolocationOutboundService {

    GetAccountGeolocationTransformer transformer;
    GetTokenGeolocationServices getToken;

    public GetAccountGeolocationOutboundService(){
        transformer = new GetAccountGeolocationTransformer();
        getToken = new GetTokenGeolocationServices();
    }

    virtual
    public List<Account> getGeolocation(List<Account> accounts){

        HttpRequest request = new HttpRequest();
        Http http = new Http();     
        List<Account> returnedAccounts = new List<Account>();

        request.setEndpoint('https://bisso-topirun-20-dev-ed.my.salesforce.com/services/apexrest/api/account/geolocation');
        request.setMethod('PATCH');
        request.setHeader ('Authorization', 'Bearer ' + getToken.getToken());
        request.setHeader('Content-Type', 'application/json');

        request.setBody(JSON.serialize(transformer.toRequest(accounts)));

        HttpResponse response = http.send(request);

        returnedAccounts = transformer.toAccount( (List<GetAccountGeolocationResponse>) JSON.deserialize( response.getBody(), List<GetAccountGeolocationResponse>.class ));
        return returnedAccounts;
        
    }

}