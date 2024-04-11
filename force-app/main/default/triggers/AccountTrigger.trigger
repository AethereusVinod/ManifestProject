trigger AccountTrigger on Account(before update){
    if(trigger.isUpdate && trigger.isBefore) {
        Map<Id,List<String>> ActEmailAddresses = new Map<Id,List<String>>(); 
        for(Account acc : trigger.new){
            if(acc.ContactEmails__c	 != null){
                ActEmailAddresses.put(acc.id, string.valueof(acc.ContactEmails__c	).split(','));
            }
        }
        List<Contact> cntlst = [SELECT id, Name, Email, AccountId FROM Contact 
                                WHERE Accountid IN: ActEmailAddresses.keyset()];
        
        List<String> createContacts = new List<String>();
        List<String> ExistContacts = new List<String>();
        
        for(Contact con : cntlst){
            if(ActEmailAddresses.containsKey(con.AccountId)){
                List<String> strlst = ActEmailAddresses.get(con.AccountId);
            }
        }
    }
}