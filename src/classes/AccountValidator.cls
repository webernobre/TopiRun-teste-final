/**
 * @author walmeida
 */
public class AccountValidator {

    BrazilianDocumentValidator validator;
    AccountTransform transform;

    public AccountValidator(){
        this.validator = new BrazilianDocumentValidator();
        this.transform = new AccountTransform();
    }

    public List<Account> validateCpf (List<Account> accounts) {

        for (Account account : accounts) {

            if ( !validator.isCpf( transform.toCpfUnformated(account.Cpf__c))) {

                account.Cpf__c.addError('CPF Invalido');
            
            }     

        }

        return accounts;

    }

    public List<Account> validateCnpj (List<Account> accounts) {

        for (Account account : accounts) {

            if ( !validator.isCnpj( transform.toCnpjUnformated(account.Cnpj__c))) {

                account.Cnpj__c.addError('CNPJ Invalido');
            
            }     

        }

        return accounts;

    }


}