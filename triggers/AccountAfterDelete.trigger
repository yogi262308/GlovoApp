trigger AccountAfterDelete on Account (after delete,after undelete) {
	
    system.debug(trigger.oldMap);
    
}