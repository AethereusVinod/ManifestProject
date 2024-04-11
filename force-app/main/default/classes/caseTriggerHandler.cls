/* Test Class : caseTriggerHandlerTestClass */
public class caseTriggerHandler {
    static Boolean flag = true;
    public static Boolean runOnce() {
        system.debug('Run Once-->');
        return flag && !(flag = false);
    }
    
    public static void afterInsertOperations(List<Case> cselist){
        Set<Id> caseIds = new Set<Id>();
        for(Case cs: cselist) {
            CaseIds.add(cs.id);
        }
        
        List<case> cselst =[SELECT id,Owner.Name,Status,
                            (SELECT id,Calculated__c,Case_Status__c,Date__c,User__c,Queue__c,Start_Time__c,Time_in_Minutes__c,
                             Case__c FROM TimeSheets__r) 
                            FROM Case WHERE id IN: CaseIds];
        
        //New Timesheet Creation
        List<Timesheet__c> insrttmshtList = new List<Timesheet__c>();
        for(Case cc: cselst) {
            Timesheet__c tmsht = new Timesheet__c();
            tmsht.Case__c = cc.Id;    
            tmsht.Case_Status__c = cc.status;
            if(cc.status == 'Awaiting') {
                tmsht.Time_Category__c = 'Customer Time';
            }
            tmsht.Start_Time__c = system.now();
            tmsht.Date__c = date.today();
            if(string.valueOf(cc.OwnerId).startsWith('005')) {
                tmsht.User__c = cc.OwnerId;
                if(cc.status == 'Awaiting'){
                    tmsht.Time_Category__c = 'Customer Time';
                }
                else{
                    tmsht.Time_Category__c = 'Agent Time';
                }
                
            }
            else if(string.valueOf(cc.OwnerId).startsWith('00G')) {
                tmsht.Queue__c = cc.Owner.Name;
                if(tmsht.OwnerId==null){
                    tmsht.Time_Category__c = 'Queue Time';
                }
            }
            insrttmshtList.add(tmsht);
        }
        insert insrttmshtList;
    }
    
    public static void afterUpdateOperations (Map<Id,Case> triggerOldMap,List<Case> caselist) {
        if(!TriggerUtility.RunOnce) {
            Set<Id> updateIds = new Set<Id>();
            system.debug('CaseList-->'+caselist);
            for(Case cs: caselist) {
                // Check for status/Owner change
                if((cs.status != triggerOldMap.get(cs.ID).status) || (cs.OwnerId !=triggerOldMap.get(cs.Id).OwnerId)) 
                {
                    updateIds.add(cs.Id);
                    system.debug('Case Id-->'+cs.Id);
                }
            }
            List<Case> caslist = [SELECT id,Owner.Name,Status,
                                  (SELECT id,Calculated__c,Case_Status__c,Date__c,User__c,Queue__c,Start_Time__c,Time_in_Minutes__c,
                                   Case__c FROM TimeSheets__r) 
                                  FROM Case WHERE id IN: updateIds];
            
            DateTime CurrentDate = DateTime.now();
            for(case cc : caslist){
                if(cc.TimeSheets__r.size()==0){
                    system.debug('Case have no timesheet');
                    Timesheet__c tmsht = new Timesheet__c();
                    tmsht.Case__c = cc.Id;    
                    tmsht.Case_Status__c = cc.status;
                    tmsht.Start_Time__c = system.now();
                    tmsht.Date__c = date.today();
                    if(string.valueOf(cc.OwnerId).startsWith('005')) {
                        tmsht.User__c = cc.OwnerId;
                        if(cc.status == 'Awaiting'){
                            tmsht.Time_Category__c = 'Customer Time';
                        }
                        else{
                            tmsht.Time_Category__c = 'Agent Time';
                        }
                    }
                    else if(string.valueOf(cc.OwnerId).startsWith('00G')) {
                        tmsht.Queue__c = cc.Owner.Name;
                        if(tmsht.OwnerId==null){
                            tmsht.Time_Category__c = 'Queue Time';
                        }
                    }
                    insert tmsht;
                }
                else{
                    system.debug('Case has timesheet-->'+cc.TimeSheets__r.size());
                    for(Timesheet__c timeshtt : cc.TimeSheets__r){
                        timeshtt.Calculated__c = true;
                        timeshtt.Time_in_Minutes__c = (CurrentDate.getTime() - timeshtt.Start_Time__c.getTime())/(60*60*24);
                    }
                    update cc.TimeSheets__r;
                    
                    Timesheet__c tmsht = new Timesheet__c();
                    tmsht.Case__c = cc.Id;    
                    tmsht.Case_Status__c = cc.status;
                    tmsht.Start_Time__c = system.now();
                    tmsht.Date__c = date.today();
                    if(string.valueOf(cc.OwnerId).startsWith('005')) {
                        tmsht.User__c = cc.OwnerId;
                         if(cc.status == 'Awaiting'){
                            tmsht.Time_Category__c = 'Customer Time';
                        }
                        else{
                            tmsht.Time_Category__c = 'Agent Time';
                        }
                    }
                    else if(string.valueOf(cc.OwnerId).startsWith('00G')) {
                        tmsht.Queue__c = cc.Owner.Name;
                            if(tmsht.OwnerId==null){
                            tmsht.Time_Category__c = 'Queue Time';
                        }
                    }
                    insert tmsht;
                }
            }
            TriggerUtility.RunOnce = true;
        }
    }
}