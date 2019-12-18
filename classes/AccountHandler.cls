public Class AccountHandler{
@future 
    public static void insertPartnerAccount(String a){
        //if( a.Is_Partner__c)
        Account partnerAccount = new Account(Name=a);
        system.debug('FFFF'+partnerAccount);
        insert partnerAccount;
    }
}