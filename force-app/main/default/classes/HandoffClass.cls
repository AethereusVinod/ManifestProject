public class HandoffClass {
    public static void HandoffClassMethod(List<Top_X_destination__c> Destination) {
        Set <Id> OppId = new Set<Id>(); 
        List<Opportunity> oppo = new List<Opportunity>([SELECT Id, Handoff_Attached__c FROM opportunity WHERE Id IN: OppId]);
        for(Top_X_destination__c dest : Destination) {
            OppId.add(dest.Opportunity__c);
            if(dest.Type__c == 'Contract Flow Down' || dest.Type__c == 'Handoff'){
                Opportunity opp= new Opportunity();
                opp.Id = dest.Opportunity__c;
                if(dest.Document_Attached__c == true){
                    opp.Handoff_Attached__c = 'Yes';
                    oppo.add(opp);
                }
                else{
                    opp.Handoff_Attached__c = 'No';
                    oppo.add(opp);
                }
            }
        }
        update oppo;
        system.debug('Oppo Update -->'+oppo);
    }
    
    public static void HandoffClassMethodOld(List<Top_X_destination__c> Destination) {
        Set <Id> OppId = new Set<Id>(); 
        List<Opportunity> oppo = new List<Opportunity>([SELECT Id, Handoff_Attached__c FROM opportunity WHERE Id IN: OppId]);
        system.debug('oppo '+oppo);
        system.debug('OppId'+oppId);
        for(Top_X_destination__c dest : Destination) {
            OppId.add(dest.Opportunity__c); 
            Opportunity opp= new Opportunity();
            opp.Handoff_Attached__c = '--None--';
            oppo.add(opp); 
        }
        update oppo;
        system.debug('Oppo Update -->'+oppo);
    }
}