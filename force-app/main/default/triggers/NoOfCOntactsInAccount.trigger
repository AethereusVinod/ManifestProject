trigger NoOfCOntactsInAccount on Contact (after insert, after delete, after update) {
    List<Account> updatedAccounts = new List<Account>(); 
    Set<Id> AccIds = new Set<Id>();
    if(Trigger.isInsert || Trigger.isUpdate) {
        for(Contact con : trigger.new) {
            AccIds.add(con.AccountId);
        }
        for(Account Acc : [SELECT Id, No_Of_Contacts__c, Name, (SELECT  Name From Contacts) From Account WHERE Id IN: AccIds]){
            acc.No_Of_Contacts__c = acc.contacts.size();
            updatedAccounts.add(acc);
            system.debug(''+updatedAccounts);
        }
    }
    if(Trigger.isDelete){
        for(contact con : trigger.old){
            AccIds.add(con.AccountId);
        }
        for(Account Acc : [SELECT Id, No_Of_Contacts__c, Name, (SELECT  Name From Contacts) From Account WHERE Id IN: AccIds]){
            acc.No_Of_Contacts__c = acc.contacts.size();
            updatedAccounts.add(acc);
            system.debug(''+updatedAccounts);
        }
    } 
    update updatedAccounts;
}