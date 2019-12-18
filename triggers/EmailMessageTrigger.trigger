trigger EmailMessageTrigger on EmailMessage (After insert,After Update) {
    
    if(trigger.isInsert){
        list<EmailMessage> Emailist=new list<EmailMessage>([Select id from EmailMessage where id IN:trigger.new]);
        update Emailist;
    	
    }
    
    if(trigger.isUpdate){
        list<attachment> EMList=new list<attachment>([Select id from attachment where parentid=:trigger.new]);
        system.debug('SSSSSS'+EMList);
    }
}