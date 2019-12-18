public class MetadataService1 {
    public class SearchLayouts {    
        public String[] listViewButtons;
        private String[] listViewButtons_type_info = new String[]{'listViewButtons','http://soap.sforce.com/2006/04/metadata',null,'0','-1','false'};
        private String[] field_order_type_info = new String[]{'customTabListAdditionalFields','excludedStandardButtons','listViewButtons','lookupDialogsAdditionalFields','lookupFilterFields','lookupPhoneDialogsAdditionalFields','searchFilterFields','searchResultsAdditionalFields','searchResultsCustomButtons'};
    }
    
    public class ActivitiesSettings extends Metadata {      
        public Boolean enableListViewScheduling;
        private String[] enableListViewScheduling_type_info = new String[]{'enableListViewScheduling','http://soap.sforce.com/2006/04/metadata',null,'0','1','false'};
        private String[] field_order_type_info = new String[]{'fullName', 'allowUsersToRelateMultipleContactsToTasksAndEvents','enableActivityReminders','enableClickCreateEvents','enableDragAndDropScheduling','enableEmailTracking','enableGroupTasks','enableListViewScheduling','enableLogNote','enableMultidayEvents','enableRecurringEvents','enableRecurringTasks','enableSidebarCalendarShortcut','enableSimpleTaskCreateUI','enableUNSTaskDelegatedToNotifications','meetingRequestsLogo','showCustomLogoMeetingRequests','showEventDetailsMultiUserCalendar','showHomePageHoverLinksForEvents','showMyTasksHoverLinks','showRequestedMeetingsOnHomePage'};
    }
    
    public virtual class Metadata {
        public String fullName;
    }
    public interface IReadResult {
        MetadataService.Metadata[] getRecords();
    }
    public interface IReadResponseElement {
        IReadResult getResult();
    }
    
    public class ReadListViewResult implements IReadResult {
        public MetadataService.ListView[] records;
        public MetadataService.Metadata[] getRecords() { return records; }
        private String[] records_type_info = new String[]{'records','http://soap.sforce.com/2006/04/metadata',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/2006/04/metadata','true','false'};
        private String[] field_order_type_info = new String[]{'records'};
    }
    
    public class ListViewFilter {
        public String field;
        public String operation;
        public String value;
        private String[] field_type_info = new String[]{'field','http://soap.sforce.com/2006/04/metadata',null,'1','1','false'};
        private String[] operation_type_info = new String[]{'operation','http://soap.sforce.com/2006/04/metadata',null,'1','1','false'};
        private String[] value_type_info = new String[]{'value','http://soap.sforce.com/2006/04/metadata',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/2006/04/metadata','true','false'};
        private String[] field_order_type_info = new String[]{'field','operation','value'};
    }
    
    public class ListView extends Metadata {
        public String type = 'ListView';
        public String fullName;
        private String[] fullName_type_info = new String[]{'fullName','http://soap.sforce.com/2006/04/metadata',null,'0','1','false'};
        public String booleanFilter;
        public String[] columns;
        public String division;
        public String filterScope;
        public MetadataService.ListViewFilter[] filters;
        public String label;
        public String language;
        public String queue;
        /// MetadataService.SharedTo sharedTo;
        private String[] booleanFilter_type_info = new String[]{'booleanFilter','http://soap.sforce.com/2006/04/metadata',null,'0','1','false'};
        private String[] columns_type_info = new String[]{'columns','http://soap.sforce.com/2006/04/metadata',null,'0','-1','false'};
        private String[] division_type_info = new String[]{'division','http://soap.sforce.com/2006/04/metadata',null,'0','1','false'};
        private String[] filterScope_type_info = new String[]{'filterScope','http://soap.sforce.com/2006/04/metadata',null,'1','1','false'};
        private String[] filters_type_info = new String[]{'filters','http://soap.sforce.com/2006/04/metadata',null,'0','-1','false'};
        private String[] label_type_info = new String[]{'label','http://soap.sforce.com/2006/04/metadata',null,'1','1','false'};
        private String[] language_type_info = new String[]{'language','http://soap.sforce.com/2006/04/metadata',null,'0','1','false'};
        private String[] queue_type_info = new String[]{'queue','http://soap.sforce.com/2006/04/metadata',null,'0','1','false'};
        private String[] sharedTo_type_info = new String[]{'sharedTo','http://soap.sforce.com/2006/04/metadata',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/2006/04/metadata','true','false'};
        private String[] type_att_info = new String[]{'xsi:type'};
        private String[] field_order_type_info = new String[]{'fullName', 'booleanFilter','columns','division','filterScope','filters','label','language','queue','sharedTo'};
    }
    
    public class CustomObject extends Metadata {        
        public MetadataService.ListView[] listViews;      
        private String[] listViews_type_info = new String[]{'listViews','http://soap.sforce.com/2006/04/metadata',null,'0','-1','false'};
    }
}