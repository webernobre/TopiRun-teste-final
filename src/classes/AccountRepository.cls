public virtual class AccountRepository {

    virtual
    public List<Account> findById ( String id ) {

        return [SELECT Id, Name, 
                        BillingPostalCode, ShippingPostalCode, 
                        Cnpj__c, Cpf__c 
                FROM Account
                WHERE Id = :Id ];

    }


}