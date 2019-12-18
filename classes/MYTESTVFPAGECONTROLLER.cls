public with sharing class  MYTESTVFPAGECONTROLLER {
    public list<Account> AcntList{get;set;}
	
    public MYTESTVFPAGECONTROLLER(ApexPages.StandardController ASDS){
        AcntList=[select id,Name from Account limit 10000];
        system.debug('SSSSSS'+[select id,Name from Account limit 10000]);
    }
    
    public void updateAccount(){
        
        update AcntList;
    }
}