trigger oppContactCreate on Opportunity (before insert, before update) {
    List<Contact> NewContactt = new List<Contact>();
    Set<Id> AccountIDs = new Set<Id>();
    List<Contact> NewContact = [SELECT AccountId, LastName, Email From Contact WHERE AccountId IN: AccountIDs];
    Map<Id, Map<String,String>> AccountContactMap = new Map<Id, Map<String,String>>();
    Map<String,String> ContactNameAndEmail = new Map<String, String>();
    Map<Id, Contact> ContAccmap = new Map<Id, Contact>(NewContact);
    for(contact con : ContAccmap.values()){
        ContactNameAndEmail.put(con.LastName, con.Email);
    }
    
    list <String> Emails = ContactNameAndEmail.values();
    
    for(Opportunity opp : trigger.new){
        System.debug('opp created');
        if(opp.StageName=='Closed Won' && 
           opp.AccountId!=null && 
           /* AccountContactMap.get(opp.AccountId) != null &&*/
           !ContactNameAndEmail.containsKey(opp.Name) && 
           Emails!=null && 
           !Emails.contains(opp.Email__c)){
               system.debug('Inside Loop');
               //Creating a new Contact
               
               Contact c = new contact();
               c.AccountId  = opp.AccountId;
               c.LastName   = opp.Name;
               c.Email      = opp.Email__c;
               
               system.debug('Contact created');
               NewContactt.add(c);
               system.debug(c);
               system.debug('Added to list');
           }
        
    }
    insert NewContactt;
    system.debug('Contact updated');
}