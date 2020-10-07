global class GetAccountGeolocationAsync implements Queueable, Database.AllowsCallouts {

    global void execute (QueueableContext context) {
        AccountRepository repository = new AccountRepository();
        GetAccountGeolocationOutboundService service = new GetAccountGeolocationOutboundService();
        List<Account> accounts = repository.findWithGeolocation();
        repository.store(service.getGeolocation(accounts));
    }

}