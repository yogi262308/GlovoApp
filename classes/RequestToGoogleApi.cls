public class RequestToGoogleApi {
  
    public static void AllDatafromAPi(){
        
       // https://www.googleapis.com/drive/v2/files?access_token=<access_token>
     //public void basicAuthCallout(){
     HttpRequest req = new HttpRequest();
     req.setEndpoint('https://www.googleapis.com/drive/v2/files?access_token=103198561127-h0ip149i968sjk7iqrq2kkuk6eip5m9v.apps.googleusercontent.com');
     req.setMethod('GET');
     
     // Specify the required user name and password to access the endpoint
     // As well as the header and header information
 
     String username = 'myname';
     String password = 'mypwd';
  
     Blob headerValue = Blob.valueOf(username + ':' + password);
     String authorizationHeader = 'BASIC ' +
     EncodingUtil.base64Encode(headerValue);
     req.setHeader('Authorization', authorizationHeader);
   
     // Create a new http object to send the request object
     // A response object is generated as a result of the request  
  
     Http http = new Http();
     HTTPResponse res = http.send(req);
     System.debug(res.getBody());
    }    
}