public class OpenCasesEmailBatch implements Database.Batchable<sObject> {
    String header = 'CaseID,CaseNumber,Status,IsClosed'+'\n';
    public List<Case> CaseData {get;set;}
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT id,CaseNumber,Status,isClosed FROM case where isClosed = false');
    }
    
    public void execute(Database.BatchableContext bc, List<Case> scope){
        System.debug('Inside Excel File Method');
        //CaseData = [SELECT id, CaseNumber, Status, isClosed from case where isClosed = false AND Status ='Working' LIMIT 2];
        
        for(Case cse :scope){
            String Recordstr = cse.id+','+cse.CaseNumber+','+cse.Status+','+cse.IsClosed+'\n';
            header= header+Recordstr;
        }
    }
    
    public void finish(Database.BatchableContext bc){
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        blob excel = blob.valueOf(header);
        system.debug('excelfile'+excel);
        attach.setBody(excel);
        attach.setFileName('OpenCasesRecords.xls');
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //String userName = UserInfo.getUserName();
        //User activeUser = [Select Email From User where Username = : userName limit 1];
        //String userEmail = activeUser.Email;
        //system.debug('UserEmail '+userEmail);
        String UserEmail = UserInfo.getUserEmail();
        String[] toAddresses = new String[] {UserEmail};
            mail.setToAddresses(toAddresses);
        System.debug('ToAddresses'+toAddresses);
        mail.setTargetObjectId(UserInfo.getUserId());
        mail.setSubject('Please find all the open cases of the date :'+date.today());
        mail.setPlainTextBody('Open Cases Report of date '+date.today()+ 'is attached below :');
        mail.setFileAttachments(new Messaging.EmailFileAttachment[]{attach});
        mail.setSaveAsActivity(false);
        try{
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        } catch (exception e){
            system.debug('Error '+e.getMessage());
        }
    }
}