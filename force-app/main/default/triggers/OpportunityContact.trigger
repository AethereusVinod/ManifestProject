trigger OpportunityContact on Opportunity (before insert) {
    Contact c = new Contact();
    for(Opportunity Opp : trigger.new){
        c.AccountId = Opp.AccountId;
        c.FirstName = 'Opportunity';
        c.LastName = 'Owner';
        insert c;
    }

}