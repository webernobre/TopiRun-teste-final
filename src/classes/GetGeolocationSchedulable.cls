/**
 * @author walmeida
 */
global class GetGeolocationSchedulable implements Schedulable  {
    global void execute(SchedulableContext context){

        GetAccountGeolocationAsync geolocation = new GetAccountGeolocationAsync();
        System.enqueueJob(geolocation);

        Datetime actualTime = System.now().addMinutes(20);  

        String chronExpression = ' 0 ' + actualTime.minute() + ' ' + actualTime.hour() + ' * * ? *';


        System.abortJob(context.getTriggerId());

        System.schedule( 'Get Geolocations', chronExpression, new GetGeolocationSchedulable() );
    }

}