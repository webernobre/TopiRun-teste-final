/**
 * @author walmeida
 */
public class GetTokenGeolocationTransformer {

    public String toToken (GetTokenGeolocationServicesResponse tokenResponse){

        return tokenResponse.access_token;
    
    }

}