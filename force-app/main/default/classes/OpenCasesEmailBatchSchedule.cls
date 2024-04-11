public class OpenCasesEmailBatchSchedule implements Database.Batchable<sObject>, Database.Stateful{
    String header = 'CaseID,CaseNumber,Status,IsClosed'+'\n';
    Integer i = 0;
    Integer j = 1;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT id,CaseNumber,Status,isClosed FROM case where isClosed = false');
    }
    
    public void execute(Database.BatchableContext bc, List<Case> scope){
        for(Case cse :scope){
            String Recordstr = cse.id+','+cse.CaseNumber+','+cse.Status+','+cse.IsClosed+'\n';
            header= header+Recordstr;
        }
        i++;
        if(i==5){
            String todaydate = system.today().format();
            system.debug('todaydate--'+todaydate);
            Date tdyDate = date.today();
			String dateStr =  tdyDate.day() +'-'+tdyDate.month()+'-' +tdyDate.year();
            system.debug('dateStr--'+dateStr);
            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            blob excel = blob.valueOf(header);
            system.debug('excelfile'+excel);
            attach.setBody(excel);
            attach.setFileName('OpenCasesRecords.xls');
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String UserEmail = UserInfo.getUserEmail();
            String[] toAddresses = new String[] {UserEmail};
                mail.setToAddresses(toAddresses);
            System.debug('ToAddresses'+toAddresses);
            mail.setTargetObjectId(UserInfo.getUserId());
            mail.setSubject('Please find all the open cases of the date :'+dateStr+'Sheet No.'+j);
            mail.setPlainTextBody('Open Cases Report of date '+dateStr+ 'is attached below :');
            mail.setFileAttachments(new Messaging.EmailFileAttachment[]{attach});            
            mail.setSaveAsActivity(false);
            
            try{
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
            } catch (exception e){
                system.debug('Error '+e.getMessage());
            }
            i=0;
            j++;
            Header = '';
        }
    }
    
    public void finish(Database.BatchableContext bc){
    }
}