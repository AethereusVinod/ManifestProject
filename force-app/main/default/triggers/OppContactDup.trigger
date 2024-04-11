trigger OppContactDup on Opportunity (before insert) {
    Set<Id> AccIds = new Set<Id>();
    if(trigger.isInsert){
        for(Opportunity opp : trigger.new){
            AccIds.add(opp.AccountId);
        }
        for(Account acc : [SELECT Id, Name, (SELECT Name, Email FROM Contacts)FROM Account WHERE Id IN : AccIds]){
            
        }
    }
}