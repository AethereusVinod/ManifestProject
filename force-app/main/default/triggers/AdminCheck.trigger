trigger AdminCheck on Contact (before insert,after insert, after update) {
    
    list<Contact> ContactsListWithAdminCheck = new list<Contact>([SELECT AccountId, Name FROM Contact WHERE Admin__c = true ]);
    list<Contact> ContactsListWithNoAdminCheck = new list<Contact>([SELECT AccountId, Name FROM Contact WHERE Admin__c =false]);
    
    for(Contact con: trigger.new){
        if(con.AccountId != null){
            if(con.admin__c = true){
                ContactsListWithAdminCheck.add(con);
            }
            else{
                ContactsListWithNoAdminCheck.add(con);
            }
        }
    }
  
}