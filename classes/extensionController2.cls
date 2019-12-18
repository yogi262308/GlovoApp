public class extensionController2 {
    private Account acntObj;
    public extensionController2(Apexpages.StandardController sc){
         acntObj= (Account)sc.getRecord();
    }
    
    public void Save (){        
        acntObj.Name = acntObj.Name +'2';
        insert acntObj;
    }
}