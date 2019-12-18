trigger AccountsParentUpdate on Account (before update,before insert) {
    public static boolean stopTrigger=false;
    if(!stopTrigger){
    list<Account> AccList=new list<Account>();
   
    for(Account AccObj: trigger.new){
        Account updateParent = new aCCOUNT();
         AccObj.Description='';
        if(AccObj.ParentId!=null){
            updateParent.id=AccObj.ParentId;
                        updateParent.Description='';
            updateParent.Description+=AccObj.id+',';
            if(String.isnotBlank(AccObj.Description)){
                updateParent.Description=AccObj.Description;
            }
            AccList.add(updateParent);
        }
    }
        system.debug('jjjjjjj'+AccList);
        if(AccList.size()>0)
        {
            update AccList;
        }system.debug('After :::::'+AccList);
    	
       stopTrigger=true;
    }
}