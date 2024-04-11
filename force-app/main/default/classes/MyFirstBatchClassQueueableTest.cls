@isTest
public class MyFirstBatchClassQueueableTest {
    static testmethod void test1(){
        Test.startTest();        
        System.enqueueJob(new MyFirstBatchClassSchedule());
        Test.stopTest();
        
        contact c = new contact();
        c.FirstName = 'hsvayi';
        c.LastName = 'cvusv';
        insert c;
    }
}