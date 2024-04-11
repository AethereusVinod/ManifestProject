public class LeadTaskUpdateClass {
    public static void LeadTaskUpdateClassInsertUpdateMethod(List<Lead> leadList) {
        Set<Id> leadIdSet = new Set<Id>();
        List<Task> taskListToUpdate = new List<Task>();
         for(Lead leadObj : leadList){
            if(leadObj.Status == 'Closed - Converted' || leadObj.Status == 'Closed - Not Converted') {
                leadIdSet.add(leadObj.Id);
            }	
            
             for(Task taskObj : [SELECT Id, Status FROM Task WHERE WhoId IN: leadIdSet]) {
                taskObj.Status = 'Completed';
                taskListToUpdate.add(taskObj);
            }
            
            if(!taskListToUpdate.isEmpty()) {
                update taskListToUpdate;
                system.debug('taskListToUpdate'+taskListToUpdate);
            }
            
        }
    }
}