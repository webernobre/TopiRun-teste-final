/**
 * @author walmeida
 */

public class PutAccountAddressOutboundService {

    PutAccountAddressTransformer transformer;
    GetTokenGeolocationServices getToken;

    public PutAccountAddressOutboundService(){
        transformer = new PutAccountAddressTransformer();
        getToken = new GetTokenGeolocationServices();
    }

    virtual
    public PutAccountAddressResponse publishAddress(String accountId){

        HttpRequest request = new HttpRequest();
        Http http = new Http();     
        AccountRepository accountRepository = new AccountRepository();
        PutAccountAddressResponse errorResponse = new PutAccountAddressResponse();

        request.setEndpoint('https://bisso-topirun-20-dev-ed.my.salesforce.com/services/apexrest/api/account/geolocation');
        request.setMethod('PUT');
        request.setHeader ('Authorization', 'Bearer ' + getToken.getToken());
        request.setBody(JSON.serialize(transformer.toRequest(accountRepository.findWithAddressById(accountId))));

        HttpResponse response = http.send(request);
        if (response.getStatusCode() != 200 ) {
            errorResponse = (PutAccountAddressResponse) JSON.deserialize ( response.getBody() , PutAccountAddressResponse.class); 
        }

        return errorResponse;
        
    }

}