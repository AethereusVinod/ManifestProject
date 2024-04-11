global class xyzEmailServices implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        if(email.fromAddress!=null && 
           email.subject != null && 
           email.plainTextBody.contains('<Name>') && 
           email.plainTextBody.contains('<Email>') && 
           email.plainTextBody.contains('</Name>') &&
           email.plainTextBody.contains('</Email>')) {
               system.debug('Inside Loop');
               
               string Name = email.plainTextBody.substringBetween('<Name>','</Name>');
               string Emal = email.plainTextBody.substringBetween('<Email>','</Email>');
               system.debug('Name : '+Name);
               system.debug('Email : '+Emal);
               system.debug('Subject : '+email.Subject);
               system.debug('Description : '+email.plainTextBody);
               
               List<Contact> con = [SELECT Id, Name , Email FROM Contact WHERE Email =: emal LIMIT 1];
               {
                   //Fetching the assignment rules on case
                   AssignmentRule AR = new AssignmentRule();
                   AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
                   
                   //Creating the DMLOptions for "Assign using active assignment rules" checkbox
                   Database.DMLOptions dmlOpts = new Database.DMLOptions();
                   dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
                   
                   if (con.size()==0) {
                       system.debug('Size 0');
                       Contact cnt  	= new Contact();
                       cnt.LastName		= Name;
                       cnt.Email		= Emal;
                       insert cnt;
                       
                       case cse		= 	new case();
                       cse.ContactId	=	cnt.id;
                       cse.Subject		=	email.Subject;
                       cse.Description	= 	email.plainTextBody;
                       cse.setOptions(dmlOpts);
                       insert cse;
                       
                   }
                   else {
                       system.debug('Size > 0');
                       for (contact co : con) {
                           case cse		= 	new case();
                           cse.ContactId	=	co.id;
                           cse.Subject		=	email.subject;
                           cse.Description	=	email.plainTextBody;
                           insert cse;
                       }
                   }
               }
           } 
        
        else if(email.fromAddress!=null && 
                email.subject != null && 
                email.plainTextBody.contains('Name') &&
                email.plainTextBody.contains('Email')) {
                    
                    List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();
                    Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
                    List<String> sendTo = new List<String>();
                    sendTo.add(email.fromAddress);
                    mail.setToAddresses(sendTo);
                    mail.setSubject('Creating your case');
                    string body = 'We have created a case ';
                    body += 'with Contact name ' +email.fromName;
                    body += ' Email: '+email.fromAddress;
                    mail.setPlainTextBody(body);
                    mails.add(mail);
                    Messaging.sendEmail(mails);               
                    
                    List<Contact> cont = [SELECT Id, Name , Email FROM Contact WHERE Email =: email.fromAddress LIMIT 1];
                    if(cont.size()==0) {
                        system.debug('Size 0');
                        Contact cnt  	= new Contact();
                        cnt.LastName		= email.fromName;
                        cnt.Email		= email.fromAddress;
                        insert cnt;
                        
                        AssignmentRule AR = new AssignmentRule();
                        AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
                        
                        Database.DMLOptions dmlOptns = new Database.DMLOptions();
                        dmlOptns.AssignmentRuleHeader.assignmentRuleId= AR.id;
                        
                        case cse		= 	new case();
                        cse.ContactId	=	cnt.id;
                        cse.Subject		=	email.Subject;
                        cse.Description	= 	email.plainTextBody;
                        cse.setOptions(dmlOptns);
                        insert cse;
                        
                    }
                    else{
                        AssignmentRule AR = new AssignmentRule();
                        AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
                        
                        Database.DMLOptions dmlOptns = new Database.DMLOptions();
                        dmlOptns.AssignmentRuleHeader.assignmentRuleId= AR.id;
                        
                        system.debug('Size > 0');
                        for (contact co : cont) {
                            case cse		= 	new case();
                            cse.ContactId	=	co.id;
                            cse.Subject		=	email.subject;
                            cse.Description	=	email.plainTextBody;
                            cse.setOptions(dmlOptns);
                            insert cse;
                        }
                    }
                }
        return result;
    }
}