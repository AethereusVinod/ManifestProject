trigger WorthyCompetitor on Opportunity (before insert, before update) {
    
    for(Opportunity opp:trigger.new) {
        
        if((opp.Competitor_1_Price__c >= opp.Competitor_2_Price__c)&&(opp.Competitor_1_Price__c >= opp.Competitor_3_Price__c)){
            opp.Leading_Competitor__c   = opp.Leading_Competitor_1__c;
            opp.Competitor_Price__c     = opp.Competitor_1_Price__c;
            system.debug(' Comp 1 '+opp.Leading_Competitor__c );
            system.debug(' Comp 1 '+opp.Competitor_Price__c );
        }
        else if((opp.Competitor_2_Price__c >= opp.Competitor_1_Price__c)&&(opp.Competitor_2_Price__c >= opp.Competitor_3_Price__c)){
            opp.Leading_Competitor__c   = opp.Leading_Competitor_2__c;
            opp.Competitor_Price__c     = opp.Competitor_2_Price__c;
            system.debug(' Comp 2 '+opp.Leading_Competitor__c );
            system.debug(' Comp 2 '+opp.Competitor_Price__c );
        }
        
        else if((opp.Competitor_3_Price__c >= opp.Competitor_2_Price__c)&&(opp.Competitor_3_Price__c >= opp.Competitor_1_Price__c)){
            opp.Leading_Competitor__c   = opp.Leading_Competitor_3__c;
            opp.Competitor_Price__c     = opp.Competitor_3_Price__c;
            system.debug(' Comp 3 '+opp.Competitor_Price__c);
            system.debug(' Comp 3 '+opp.Leading_Competitor__c );
        }
    }
}