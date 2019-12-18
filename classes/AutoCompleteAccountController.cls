public class AutoCompleteAccountController {
	
    // Instance fields
    public String searchTerm {get; set;}
    public String selectedMovie {get; set;}
    
    // JS Remoting action called when searching for a movie name
    @RemoteAction
    public static List<Account> searchAccount(String searchTerm) {
        System.debug('Movie Name is: '+searchTerm );
        List<Account> Accounts = Database.query('Select Id, Name from Account where name like \'%' + String.escapeSingleQuotes(searchTerm) + '%\'');
        return Accounts;
    }
}