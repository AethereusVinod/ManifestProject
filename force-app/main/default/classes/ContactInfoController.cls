public without sharing class ContactInfoController {
    @AuraEnabled(cacheable=true)
    public static Account fetchAcc (String recId){
        Account acc = [SELECT Id,Name, Phone, Fax,Type, PhotoUrl, Industry, NumberOfEmployees, LastModifiedBy.Name, Owner.Name, 
                       CreatedBy.Name, Website FROM Account WHERE id =: recId LIMIT 1];
        system.debug(acc);
        return acc;
    }  
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> ContList (String accId){
        System.debug('accId'+accId);
        List<Contact> cntlst= [SELECT Id, AccountId, FirstName,LastName, Phone, Email FROM Contact 
                               WHERE AccountId =: accId];
        system.debug('*** contact list ***'+cntlst.size());
        return cntlst;
    }
    
    @AuraEnabled 
    public static string SaveContact(String LastNme, String FirstNme, string Phne, string emal
                                   ,String AccId){
                                       Contact con = new Contact(FirstName = FirstNme, LastName = LastNme,Phone =Phne,
                                                                 Email = emal, AccountId = AccId);
                                       string str;
                                       try{
                                           insert con;  
                                           str= 'SUCCESS';
                                           return str;
                                       } catch (Exception e) {
                                           str = e.getMessage();
											system.debug('error'+e.getMessage());
                                           return str;
                                       }
                                   }
    
    @AuraEnabled
    public static string deleteContacts(List<string> SetcontactIds){
        system.debug('List of contact ids'+SetcontactIds);        
        List<Contact> cntlst = [SELECT id, LastName FROM Contact WHERE id =: SetcontactIds];
        system.debug('cntlst'+cntlst);
        string strr;
        try {
            delete cntlst;
            return 'SUCCESS';
        } catch (Exception e) {
            strr = 'Error : '+e.getMessage();
            return strr;
        }
    }
}