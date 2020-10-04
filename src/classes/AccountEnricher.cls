/**
 * @author walmeida
 */
public class AccountEnricher {
    
    AccountTransform transform;
    AccountFilter filter;

    public AccountEnricher(){
        this.transform = new AccountTransform();
        this.filter = new AccountFilter();
    }

    virtual
    public List<Account> formatCpf( List<Account> accounts, List<Account> filteredAccounts){

        for(Account account : accounts){
            if (filteredAccounts.contains(account)){
                account.Cpf__c = transform.toCpfFormated(account.Cpf__c);
            }
        }

        return accounts;

    }

    virtual
    public List<Account> formatCnpj( List<Account> accounts, List<Account> filteredAccounts){

        for(Account account : accounts){
            if (filteredAccounts.contains(account)){
                account.Cnpj__c = transform.toCnpjFormated(account.Cnpj__c);
            }
        }

        return accounts;

    }

    virtual
    public List<Account> formatBillingPostalCode( List<Account> accounts, List<Account> filteredAccounts){

        for(Account account : accounts){
            if (filteredAccounts.contains(account)){
                account.BillingPostalCode = transform.toCepFormated(account.BillingPostalCode);
            }
        }

        return accounts;

    }

    virtual
    public List<Account> formatShippingPostalCode( List<Account> accounts, List<Account> filteredAccounts){

        for(Account account : accounts){
            if (filteredAccounts.contains(account)){
                account.ShippingPostalCode = transform.toCepFormated(account.ShippingPostalCode);
            }
        }

        return accounts;

    }


}