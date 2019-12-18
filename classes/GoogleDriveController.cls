public class GoogleDriveController
{
    //Fetched from URL
    private String code ;
    private string key = '103198561127-h0ip149i968sjk7iqrq2kkuk6eip5m9v.apps.googleusercontent.com' ;
    private string secret = 'KeOXZH1_YclKQu-dltLvN3Qj' ;
    private string redirect_uri = 'https://yogeshdev-dev-ed.my.salesforce.com/apex/GoogleDrivePage' ;
    private string Access_Token;
    
    public string strResponse {get;set;}
    
    public GoogleDriveController()
    {
        code = ApexPages.currentPage().getParameters().get('code') ;
        //Get the access token once we have code
        if(code != '' && code != null)
        {
            AccessToken() ;
        }
    }
    
    public void AuthenticGoogleDrive(){
        
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        String messageBody='https://accounts.google.com/o/oauth2/v2/auth?scope=https://www.googleapis.com/auth/drive.file&access_type=online&include_granted_scopes=true&state=pass&redirect_uri='+redirect_uri+'&response_type=code&client_id='+key;
        req.setEndpoint(messageBody);
        //req.setHeader('content-type', 'application/x-www-form-urlencoded');
        //String messageBody1 = 'client_id='+key+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';
        //req.setHeader('Content-length', String.valueOf(messageBody1.length()));
        //req.setBody(messageBody1);
        req.setTimeout(60*1000);
        
        Http h = new Http();
        String resp;
        HttpResponse res = h.send(req);
        resp = res.getBody();
        
        System.debug(' You can parse the response to get the access token ::: ' + resp);
        
    }
    
    public PageReference DriveAuth()
    {
        //Authenticating
        PageReference pg = new PageReference(GoogleDriveAuthUri (key , redirect_uri)) ;
        return pg ;
    }
    
    public String GoogleDriveAuthUri(String Clientkey,String redirect_uri)
    {
        String key = EncodingUtil.urlEncode(Clientkey,'UTF-8');
        String uri = EncodingUtil.urlEncode(redirect_uri,'UTF-8');
        String authuri = '';
        authuri = 'https://accounts.google.com/o/oauth2/auth?'+
        'client_id='+key+
        '&response_type=code'+
        '&scope=https://www.googleapis.com/auth/drive'+
        '&redirect_uri='+uri+
        '&state=security_token%3D138r5719ru3e1%26url%3Dhttps://oa2cb.example.com/myHome&'+
        '&login_hint=jsmith@example.com&'+
        'access_type=offline';
        return authuri;
    }
    
    
    public void AccessToken()
    {
        //Getting access token from google
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://accounts.google.com/o/oauth2/token');
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        String messageBody = 'code='+code+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);

        Http h = new Http();
        String resp;
        HttpResponse res = h.send(req);
        resp = res.getBody();
        strResponse=resp;
        
        System.debug(' You can parse the response to get the access token ::: ' + resp);
   }
    
    public Void allFilesfromGoogleDrive(){
        system.debug('LLLLLLL'+strResponse);
        JSONParser parser = JSON.createParser(strResponse);
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'access_token')) {
                // Get the value.
                parser.nextToken();
                // Compute the grand total price for all invoices.
                Access_Token = parser.getText();
            }
        }
        system.debug('Grand total=' + access_token);
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        String endpoint = 'https://www.googleapis.com/drive/v3/files' +'?corpus=user' +'&orderBy=createdTime' +'&pageSize=20';
        req.setEndpoint(endpoint);
       // String messageBody = 'code='+code+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';
        req.setHeader('Authorization', 'Bearer ' + access_token);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Charset', 'UTF-8');
        Http h = new Http();
        String resp;
        HttpResponse res = h.send(req);
        resp = res.getBody();
        strResponse=resp;
        
        System.debug(' You can parse the response to get the access token ::: ' + resp);        
    }
    
    Public class DriveData{
        
        public DriveData(){
            
            
        }
        
    }
    
    public void FileDetails(){
        system.debug('Grand total=' + access_token);
        //String jsonParser=JSON.s
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        //String endpoint='https://drive.google.com/uc?export=view&id=1-QPDYnjMpO5uJkaOhR6_BbchN9eIV3Wc6B1maoWtk6PkpHFOv_bhI1VEVnFd';
        String endpoint = 'https://drive.google.com/uc?export=download&id=1-QPDYnjMpO5uJkaOhR6_BbchN9eIV3Wc6B1maoWtk6PkpHFOv_bhI1VEVnFd';
        req.setEndpoint(endpoint);
       // String messageBody = 'code='+code+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';
        req.setHeader('Authorization', 'Bearer ' + access_token);
        req.setHeader('Content-Type', 'application/msword');
        Http h = new Http();
        String resp;
        HttpResponse res = h.send(req);
        resp = res.getBody();
        strResponse=resp;        
        System.debug(' You can parse the response to get the access token ::: ' + resp);
    }
}