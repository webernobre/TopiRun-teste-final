/**
 * @author walmeida
 */
public class GetAccountGeolocationTransformer {

    public GetAccountGeolocationRequest toRequest(List<Account> accounts){
        GetAccountGeolocationRequest request = new GetAccountGeolocationRequest();
        request.externalIds = new List<String>();

        for(Account account : accounts){
            request.externalIds.add(account.Id);
        }
        
        return request;

    }

    public List<Account> toAccount(List<GetAccountGeolocationResponse> responses){
        List<Account> accounts = new List<Account>();

        for (GetAccountGeolocationResponse response : responses) {
            accounts.add(new Account(
                                    Id = response.externalId,
                                    BillingLatitude = response.billingAddress.latitude,
                                    BillingLongitude = response.billingAddress.longitude,
                                    ShippingLatitude = response.shippingAddress.latitude,
                                    ShippingLongitude = response.shippingAddress.longitude
                                    ));
            
        }
        return accounts;

    }

}