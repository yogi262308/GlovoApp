trigger AccountAddressTrigger on Account (before insert) {
    
    for(Account acntObj :trigger.new){
        
        if(string.isnotblank(acntObj.BillingPostalCode)&&acntObj.Match_Billing_Address__c){
            acntObj.ShippingPostalCode=acntObj.BillingPostalCode;
           }
     }
}