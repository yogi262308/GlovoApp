public with sharing class DataWrapperCls {
	
	public string strName{get;set;}
	public string strEmail{get;set;}
	public integer intIndex{get;set;}
	
	public DataWrapperCls(integer intNum){
		intIndex=intNum;
	}
    
}