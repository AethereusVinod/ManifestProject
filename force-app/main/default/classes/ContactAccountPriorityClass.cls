public class ContactAccountPriorityClass {
    public static void ContactAccountPriorityMethod(List<Contact> Conlist){ 
        /*Set<ID> AccId = new Set<ID>();
        List<Account> Acclist = new List<Account>();
        List<Account> UpdateAcclist = new List<Account>();
        
        For(Contact con : Conlist){
            AccId.add(con.accountId);
        }
        
        If(AccId.size()>0){
            Acclist = [SELECT ID, CustomerPriority__c FROM Account WHERE Id IN: AccId];
        }
        
        Map<Id, String> AccMap = New Map<Id, String>();
        
        for(Account ac: Acclist){
            AccMap.put(ac.id, ac.CustomerPriority__c);
        }
        
        For(Contact con : Conlist){  
            account acc = new account();
            acc.id = con.accountid;
            String CusPriority = AccMap.get(con.AccountId); 
            system.debug('CusPriority---' +CusPriority);
            if(con.Level__c == 'Primary' && CusPriority != 'High'){
                acc.CustomerPriority__c = 'High';
            }
            if(con.Level__c == 'Secondary' && CusPriority != 'Medium'){
                acc.CustomerPriority__c = 'Medium';
            }
            if(con.Level__c == 'Teritary' && CusPriority != 'Low'){
                acc.CustomerPriority__c = 'Low';
            }
            UpdateAcclist.add(acc);
            System.debug('UpdateAcclist--- '+UpdateAcclist);
        }
        
        if(UpdateAcclist.size()>0){
            System.debug('UpdateAcclist.size()--- '+UpdateAcclist.size());
            Update UpdateAcclist;
        }
    }
    
    public static void ContactAccountPriorityMethod1(List<Contact> Conlist, Map<id,Contact> ConOldMap){ 
        Set<ID> AccId = new Set<ID>();
        
        List<Account> AccList = new List<Account>([SELECT Id, Name From Account WHERE Id IN: AccId]);
        system.debug(' Accounttttt '+AccList);
        
        List<Contact> ConListt = New list<Contact>([SELECT AccountId, Level__c FROM Contact WHERE AccountId IN: AccId  ]);
        if(ConListt != null){
            system.debug('Contacts ---> '+ConListt);
            System.debug(''+AccId);
        }
        
        list<String> LevelValues = new List<String>();
        for(Contact c : ConListt){
            AccId.add(c.accountId);
            LevelValues.add(c.Level__c);
        }
        system.debug('Level Values -->'+LevelValues); 
        
        for(account a: AccList){
            if(LevelValues.contains('Primary') && a.CustomerPriority__c == 'High'){
                a.CustomerPriority__c = 'High';
                system.debug(' Acc-- > Primary');
            }
            
            if(!LevelValues.contains('Primary') && LevelValues.contains('Secondary')){
                a.CustomerPriority__c = 'Medium';
                system.debug(' Acc-- > Secondary');
            }   
            if(!LevelValues.contains('Primary') && !LevelValues.contains('Secondary')){
                a.CustomerPriority__c = 'Low';
                system.debug(' Acc-- > tertiary');  
                
            }
        } 
        Update AccList;
        system.debug(' Updated Account List --> '+AccList); 
        */
    }
}