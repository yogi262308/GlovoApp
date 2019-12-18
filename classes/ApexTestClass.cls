public with sharing class ApexTestClass {
    map<string,list<Account>> AccountMap=new map<string,list<Account>>();
    public void myMethodName(){
    	list<Account> AccountList=new list<Account>([select id,parentid,(select Id from childAccounts) from Account]);
    	
    	for(Account Acclist:AccountList){
    		if(Acclist.parentId==null){
    			AccountMap.put(Acclist.id,Acclist.childAccounts);
    		}else{
    				
    		}
    	}
    }
}