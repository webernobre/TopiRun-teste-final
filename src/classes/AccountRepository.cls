public virtual class AccountRepository {

    virtual
    public List<Account> findById ( String id ) {

        return [SELECT Id, Name, 
                        BillingPostalCode, ShippingPostalCode, 
                        Cnpj__c, Cpf__c 
                FROM Account
                WHERE Id = :id ];

    }

    virtual
    public List<Account> findByIds ( List<String> ids ) {

        return [SELECT Id, Name, 
                        BillingPostalCode, ShippingPostalCode, 
                        Cnpj__c, Cpf__c 
                FROM Account
                WHERE Id IN :ids ];

    }

    virtual
    public Account findWithAddressById ( String id ) {

        return [SELECT Id, Name, 
                        BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, 
                        ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry 
                FROM Account
                WHERE Id = :Id ];

    }

    virtual
    public List<Account> store(List<Account> accounts){
        update accounts;
        return accounts;
    }

    virtual
    public List<Account> findWithGeolocation(){
        return [SELECT Id
                FROM Account
                WHERE GeolocationRequested__c = true ];
    }


}