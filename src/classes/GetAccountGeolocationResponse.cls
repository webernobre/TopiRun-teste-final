/**
 * @author walmeida
 */
@SuppressWarnings ('PMD')
public class GetAccountGeolocationResponse {
    public String externalId;
    public billingAddress billingAddress;
    public shippingAddress shippingAddress;


    public class billingAddress{
        public Double latitude;
        public Double longitude;
    }

    public class shippingAddress{
        public Double latitude;
        public Double longitude;
    }
}