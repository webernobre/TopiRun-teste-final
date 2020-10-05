/**
 * @author walmeida
 */
public class CheckChangedAddress {

    public Boolean checkChangedBillingAddress(Account newAccount, Account oldAccount){

        if (newAccount.BillingCity==null && newAccount.BillingCountry==null && newAccount.BillingStreet==null &&
            newAccount.BillingPostalCode==null && newAccount.BillingState==null){
            return false;
        }
        
        if (newAccount.BillingCity!=oldAccount.BillingCity) {
            return true;
        }
        if (newAccount.BillingCountry!=oldAccount.BillingCountry) {
            return true;
        }
        if (newAccount.BillingStreet!=oldAccount.BillingStreet) {
            return true;
        }
        if (newAccount.BillingPostalCode!=oldAccount.BillingPostalCode) {
            return true;
        }
        if (newAccount.BillingState!=oldAccount.BillingState) {
            return true;
        }
        return false;
    }

    public Boolean checkChangedShippingAddress(Account newAccount, Account oldAccount){
        
        if (newAccount.ShippingCity==null && newAccount.ShippingCountry==null && newAccount.ShippingStreet==null &&
            newAccount.ShippingPostalCode==null && newAccount.ShippingState==null){
            return false;
        }

        if (newAccount.ShippingCity!=oldAccount.ShippingCity) {
            return true;
        }
        if (newAccount.ShippingCountry!=oldAccount.ShippingCountry) {
            return true;
        }
        if (newAccount.ShippingStreet!=oldAccount.ShippingStreet) {
            return true;
        }
        if (newAccount.ShippingPostalCode!=oldAccount.ShippingPostalCode) {
            return true;
        }
        if (newAccount.ShippingState!=oldAccount.ShippingState) {
            return true;
        }
        return false;
    }

}