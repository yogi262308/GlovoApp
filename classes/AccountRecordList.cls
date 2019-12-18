global with sharing class AccountRecordList {	
	webservice static list<Account> returnAccountList() {        
        return [Select id,name from Account limit 10];
    }    
}