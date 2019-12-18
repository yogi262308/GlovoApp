public class SideBarController {
    
    @AuraEnabled
    public static list<sObject> getsObjectList(){
     list<sObject> sObjList=new list<sObject>();
        return sObjList;
    }
}