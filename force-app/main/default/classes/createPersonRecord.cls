public class createPersonRecord {
@auraEnabled
    public static Person__c SaveRecord(Person__c pp){
        upsert pp;
        return pp;
    }
}