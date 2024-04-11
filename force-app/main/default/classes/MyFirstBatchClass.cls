public  class  MyFirstBatchClass implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT id, CaseNumber, (Select id from cases) from Case';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Case> scope){
        list<case> ctlst = [Select id , Main_Case__c, CaseNumber, (Select id from cases) from case where ID IN : scope];
        system.debug('scope list'+scope);
        list <case> cse = new list<case>();
        for (case cc : ctlst) {
            if(cc.cases.size() >= 1) {
                cc.Main_Case__c = true;
                system.debug('fuckme');
            }
            cse.add(cc);
        }
        update scope;
        system.debug('ctlst'+ctlst);
        system.debug('cse'+cse);
    }
    
    public void finish(Database.BatchableContext bc){
    }
}