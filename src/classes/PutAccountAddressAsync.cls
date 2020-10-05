public class PutAccountAddressAsync {

    @future (callout=true)
    public static void sendAddress (List<String> accountIds) {  

        AccountRepository repository = new AccountRepository();

        List<Account> accounts = repository.findByIds(accountIds);

        PutAccountAddressOutboundService service;
        
        for (Account account : accounts) {

            service = new PutAccountAddressOutboundService();
            PutAccountAddressResponse response = service.publishAddress(account.Id);
            if (String.isEmpty(response.message)){
                account.GeolocationRequested__c=true;
                continue;
            } 
            account.GeolocationErrorMessage__c = response.message;   

        }

        repository.store(accounts);

    }
}