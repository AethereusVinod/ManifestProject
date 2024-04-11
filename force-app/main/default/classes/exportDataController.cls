public class exportDataController {
    @AuraEnabled
    public static wrapperclass ExportData(){
        List<Account> aclst = [SELECT id, Name From Account LIMIT 10];
        List<Contact> cnlst = [Select id, Name, Account.Name, MobilePhone,Email FROM Contact LIMIT 10];
        List<Case> cslst = [SELECT id, CaseNumber FROM Case LIMIT 10];
        wrapperclass wc = new wrapperclass();
        wc.actlst = aclst;
        wc.cntlst = cnlst;
        wc.cselst = cslst;
        return wc;
    }

    public class wrapperclass{
        @AuraEnabled public List<Account> actlst{get;set;}
        @AuraEnabled public List<contact> cntlst{get;set;}
        @AuraEnabled public List<Case> cselst{get;set;}
    }
}