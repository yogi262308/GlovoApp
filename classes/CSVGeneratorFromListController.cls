public class CSVGeneratorFromListController {
    public string strFilename{get;set;}
    private string strObjType{get;set;}
    private string strApiV;
    private string strListViewId;
    @AuraEnabled
    public static void CsvGeneratorFromListView(){        
        
    }
    
    public CSVGeneratorFromListController(){
        String strCurrentPageURL=ApexPages.currentPage().getURL();
        system.debug(logginglevel.Error,'QQQQQQ'+strCurrentPageURL);
        strFilename='First.csv';
        strObjType='Account';
        strApiV='v41.0';
        strListViewId='00B7F000003uB3T';
        //This Method will create CSV
        CreateCSV();
    }
    public void CreateCSV(){        
        String strSessionId=UserInfo.getOrganizationId()+''+userinfo.getSessionId().substring(15,userinfo.getSessionId().length()); 
        HttpRequest req = new HttpRequest();
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/'+strApiV+'/sobjects/'+strObjType+'/listviews/'+strListViewId+'/results');
        req.setMethod('GET');
        String authorizationHeader = 'OAuth ' +strSessionId;
        req.setHeader('Authorization', authorizationHeader);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
		        
    }
}