/**
 * @author walmeida
 */
@isTest
public class CheckChangedAddressTest {

    @isTest
    static void givenAddressWhenCreateOrUpdateAccountThenCheckIfIsChanged(){
        
        CheckChangedAddress checkAddress = new CheckChangedAddress();
        Account oldAccount;
        Account account = AccountFixtureFactory.newAccount('Teste Endereço');
        System.assert(checkAddress.checkChangedBillingAddress(account, null)==false);
        System.assert(checkAddress.checkChangedShippingAddress(account, null)==false);
        oldAccount = account.clone();
        account.BillingCity='cidade teste';
        account.ShippingCity='cidade teste';
        System.assert(checkAddress.checkChangedBillingAddress(account, oldAccount)==true);
        System.assert(checkAddress.checkChangedShippingAddress(account, oldAccount)==true);
        oldAccount = account.clone();
        account.BillingCountry='país teste';
        account.ShippingCountry='país teste';
        System.assert(checkAddress.checkChangedBillingAddress(account, oldAccount)==true);
        System.assert(checkAddress.checkChangedShippingAddress(account, oldAccount)==true);
        oldAccount = account.clone();
        account.BillingStreet='rua teste';
        account.ShippingStreet='rua teste';
        System.assert(checkAddress.checkChangedBillingAddress(account, oldAccount)==true);
        System.assert(checkAddress.checkChangedShippingAddress(account, oldAccount)==true);
        oldAccount = account.clone();
        account.BillingPostalCode='44444-777';
        account.ShippingPostalCode='44444-777';
        System.assert(checkAddress.checkChangedBillingAddress(account, oldAccount)==true);
        System.assert(checkAddress.checkChangedShippingAddress(account, oldAccount)==true);
        oldAccount = account.clone();
        account.BillingState='estado teste';
        account.ShippingState='estado teste';
        System.assert(checkAddress.checkChangedBillingAddress(account, oldAccount)==true);
        System.assert(checkAddress.checkChangedShippingAddress(account, oldAccount)==true);
        oldAccount = account.clone();
        System.assert(checkAddress.checkChangedBillingAddress(account, oldAccount)==false);
        System.assert(checkAddress.checkChangedShippingAddress(account, oldAccount)==false);
    }

}