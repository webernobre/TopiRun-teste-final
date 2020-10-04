/**
 * @author walmeida
 */
@isTest
public class AccountFixtureFactory {
    
    
    public static Account newAccount(String name, String cpf, String cnpj)  {
        return new Account (Name = name,
                            Cpf__c = cpf,
                            Cnpj__c = cnpj
                            );
    }


    public static Account createAccount(String name, String cpf, String cnpj)  {

        return createAccount ( newAccount(name, cpf, cnpj));
    
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