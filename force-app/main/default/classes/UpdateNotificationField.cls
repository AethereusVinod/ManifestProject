global class UpdateNotificationField implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        system.debug('Run me');
        
        if(email.fromAddress!=null){
        List<Contact> con = new List<Contact>([SELECT Id, Name , Email From COntact WHERE EMail =: email.fromAddress]);
        
        Notification__c notifi = new Notification__c();
        notifi.Received_Email__c = email.fromAddress;
        notifi.Name =   email.fromName; 
        if(con.size()==0) 
            notifi.Email_Notification__c = 'No match Found';
        else if(con.size()>=2) 
            notifi.Email_Notification__c = 'Mutliple Match Found';
        else if(con.size() == 1) 
            notifi.Email_Notification__c = 'Match Found';        
        insert notifi;
        }
        return result;
    }
}