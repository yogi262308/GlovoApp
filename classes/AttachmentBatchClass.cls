global class AttachmentBatchClass implements Database.Batchable<sObject>{
   global final String Query;
   global AttachmentBatchClass(set<id> q){
      Query='Select id,parentid from Attachment';
   }

   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, 
                       List<attachment> scope){
          system.debug('KKKKKKKK'+scope);
   }

   global void finish(Database.BatchableContext BC){
		system.debug('KKKKZZZZZZZKKKK');
       TestFutureMethod.TestFutureMethod1();
   }
}