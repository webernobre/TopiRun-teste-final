/**
 * @author walmeida
 */
public class PutAccountAddressTransformer {

    public PutAccountAddressRequest toRequest(Account account){
        PutAccountAddressRequest request = new PutAccountAddressRequest();
        request.billingAddress = new PutAccountAddressRequest.billingAddress();
        request.shippingAddress = new PutAccountAddressRequest.shippingAddress();
        request.externalId = account.Id;
        request.name = account.name;
        request.billingAddress.street = account.BillingStreet;
        request.billingAddress.city = account.BillingCity;
        request.billingAddress.zipCode = account.BillingPostalCode;
        request.billingAddress.state = account.BillingState;
        request.billingAddress.country = account.BillingCountry;
        request.shippingAddress.street = account.ShippingStreet;
        request.shippingAddress.city = account.ShippingCity;
        request.shippingAddress.zipCode = account.ShippingPostalCode;
        request.shippingAddress.state = account.ShippingState;
        request.shippingAddress.country = account.ShippingCountry;

        return request;

    }

    public Account toAccountFromRequest(PutAccountAddressRequest request){
        Account account = new Account();
        account.Id = request.externalId;
        account.name = request.name;
        account.BillingStreet = request.billingAddress.street;
        account.BillingCity = request.billingAddress.city;
        account.BillingPostalCode = request.billingAddress.zipCode;
        account.BillingState = request.billingAddress.state;
        account.BillingCountry = request.billingAddress.country;
        account.ShippingStreet = request.shippingAddress.street;
        account.ShippingCity = request.shippingAddress.city;
        account.ShippingPostalCode = request.shippingAddress.zipCode;
        account.ShippingState = request.shippingAddress.state;
        account.ShippingCountry = request.shippingAddress.country;

        return account;

    }
}