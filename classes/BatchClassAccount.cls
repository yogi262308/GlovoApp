public class BatchClassAccount implements Database.batchable <Integer> { 

   public Iterable<Integer> start(Database.batchableContext info){ 
       return new IntegerIterator(200);   
   }   

   public void execute(Database.batchableContext info, List<Integer> scope){ 
   //Loop through integer list and create records
       list<Account> AccountList=new list<Account>();
       for(integer i:scope){
           AccountList.add(new Account(Name='Account'+i));
           
       }
       insert AccountList;
   }

   public void finish(Database.batchableContext info){     

   }
}