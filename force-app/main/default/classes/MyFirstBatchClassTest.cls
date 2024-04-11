@isTest
public class MyFirstBatchClassTest {
    @testSetup 
    static void setup() {
        List<Contact> cntt = new list<Contact>();
        for (Integer i=0;i<30;i++) {
            cntt.add(new Contact(FirstName='Contact '+i, LastName= 'ds'));
        } 
        insert cntt;
    }
    static testmethod void test() {      
        Test.startTest();
        MyFirstBatchClass mfbc = new MyFirstBatchClass();
        Id batchId = Database.executeBatch(mfbc);
        test.stopTest();
    }
    
}