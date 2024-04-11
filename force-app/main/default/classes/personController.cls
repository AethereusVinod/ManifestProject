public class personController{
    @auraEnabled
    public static List<Person__c> personMethod(){
        List<Person__c> personlist = new List<Person__c>([SELECT Id, Name,Last_name__c,Mobile_No__c,Email__c,DOB__c,Date_of_Joining__c,Description__c FROM Person__c]);
        return personlist;
        }
    }