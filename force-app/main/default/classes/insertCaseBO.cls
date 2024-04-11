global class insertCaseBO implements Database.Batchable<sObject>, Database.Stateful {
    global Integer recordsProcessed = 0;
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        string query = 'SELECT  contactid, CaseNumber, Priority, status, closeddate, subject from case' ;
        return Database.getQueryLocator(query);
    }
    
    global void execute(database.BatchableContext bc , list<case> scope ){
        system.debug('inside execute');
        list<CK_test__b> cse = new list<CK_test__b>();
        for(case cc : scope){
            CK_test__b cbo = new CK_test__b();
            cbo.Case__c = cc.id;
            cbo.Contact__c = cc.contactid;
            cbo.Case_Subject__c = cc.subject;
            cbo.Contact_Last_Name__c = cc.Priority;
            cse.add(cbo);
        }
        database.insertImmediate(cse);
        system.debug('elements inserted'+cse);
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('records processed'+recordsProcessed);
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email               FROM AsyncApexJob
                            WHERE Id = : bc.getJobId()];
    }    
}