trigger ClosedOpportunityTrigger on Opportunity (before insert) {
	
    list<task> taskList=new list<Task>();
    FOR(Opportunity objOpp:trigger.new){
        
        if(objOpp.StageName =='Closed Won'){
            task taskObj=new Task();
            taskObj.Subject='Follow Up Test Task';
            taskObj.WhatId =objOpp.id;
            taskList.add(taskObj);
        }
    }	
    insert taskList;
}