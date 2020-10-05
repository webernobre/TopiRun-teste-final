/**
 * @author walmeida
 */
public virtual with sharing class AccountTH extends TriggerHandler {

    List<Account> newAccounts;
    
    Map<Id,Account> oldAccounts;

    AccountFilter filter;

    AccountValidator validator;

    AccountEnricher enricher;

    public AccountTH () {
        this ( (List<Account>) Trigger.new, (Map<Id,Account>) Trigger.oldMap );
    }

    public AccountTH (List<Account> newAccounts , Map<Id,Account> oldAccounts) {
        
        this.newAccounts = newAccounts;
        this.oldAccounts = oldAccounts;

        this.filter = new AccountFilter();
        this.validator = new AccountValidator();
        this.enricher = new AccountEnricher();
    
    }

    override
    public void beforeInsert() {
        validateDocument();
        formatFields();
    }

    override
    public void afterInsert() {
        sendAddress();
    }    
    
    override
    public void beforeUpdate() {
        validateDocument();
        formatFields();
    }

    override
    public void afterUpdate() {
        sendAddress();
    }    

    virtual
    public void validateDocument() {

        List<Account> filteredAccounts = this.filter.filterByChangedCpf(newAccounts, oldAccounts);
        this.validator.validateCpf(filteredAccounts);
        filteredAccounts = this.filter.filterByChangedCnpj(newAccounts, oldAccounts);
        this.validator.validateCnpj(filteredAccounts);

    }

    virtual
    public void formatFields(){
        List<Account> filteredAccounts = this.filter.filterByChangedCpf(newAccounts, oldAccounts);
        if (filteredAccounts.size()>0){
            this.newAccounts = this.enricher.formatCpf(newAccounts, filteredAccounts);
        }
        filteredAccounts = this.filter.filterByChangedCnpj(newAccounts, oldAccounts);
        if (filteredAccounts.size()>0){
            this.newAccounts = this.enricher.formatCnpj(newAccounts, filteredAccounts);
        }
        filteredAccounts = this.filter.filterByChangedBillingAddressPostalCode(newAccounts, oldAccounts);
        if (filteredAccounts.size()>0){
            this.newAccounts = this.enricher.formatBillingPostalCode(newAccounts, filteredAccounts);
        }
        filteredAccounts = this.filter.filterByChangedShippingAddressPostalCode(newAccounts, oldAccounts);
        if (filteredAccounts.size()>0){
            this.newAccounts = this.enricher.formatShippingPostalCode(newAccounts, filteredAccounts);
        }
    }

    virtual
    public void sendAddress(){
        List<Account> filteredAccounts = this.filter.filterByChangedAddress(newAccounts, oldAccounts);
        List<String> accountIds = new List<String>();
        System.debug(filteredAccounts);
        if (filteredAccounts.size()>0){
            for(Account account : filteredAccounts){
                accountIds.add(account.Id);
            }
            PutAccountAddressAsync.sendAddress(accountIds);
        }
        
    }

}