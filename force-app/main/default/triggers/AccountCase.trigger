trigger AccountCase on Account (before insert) {
    for(Account a : trigger.new) {
        Case c = new Case();
        c.subject = 'Dedupe the Account';
        c.AccountId = a.Id;
        insert a;
    }    
}