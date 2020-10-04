/**
 * @author walmeida
 */
@isTest
public class AccountTHTest {

    @isTest
    static void givenCpfCnpjandPostalCodeWhenCreateOrUpdateAccountThenValidateAndFormat(){
        List<Account> account = new List<Account>();
        AccountRepository repository = new AccountRepository();

        account.add(AccountFixtureFactory.createAccount('Teste 1', '63042326080', '27071665000142', '71827760', '71827760'));

        account = repository.findById(account.get(0).Id);

        System.assertEquals('630.423.260-80', account.get(0).Cpf__c);
        System.assertEquals('27.071.665/0001-42', account.get(0).Cnpj__c);
        System.assertEquals('71827-760', account.get(0).BillingPostalCode);
        System.assertEquals('71827-760', account.get(0).ShippingPostalCode);

        
        account.get(0).Cpf__c='57076258013';
        account.get(0).Cnpj__c='94844706000183';

        account = AccountFixtureFactory.updateAccount(account);
        account = repository.findById(account.get(0).Id);
        System.assertEquals('570.762.580-13', account.get(0).Cpf__c);
        System.assertEquals('94.844.706/0001-83', account.get(0).Cnpj__c);

        account.get(0).BillingPostalCode='89216410';
        account.get(0).ShippingPostalCode='';
        account = AccountFixtureFactory.updateAccount(account);
        account = repository.findById(account.get(0).Id);
        System.assertEquals('89216-410', account.get(0).BillingPostalCode);

        account.get(0).Cpf__c='';
        account.get(0).Cnpj__c='';
        account.get(0).ShippingPostalCode='89216410';
        account.get(0).BillingPostalCode='';

        account = AccountFixtureFactory.updateAccount(account);
        account = repository.findById(account.get(0).Id);
        System.assertEquals('89216-410', account.get(0).ShippingPostalCode);

    }

    @isTest
    static void givenInvalidCpfOrCnpjWhenCreateOrUpdateAccountThenCheckError() {
        List<Account> account = new List<Account>();
        AccountRepository repository = new AccountRepository();


        try{
            account.add(AccountFixtureFactory.createAccount('Teste 1', '6304232608', '2707166500014', '71827760', '71827760'));
        }catch(Exception e){
            System.assert(e.getMessage().contains('Insert failed'));

        }

        try{
            account.add(AccountFixtureFactory.createAccount('Teste 1', '63042326080', '270716650001', '71827760', '71827760'));
        }catch(Exception e){
            System.assert(e.getMessage().contains('Insert failed'));

        }

        try{
            account.add(AccountFixtureFactory.createAccount('Teste 1', '63042326080', '1111111111111', '71827760', '71827760'));
        }catch(Exception e){
            System.assert(e.getMessage().contains('Insert failed'));

        }

    }
    

}