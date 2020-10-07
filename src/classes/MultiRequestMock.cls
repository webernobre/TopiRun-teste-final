/**
 * @author walmeida - adaptado de https://developer.salesforce.com/blogs/developer-relations/2013/03/testing-apex-callouts-using-httpcalloutmock.html
 */
public class MultiRequestMock implements HttpCalloutMock {
    Map<String, HttpCalloutMock> requests;
 
    public MultiRequestMock(Map<String, HttpCalloutMock> requests) {
        this.requests = requests;
    }
 
    public HTTPResponse respond(HTTPRequest req) {
        HttpCalloutMock mock = requests.get(req.getEndpoint());
        if (mock != null) {
            return mock.respond(req);
        } else {
            throw new MultiMockException('HTTP callout not supported for test methods');
        }
    }

    public class MultiMockException extends Exception {}
}