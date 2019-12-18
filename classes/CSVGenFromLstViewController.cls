public class CSVGenFromLstViewController{
	public string strFilename{get;set;}public string strObjType{get;set;}public String strBaseURL{get;set;}private string strListViewId;
    @AuraEnabled
    public static List <listView> getListViewLst(string objName){return [select id,name from ListView where sObjectType=:objName];}    
   
    public pagereference redirectFalse(){
        Pattern p   = Pattern.compile('((filterName)[%3D][0-9a-zA-Z]+)');
         // Getting the Current page URL.
		
         String url = ApexPages.currentPage().geturl();
         Matcher pm = p.matcher(url);
         system.debug('Url:::::::::::::::'+url);
         // Exacting out the filter name from the URL.
         if(pm.find())

         {

                     system.debug( (pm.group(1)).remove('filterName%3D'));    

         }
        PageReference myVFPage = new PageReference(ApexPages.currentPage().geturl());
        myVFPage.setRedirect(true);
        return myVFPage;
    }
    public CSVGenFromLstViewController(){
        
         // Pattern creation to filter the filtername from the URL.
         Pattern p   = Pattern.compile('((filterName)[%3D][0-9a-zA-Z]+)');
         // Getting the Current page URL.

         String url = ApexPages.currentPage().geturl();
         Matcher pm = p.matcher(url);
         system.debug('Url:::::::::::::::'+url);
         // Exacting out the filter name from the URL.
         if(pm.find())

         {

                     system.debug( (pm.group(1)).remove('filterName%3D'));    

         }

              
        strObjType=objectNamefromPrefix(ApexPages.currentPage().getParameters().get('objName'));strFilename=strObjType+'.csv';
        strBaseURL=ApexPages.currentPage().getHeaders().get('referer')+'one/one.app#/sObject/'+strObjType+'/list?filterName=Recent';        
    }
    public static String objectNamefromPrefix(String recordIdOrPrefix){
        String objectName = '';
        try{//This assumes that you have passed at least 3 characters
            String myIdPrefix = String.valueOf(recordIdOrPrefix).substring(0,3);Map<String, Schema.SObjectType> gd =  Schema.getGlobalDescribe();
            //Loop through all the sObject types returned by Schema
            for(Schema.SObjectType stype : gd.values()){
                Schema.DescribeSObjectResult r = stype.getDescribe();string prefix = r.getKeyPrefix();
                //Check if the prefix matches with requested prefix
                if(prefix!=null && prefix.equals(myIdPrefix)){objectName = r.getName();break;}
            }}catch(Exception e){System.debug(e);}return objectName;
    }
    public class relatedDataWrapper{@AuraEnabled public list<String> headerList;@AuraEnabled public list<String> recordList;}  
    @AuraEnabled
 	public static relatedDataWrapper getCSVData(string sobjType,String listViewId){
        try{
        String strSessionId=UserInfo.getOrganizationId()+''+userinfo.getSessionId().substring(15,userinfo.getSessionId().length()); 
        relatedDataWrapper relteddDataWrap=new relatedDataWrapper(); HttpRequest req = new HttpRequest();
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v41.0/sobjects/'+sobjType+'/listviews/'+listViewId+'/results');
        req.setMethod('GET');String authorizationHeader = 'OAuth ' +strSessionId;req.setHeader('Authorization', authorizationHeader);
        Http http = new Http();HTTPResponse res = http.send(req);list<String> headerList=New list<String>();list<String> RecordList=New list<String>();
        Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());List<Object> items = (List<Object>)root.get('columns');
        for(Object item : items) {Map<String, Object> i = (Map<String, Object>)item;headerList.add(((String)i.get('fieldNameOrPath')).trim());}list<Object> records = (List<Object>)root.get('records');for(Object item : records){Map<String, Object> i = (Map<String, Object>)item;string strRecord;
            for(object objRec:(list<object>)i.get('columns')){ Map<String, Object> j = (Map<String, Object>)objRec;if(String.isNotBlank(strRecord)){if(j.get('value')!=null){String s1= (string)j.get('value');s1=s1.replaceAll(',','');strRecord=strRecord+s1+',';
                    }else{strRecord=strRecord+' '+',';}}else{if(j.get('value')!=null){String s1= (string)j.get('value');s1=s1.replaceAll(',','');strRecord=s1+',';} else{strRecord=',';}}}strRecord = strRecord.removeEnd(',').replaceAll('null',' ');RecordList.add(strRecord);}relteddDataWrap.headerList=headerList;relteddDataWrap.RecordList=RecordList;return relteddDataWrap;
        }catch(Exception e){System.debug(e);}return null;}
}