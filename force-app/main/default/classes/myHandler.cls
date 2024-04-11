global class myHandler implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        system.debug('Run me');
        
        List<Contact> con = [SELECT Id, Name , Email From COntact WHERE EMail =: email.fromAddress];
        
        if(con.size()==0) {
            Notification__c notifi = new Notification__c();
            notifi.Name =	email.fromName;
            notifi.Email_Notification__c = 'No match Found';
            insert notifi;
            System.debug('Record Creating');
        }
        
        if(con.size()>=2) {
            Notification__c notifi = new Notification__c();
            notifi.Name =	email.fromName;
            notifi.Email_Notification__c = 'Mutliple Match Found';
            insert notifi;
            System.debug('Record Creating');
        }
        
        if(con.size()==1) {
            Notification__c notifi = new Notification__c();
            notifi.Email_Notification__c = 'Match Found';
            notifi.Name =	email.fromName;
            insert notifi;
            System.debug('Record Creating');
        }
        
        system.debug('Con List-->'+Con);
        return result;
    }
}