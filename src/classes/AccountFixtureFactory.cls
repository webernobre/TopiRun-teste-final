/**
 * @author walmeida
 */
@isTest
public class AccountFixtureFactory {
    
    
    public static Account newAccount(String name, String cpf, String cnpj,
                                    String billingPostalCode, String shippingPostalCode )  {
        return new Account (Name = name,
                            Cpf__c = cpf,
                            Cnpj__c = cnpj,
                            BillingPostalCode = billingPostalCode,
                            ShippingPostalCode = shippingPostalCode
                            );
    }


    public static Account createAccount(String name, String cpf, String cnpj,
                                        String billingPostalCode, String shippingPostalCode )  {

        return createAccount ( newAccount(name, cpf, cnpj, billingPostalCode, shippingPostalCode) );
    
    }
    
    public static Account createAccount ( Account account ) {
        insert account;
        return account;
    }

    public static List<Account> updateAccount ( List<Account> accounts ) {
        update accounts;
        return accounts;
    }
}