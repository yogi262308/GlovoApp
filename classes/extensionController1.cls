public class extensionController1 {
    private Account acntObj;
    public extensionController1(Apexpages.StandardController sc){
         acntObj= (Account)sc.getRecord();
    }
  
}