/**
 * @author walmeida
 */
@SuppressWarnings ('PMD')
public class PutAccountAddressRequest {
    
    public String name;
    public String externalId;
    public billingAddress billingAddress;
    public shippingAddress shippingAddress;

    public class billingAddress{
        public String street;
        public String city;
        public String zipCode;
        public String state;
        public String country;

    }

    public class shippingAddress{
        public String street;
        public String city;
        public String zipCode;
        public String state;
        public String country;
        
    }


}