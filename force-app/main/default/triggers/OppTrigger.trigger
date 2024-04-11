trigger OppTrigger on Opportunity (before insert, after insert, before update, after update, before delete) {
    if(trigger.isInsert && trigger.isAfter){
        
    } 
    
    if(trigger.isUpdate && trigger.isAfter){    
        List<Opportunity> oportunities = [Select Id, OwnerId, Name, StageName, Account.OwnerId, Owner.Email, Account.Owner.Email
                                          From Opportunity Where Id IN :Trigger.newMap.keySet()
                                          AND StageName='Closed Won'];
        system.debug('oportunities'+oportunities);
                List<String> sendingTo = new List<String>();

        for(Opportunity opp : oportunities){
            if(opp.StageName=='Closed Won'){
                sendingTo.add(opp.Owner.email);
                system.debug('Owner Email--->'+opp.owner.Email);
            }
        }       
        
        Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
        semail.setToAddresses(sendingTo);
        semail.setSubject('Single Email message Example');
        semail.setPlainTextBody('Hello!!!!!!!!!!This is a test email to test single email message program');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail});
        
    }
    
    if(trigger.isDelete && trigger.isBefore){
        Id profileId=userinfo.getProfileId();
        String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
        system.debug('Profile Name--->'+profileName);
        if(profileName != 'System Administrator'){
            for(opportunity opp: trigger.old){
                if(opp.isClosed==true){
                    trigger.oldmap.get(opp.id).adderror('You are not System Admin thus cannot delete record');
                }    
            }
        }
    }
}