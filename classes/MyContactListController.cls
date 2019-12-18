public class MyContactListController {
	@AuraEnabled
    public static list<Contact> getContacts(Id recordId){        
        return [Select id,Firstname,Lastname,Email,Phone from Contact where AccountId=:recordId];
    }    
}