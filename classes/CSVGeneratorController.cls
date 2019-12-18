public class CSVGeneratorController{ 
    @AuraEnabled public list<String> selectedColumns;  
    @AuraEnabled
    public static list<String> returnObjectList(String strObjectType){
        list<String> ObjectList=new list<String>();
        list<String> CustomObjectList=new list<String>();
        list<String> StanrdObjectList=new list<String>();
        for(Schema.SObjectType o : Schema.getGlobalDescribe().values()){
            Schema.DescribeSObjectResult objResult = o.getDescribe();                     
            if(strObjectType.equalsIgnoreCase('2')){
                if(objResult.isCustom())
                    CustomObjectList.add(objResult.getName());
                
            }else if(strObjectType.equalsIgnoreCase('1')){
                if(!objResult.isCustom())
                    StanrdObjectList.add(objResult.getName());    
            }
        }
        ObjectList.addAll(CustomObjectList);
        ObjectList.addAll(StanrdObjectList);
        return ObjectList;
    }
    
    public class ObjectPropWrapper{
        @AuraEnabled public string ObjectName;
        @AuraEnabled public String ObjectLabel;
        @AuraEnabled public list<fieldsPropwrapper> fieldsList;
        @AuraEnabled public errorResponse ErWrap;        
    }
    public class errorResponse{
        @AuraEnabled public string strErrorType;
        @AuraEnabled public string StrErrorDesc;
    }
    public class fieldsPropWrapper{
        @AuraEnabled public boolean IsSelected;
        @AuraEnabled public String FieldName;
        @AuraEnabled public string fieldlabel;
        @AuraEnabled public string fieldtype;
        @AuraEnabled public errorResponse ErWrap;        
    }
    @AuraEnabled
    public static list<ObjectPropWrapper>  ObjectProperties(String strObjectName){
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        system.debug(logginglevel.Error,'SSSSSS'+strObjectName);
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(strObjectName).getDescribe().fields.getMap();
        list<ObjectPropWrapper> OPWrapList=new list<ObjectPropWrapper>();
        ObjectPropWrapper OPWrap=new ObjectPropWrapper();
        try{            
            OPWrap.ObjectName =strObjectName;
            OPWrap.ObjectLabel =strObjectName; 
            list<fieldsPropWrapper> fieldPropWrapList=new list<fieldsPropWrapper>();
            for(Schema.SObjectField sfield : fieldMap.Values()){
                fieldsPropWrapper FPW=new fieldsPropWrapper();
                schema.describefieldresult dfield = sfield.getDescribe();
                FPW.IsSelected=false;
                FPW.FieldName =dfield.getName();
                FPW.fieldlabel=dfield.getLabel();
                FPW.fieldType= String.ValueOf(dfield.getType());            
                fieldPropWrapList.add(FPW);
            }  
            OPWrap.fieldsList= fieldPropWrapList;
            
        }catch(exception ex){
            OPWrap.ErWrap=new errorResponse();
            OPWrap.ErWrap.strErrorType= 'Exception';
            OPWrap.ErWrap.StrErrorDesc=''+ex.getMessage();            
        }
        OPWrapList.add(OPWrap);
        return OPWrapList;        
    }
    
    public class SelectedColumnsAndData{        
        @AuraEnabled public list<String> strSelectedColumns;
        @AuraEnabled public string strQuery;        
        @AuraEnabled public errorResponse ErWrap;         
    }    
    @AuraEnabled
    public static SelectedColumnsAndData fetchSelectedObjectData(string OpWList){
        SelectedColumnsAndData SelectedColumnsAndDatas= new SelectedColumnsAndData();
        try{
         system.debug(logginglevel.error,'OpWList:::'+OpWList);
            List<ObjectPropWrapper> stageList = (List<ObjectPropWrapper>)JSON.deserialize(OpWList,List<ObjectPropWrapper>.class);
            list<String> selectedColumns=new list<String>();
            String strObjectName='';
            for(ObjectPropWrapper OPWrap :stageList){  
                strObjectName=OPWrap.ObjectName;        
                for(fieldsPropwrapper fpw: OPWrap.fieldsList){
                    if(fpw.isSelected){
                        selectedColumns.add(fpw.fieldName);
                    }
                }
            }
            SelectedColumnsAndDatas.strSelectedColumns=selectedColumns;
            //create a Query to display Data
            String strQuery='Select ';
            if(selectedColumns.size()>0){
                for(String strFieldName:selectedColumns){
                    strQuery+=strFieldName+', ';
                }           
                strQuery =strQuery.removeEnd(', ');
                strQuery+= ' From '+strObjectName;               
                SelectedColumnsAndDatas.strQuery=strQuery;
            }else{
                SelectedColumnsAndDatas=null;
                SelectedColumnsAndDatas.ErWrap=new errorResponse();
                SelectedColumnsAndDatas.ErWrap.strErrorType= 'User Error!';
                SelectedColumnsAndDatas.ErWrap.StrErrorDesc= 'No column is selected!'; 
                return SelectedColumnsAndDatas;
            }
        }catch(exception ex){
            system.debug(logginglevel.Error,ex.getLineNumber()+'Error In fetchSelectedObjectData:'+ex);
            SelectedColumnsAndDatas.ErWrap=new errorResponse();
            SelectedColumnsAndDatas.ErWrap.strErrorType= 'Exception';
            SelectedColumnsAndDatas.ErWrap.StrErrorDesc= ex.getMessage();
        }
        return SelectedColumnsAndDatas;
    }
    public class relatedDataWrapper{
        @AuraEnabled public list<String> headerList;
        @AuraEnabled public list<SObject> sObjectList;        
        @AuraEnabled public errorResponse ErWrap; 
    }
    @AuraEnabled
    public static relatedDataWrapper QueryData(String strSelectColumnAndQuery){
        relatedDataWrapper relatedDataList=new relatedDataWrapper();
        try{
            system.debug(logginglevel.error,'SSSSS'+strSelectColumnAndQuery);
            SelectedColumnsAndData selectedColumn = (SelectedColumnsAndData)JSON.deserialize(strSelectColumnAndQuery,SelectedColumnsAndData.class);
            relatedDataList.headerList=new list<String>();
            //selectedColumn.strQuery = selectedColumn.strQuery.touppercase();
            Pattern p = Pattern.compile('(?:(?i)select(?-i)\\s?)' + '(.*?)' + '(?:(?i)from(?-i)\\s?)');
            Matcher m = p.matcher(selectedColumn.strQuery);
            while (m.find()) {
                list<String> strList=new list<String>();
                strList =m.group(1).replaceAll(' ','').split(',');
                relatedDataList.headerList.addAll(strList);
            }            
            relatedDataList.sObjectList =new list<SObject>();
            relatedDataList.sObjectList =database.Query(selectedColumn.strQuery);
            if(relatedDataList.sObjectList.size()==0){
                relatedDataList.ErWrap=new errorResponse();
                relatedDataList.ErWrap.strErrorType= 'No Record';
                relatedDataList.ErWrap.StrErrorDesc= 'No Records found!';
            }
        }catch(exception ex){
            system.debug(logginglevel.Error,ex.getLineNumber()+'Error In QueryData:'+ex);
            relatedDataList.ErWrap=new errorResponse();
            relatedDataList.ErWrap.strErrorType= 'Exception';
            relatedDataList.ErWrap.StrErrorDesc= ex.getMessage();
        }
        system.debug(logginglevel.Error,'DDDDDDDDDDDD'+relatedDataList);
        return relatedDataList;
    }
}