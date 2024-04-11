@isTest
private class DailyLeadProcessorTest {
    @testSetup
    static void setup(){
        List<Lead>  ldlst = new List<Lead>();
        for(Integer i = 1 ; i <= 200; i++){
            lead ld = new lead(Company='c' +i, LastName='LN' +i, Status='Working - Contacted');
            ldlst.add(ld);
        }
        insert ldlst;
    }
    
    static testmethod void testDailyLeadProcessorScheduledJob(){
        string sch = '0 5 12 * * ?';
        test.startTest();
        String jobId = system.schedule('NewTest', sch, new DailyLeadProcessor());
        
        List<lead> ldlst =[SELECT id From Lead WHERE LeadSource = null Limit 200];
        system.assertEquals(200, ldlst.size());
        test.stopTest();
    }
}