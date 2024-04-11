trigger AppleWatchGold on Opportunity (before insert) {
    for(Opportunity Opp : trigger.new){
        if(opp.Amount > 25000){
            task t = new task();
            t.Priority      = 'High';
            t.Description   = 'missing you';
            t.whatId        = opp.Id;
            t.Subject       = 'Love me';
            insert t;
        }
    }
}