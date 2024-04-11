@isTest
private class Ldtrigger {
    
    @isTest static void LdNewTest(){
        lead ld = new lead();
        ld.FirstName = 'alhabbibi';
        ld.LastName  = 'habibi';
        ld.Company   =  'Google';
        insert ld;
        update ld;
    }   
}