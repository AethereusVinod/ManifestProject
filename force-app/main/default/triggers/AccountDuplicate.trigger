trigger AccountDuplicate on Account (after insert,after update, before delete) {
    
    /*if(triggerhandler.isFirstTime){
        triggerhandler.isFirstTime = false;
        list<Account> AccountName = new List<Account>();
        for(Account acc : trigger.new) {
            Account acct = new Account(Name='Alpha'+acc.Name, Email__c =acc.Email__c);
            AccountName.add(acct);
        }
        //insert AccountName ;
    }*/
    if(trigger.isInsert && trigger.isAfter) {
        List<Opportunity> opplist = new List<Opportunity>();
        for(account acc : trigger.new){
            if(acc.Industry=='Agriculture'){
                Opportunity opp = new Opportunity();
                opp.AccountId = acc.Id;
                opp.Name = 'Test Opp';
                opp.StageName = 'Prospecting';
                opp.CloseDate = system.today()+30;
                opplist.add(opp);
                system.debug('Opp inserted');
            }
        }
        insert opplist;
    }
    
    if(trigger.isUpdate && trigger.isAfter) {
        Map<Id,Account> accOldMap = Trigger.oldMap;
        Map<Id,Account> ownerIdMap = new Map<Id,Account>();
        List<Opportunity> opplist = new List<Opportunity>();
        
        for(account acc : trigger.new){
            if((acc.OwnerId)!= accOldMap.get(acc.Id).ownerId){
                ownerIdMap.put(acc.id,acc);
                System.debug('OwnerId populated to the Map');
            }
            if(acc.Industry != accOldMap.get(acc.Id).Industry && acc.Industry == 'Agriculture'){
                Opportunity opp = new Opportunity();
                opp.AccountId = acc.Id;
                opp.Name = 'Test Opp';
                opp.StageName = 'Prospecting';
                opp.CloseDate = system.today()+30;
                opplist.add(opp);
            }
        }
        insert opplist;
        
        List<Contact> contlst = [SELECT id, AccountID , OwnerId FROM Contact WHERE AccountID IN: ownerIdMap.keyset()];
        system.debug('Size of contacts related to account :'+contlst.size()+'ContactList-->'+contlst);
        for(contact cc : contlst) {
            cc.OwnerId = ownerIdMap.get(cc.AccountId).OwnerId;
            system.debug('Contact owner updated');
        }
        update contlst;
    }
    if(trigger.isBefore && trigger.isDelete){
        Set<Id> actIds = new Set<Id>();
        for(account act : trigger.old){
            actIds.add(act.id);
        }
        List<account> actlst = [SELECT id, Name ,(SELECT id from COntacts) From Account Where Id IN: actIds];
        for(account acc : actlst){
            if(acc.Contacts.size()>0){
                system.debug('Delete operation cannot be done');
                Trigger.Oldmap.get(acc.Id).addError('Account cannot be deleted having contacts');
            }
        }
    }
}