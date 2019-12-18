public class AccountPageExtension1 {

    public AccountPageExtension1(ApexPages.StandardSetController stdSetControllers){
        Pattern p   = Pattern.compile('((filterName)[%3D][0-9a-zA-Z]+)');
        String url = ApexPages.currentPage().geturl();
         Matcher pm = p.matcher(url);
         system.debug('Url:::::::::::::::'+url);
         // Exacting out the filter name from the URL.
         if(pm.find())

         {

                     system.debug( (pm.group(1)).remove('filterName%3D'));    

         }
    }
    
    public AccountPageExtension1(ApexPages.Standardcontroller std){
            }
}