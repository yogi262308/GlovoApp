trigger AccountTrigger on Account(after insert){
    for( Account a : Trigger.new){
		AccountHandler.insertPartnerAccount(a.Name);
    }
}