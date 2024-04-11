trigger NoOfContactAdmins on Contact (after insert) {
List <Account> updatedAccounts = New List<Account>();
set<Id> acc = new Set<Id>();
for(Contact con : trigger.new){
        if(con.AccountId !=null && con.Admin__c == true){
        Acc.add(con.AccountId);
       con.Description.contains('');
    }   
}   

for(Account acc : [SELECT Id, Name, Number_of_Admins_in_this_Account__c,(SELECT Name FROM Contacts)FROM Account WHERE Id IN : Acc]){
    Acc.Number_of_Admins_in_this_Account__c = acc.Contacts.size();
    updatedAccounts.add(acc);
}    
update updatedAccounts;
}