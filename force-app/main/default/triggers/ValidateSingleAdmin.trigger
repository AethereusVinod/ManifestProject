trigger ValidateSingleAdmin on Contact(before insert, before update){
set<Id> adminAccount = new set<id>();
for(contact con : trigger.new){
    if(con.accountId != null && con.admin__c)
        adminAccount.add(con.accountId);
}
if(!adminAccount.Isempty()){
    set<id> adminAccountd = new set<id>();
    for(contact con : [SELECT Id, AccountId FROM Contact WHERE AccountId IN: adminAccount AND admin__c = true]){
        adminAccountd.add(con.AccountId);
    }

for(contact con : trigger.new){
    if(con.accountId != null && con.admin__c && adminAccountd.Contains(con.accountId))
        con.addError('There already has an admin on account.');     
}
}
}