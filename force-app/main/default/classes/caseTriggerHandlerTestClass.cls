@isTest 
public class caseTriggerHandlerTestClass {
    static testMethod void validateCaseTriggerHandler() {
        test.startTest();
        List <Case> insertCaseList = new List<Case>();
        for(Integer i =0; i<100; i++) {
            case cc = new case();
            cc.status = 'New';
            cc.Priority = 'Medium';
            cc.Origin = 'Web';
            cc.Subject = 'Test Case '+i;
            insertCaseList.add(cc);
        }
        insert insertCaseList;
        test.stopTest();
    }
    
    static testMethod void afterUpdateCaseTriggerHandler() {
        test.startTest();
        List <Case> updateCaseList = [SELECT id,Owner.Name,Status,
                                      (SELECT id,Calculated__c,Case_Status__c,Date__c,User__c,Queue__c,Start_Time__c,Time_in_Minutes__c,
                                       Case__c FROM TimeSheets__r) 
                                      FROM Case];
        for(case cc : updateCaseList) {
            cc.status = 'Working';
            cc.Priority = 'Medium';
            cc.Origin = 'Phone';
        }
        update updateCaseList;
        test.stopTest();
    }
}