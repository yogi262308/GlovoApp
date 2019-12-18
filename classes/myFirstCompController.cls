public class myFirstCompController {
    
    @AuraEnabled
    Public static void myfirstMethod(string strAccountName){
        //myFirstCompController
        system.debug('EHere is my Variable::'+strAccountName);
    }

}