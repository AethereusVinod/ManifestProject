trigger AppleWatch on Opportunity (after insert) {
    for(Opportunity opp : trigger.new) {
        Task t = new Task();
        t.Subject     = 'Apple Watch Promo';
        t.Description = 'Send me ASAP';
        t.Priority    = 'High';
        t.WhatId      = opp.Id;
        insert t;
    }   
    
}