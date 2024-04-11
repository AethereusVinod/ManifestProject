@isTest
private class AppleWatchGoldTest {
    @isTest static void Gold(){
        Opportunity opp = new Opportunity();
        opp.Name 		= 'Love';     
        opp.StageName 	= 'Qualification';
        opp.CloseDate	= date.today();
        opp.Amount		= 25001;
        insert opp;
    }
}