trigger EmailMessageTrigger on EmailMessage (after insert) {
    
    set<String> Emails = new Set<String>();
    List<Contact> con = [SELECT Id, Name , Email From COntact WHERE EMail IN: Emails];
    for(EmailMessage message : trigger.new) {
        Emails.add(message.FromAddress);
         if(message.incoming == true) {
            
            if(con.size()==0) {
                Notification__c notifi = new Notification__c();
                notifi.Name =	message.fromName;
                notifi.Email_Notification__c = 'No match Found';
                insert notifi;
                System.debug('Record Creating');
            }
            
            if(con.size()>=2) {
                Notification__c notifi = new Notification__c();
                notifi.Name =	message.fromName;
                notifi.Email_Notification__c = 'Mutliple Match Found';
                insert notifi;
                System.debug('Record Creating');
            }
            
            if(con.size()==1) {
                Notification__c notifi = new Notification__c();
                notifi.Email_Notification__c = 'Match Found';
                notifi.Name =	message.fromName;
                insert notifi;
                System.debug('Record Creating');
            }
        }
    }
    system.debug('Con List-->'+Con);
}