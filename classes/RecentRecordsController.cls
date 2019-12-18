public class RecentRecordsController {
   @AuraEnabled public static List<sobject> getRecentRecords(String ObjectName,String limits,String fieldstoget){     
        
        List<Id> recentlyViewedIds = new List<Id>();
        Integer limitofRecord = Integer.valueOf(String.escapeSingleQuotes(limits));
        for(sObject obj : [Select Id from RecentlyViewed where Type =:String.escapeSingleQuotes(ObjectName)]){
            recentlyViewedIds.add(obj.Id);
        }
        String queryString = 'Select '+ String.escapeSingleQuotes(fieldsToGet)+
                             ' from '+ String.escapeSingleQuotes(ObjectName) +
                             ' where ID IN:recentlyViewedIds Limit '+ limitofRecord;
      
        return database.query(queryString);
    }
}