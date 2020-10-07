/**
 * @author walmeida
 */
@isTest
public class AccountTHTest {

    @isTest
    static void givenCpfCnpjandPostalCodeWhenCreateOrUpdateAccountThenValidateAndFormat(){
        List<Account> account = new List<Account>();
        AccountRepository repository = new AccountRepository();
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, prepareMock(false));
        account.add(AccountFixtureFactory.newAccount('Teste 1', '63042326080', '27071665000142'));
        account.get(0).BillingPostalCode='73086435';
        account.get(0).ShippingPostalCode='73086435';
        
        account.add(0, AccountFixtureFactory.createAccount(account.get(0)));

        account = repository.findById(account.get(0).Id);

        System.assertEquals('630.423.260-80', account.get(0).Cpf__c);
        System.assertEquals('27.071.665/0001-42', account.get(0).Cnpj__c);

        
        account.get(0).Cpf__c='57076258013';
        account.get(0).Cnpj__c='94844706000183';

        account = AccountFixtureFactory.updateAccount(account);
        account = repository.findById(account.get(0).Id);
        System.assertEquals('570.762.580-13', account.get(0).Cpf__c);
        System.assertEquals('94.844.706/0001-83', account.get(0).Cnpj__c);

        
        account.get(0).ShippingPostalCode='89216410';
        account = AccountFixtureFactory.updateAccount(account);
        account = repository.findById(account.get(0).Id);
        System.assertEquals('89216-410', account.get(0).ShippingPostalCode);

        account.get(0).Cpf__c='';
        account.get(0).Cnpj__c='';

        account = AccountFixtureFactory.updateAccount(account);
        account = repository.findById(account.get(0).Id);
        System.assertEquals('89216-410', account.get(0).ShippingPostalCode);
        account.get(0).BillingPostalCode='89216410';
        account = AccountFixtureFactory.updateAccount(account);
        account = repository.findById(account.get(0).Id);
        System.assertEquals('89216-410', account.get(0).BillingPostalCode);

        account.clear();
        Test.setMock(HttpCalloutMock.class, prepareMock(true));
        account.add(AccountFixtureFactory.createAccount('Teste 2 ', '64509732007', '04068740000110'));
        account = repository.findById(account.get(0).Id);
        System.assertEquals('645.097.320-07', account.get(0).Cpf__c);
        System.assertEquals('04.068.740/0001-10', account.get(0).Cnpj__c);
        System.debug(account.get(0));

        Test.stopTest();

    }

    @isTest
    static void givenInvalidCpfOrCnpjWhenCreateOrUpdateAccountThenCheckError() {
        
        
        List<Account> account = new List<Account>();


        try{
            account.add(AccountFixtureFactory.createAccount('Teste 1', '6304232608', '2707166500014'));
        }catch(Exception e){
            System.assert(e.getMessage().contains('Insert failed'));

        }

        try{
            account.add(AccountFixtureFactory.createAccount('Teste 1', '63042326080', '270716650001'));
        }catch(Exception e){
            System.assert(e.getMessage().contains('Insert failed'));

        }

        try{
            account.add(AccountFixtureFactory.createAccount('Teste 1', '63042326080', '1111111111111'));
        }catch(Exception e){
            System.assert(e.getMessage().contains('Insert failed'));

        }

    }

    private static HttpCalloutMock prepareMock(Boolean error){
        Map<String, HttpCalloutMock> endpoints = new Map<String,HttpCalloutMock>();
        String payloadtoken='{"access_token": "00D4W0000048AiQ!AQoAQKgVN6E4i3uIec7RcHjSHfFcknDSEU6D2QKFybFmMrW566TwI1YxcA0aEEeVVsvfAUaUHv5r1PAZzPaFfPQ.XuImOXGt","instance_url": "https://bisso-topirun-20-dev-ed.my.salesforce.com","id": "https://login.salesforce.com/id/00D4W0000048AiQUAU/0054W00000B99edQAB","token_type": "Bearer","issued_at": "1601639269587","signature": "Y4PFBhk+5IhmznVJobqlK6rK8ggSOD41seY4auvYJzA="}';
        String payloadPutAddress='{}';
        String payloaderror = '{"errorCode": "APEX_ERROR","message": "Error Message"}';

        GetTokenGeolocationServicesTest.GetTokenSuccessHttpMock responseToken = new GetTokenGeolocationServicesTest.GetTokenSuccessHttpMock(payloadtoken);
        PutAccountAddressOutboundServiceTest.PutAccountAddressSuccessHttpMock responseAddress =  new PutAccountAddressOutboundServiceTest.PutAccountAddressSuccessHttpMock(payloadPutAddress);
        PutAccountAddressOutboundServiceTest.PutAccountAddressFailHttpMock responseAddressErro =  new PutAccountAddressOutboundServiceTest.PutAccountAddressFailHttpMock(payloaderror);
        endpoints.put('https://login.salesforce.com/services/oauth2/token',responseToken);

        if (error){
            endpoints.put('https://bisso-topirun-20-dev-ed.my.salesforce.com/services/apexrest/api/account/geolocation',responseAddressErro);
        }else {
            endpoints.put('https://bisso-topirun-20-dev-ed.my.salesforce.com/services/apexrest/api/account/geolocation',responseAddress);
        }
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoints);
        return multiCalloutMock;
    }

}