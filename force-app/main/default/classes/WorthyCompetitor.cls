@isTest
private class WorthyCompetitor {
    @isTest static void valuedOpp() {
        list<Opportunity> Opplst = new List<Opportunity>();
        
        Opportunity opp = new Opportunity();
        opp.Name 		= 'TestOpp';
        opp.CloseDate 	= system.today();
        opp.StageName	= 'Qualification';
        
        opp.Competitor_1_Price__c = 24000;
        opp.Competitor_2_Price__c = 25001;
        opp.Competitor_3_Price__c = 24099;
        
        opp.Leading_Competitor_1__c = 'Google';
        opp.Leading_Competitor_2__c = 'Amazon';
        opp.Leading_Competitor_3__c = 'Oracle';
        Opplst.add(opp);
        
        //Record no.2 
        Opportunity opp1 = new Opportunity();
        opp1.Name 		= 'TestOpp1';
        opp1.CloseDate 	= system.today();
        opp1.StageName	= 'Qualification';
        
        opp1.Competitor_1_Price__c = 25003;
        opp1.Competitor_2_Price__c = 25001;
        opp1.Competitor_3_Price__c = 25002;
        
        opp1.Leading_Competitor_1__c = 'Google';
        opp1.Leading_Competitor_2__c = 'Amazon';
        opp1.Leading_Competitor_3__c = 'Oracle';
        Opplst.add(opp1);
        
         // Record No. 3    
         Opportunity opp2 = new Opportunity(); 
        opp2.Name 		= 'TestOpp2';
        opp2.CloseDate 	= system.today();
        opp2.StageName	= 'Qualification';
        
        opp2.Competitor_1_Price__c = 25000;
        opp2.Competitor_2_Price__c = 25001;
        opp2.Competitor_3_Price__c = 24099;
        
        opp2.Leading_Competitor_1__c = 'Google';
        opp2.Leading_Competitor_2__c = 'Amazon';
        opp2.Leading_Competitor_3__c = 'Oracle';
        Opplst.add(opp2);
        insert Opplst;
    }
}