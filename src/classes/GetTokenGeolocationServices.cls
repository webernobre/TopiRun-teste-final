/**
 * @author walmeida
 */
public class GetTokenGeolocationServices {

    GetTokenGeolocationTransformer transformer;

    public GetTokenGeolocationServices(){
        transformer = new getTokenGeolocationTransformer();
    }

    virtual
    public String getToken(){

        Map<String,String> oauthRequest = new Map<String,String>();
        String token;

        oauthRequest.put('client_id', '3MVG9l2zHsylwlpS6h2vTmlmUGQBhdenOwDRCOFn28Edf9ajwCJ3THJs1OvxrZPVNucENmEJb.7paFUCK3Kqr');
        oauthRequest.put('client_secret', 'BFC7A19775AA64B697A6F712F62E2D0A671321BBA2FAE18973580F4557F5FC68');
        oauthRequest.put('redirect_uri', 'http://localhost');
        oauthRequest.put('grant_type', 'password');
        oauthRequest.put('username', 'integration.user@topirun.com');
        oauthRequest.put('password', '@TopiRun2020');

        Http http = new Http();
        HttpResponse response = http.send(buildRequest(oauthRequest));
        if (response.getStatusCode()!=200){
            throw new CalloutException('Falha no login');
        }

        token = transformer.toToken((GetTokenGeolocationServicesResponse) JSON.deserialize(response.getBody() 
                                                                            ,GetTokenGeolocationServicesResponse.class));
        return token;




    }
    
    private HttpRequest buildRequest ( Map<String,String> oauthRequest) {

        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setBody ( buildPostFormParameters (oauthRequest) );

        return request;
    
    }
    
    
    private String buildPostFormParameters ( Map<String,String> oauthRequest ) {
    
        String parameters = '';
    
        for ( String parameterName : oauthRequest.keySet() ) {
    
            if (oauthRequest.get( parameterName ) == null) continue;
    
            parameters += parameterName + '=' + EncodingUtil.urlEncode( oauthRequest.get( parameterName ), 'UTF-8') + '&';
        }
    
        return parameters;
    
    }

}