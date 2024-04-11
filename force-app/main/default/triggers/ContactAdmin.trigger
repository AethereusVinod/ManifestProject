trigger ContactAdmin on Contact ( after insert, before Insert){
    if(trigger.isBefore && trigger.isInsert){
        system.debug('Inside Before Update');
        for(Contact con : trigger.new){
            system.debug('Contact AccountId ****'+con.accountId);
			system.debug('Contact AccountId ****'+con.FirstName);
        }
    }
    if(trigger.isAfter && trigger.isInsert){
        Map<Id, String>  actContactMap = new Map<Id,String>();
        for(Contact con : trigger.new){
            if(con.AccountId != null){
                system.debug('AccountId');
                actContactMap.put(con.AccountId, con.Name);
            }
        }
        
        List<Account> actlst = [SELECT id, Name FROM Account WHERE id =:actContactMap.keyset()];
        for(Account act : actlst){
            if(actContactMap.containsKey(act.id)){
                act.Name = actContactMap.get(act.id);
            }
        }
       
        
        List<Account> acclst=new List<Account>();
        acclst=[Select id,name from Account];
        set<id> accid =new set<id>();
        for(Account acc : acclst ){
            accid.add(acc.id);
        }
        
        List<contact> con = [SELECT Id,FirstName,MobilePhone,LastName, Account.Name, Account.Id FROM Contact
                             WHERE AccountId =:accid AND Id IN : Trigger.new] ;
        
        
        List<Account> acc = new List<Account>();
        for(Contact s : con)
        {
            Account a = new Account();
            a.Id = s.AccountId;
            a.Name = s.FirstName+' '+s.LastName;
            System.debug('aaa'+a.Id);
            acc.add(a);
        }
        update acc;
    }
}