global with sharing class FitnessAppController {
    @AuraEnabled
    public static Contact createContact(Contact ContObj){
        insert contObj;
        String contactId = contObj.id;
        Contact con = [SELECT id, FirstName,BMI__c,BMI_Type__c,Daily_Activity_Multiplier__c,Body_Fat__c,Current_Weight__c,Daily_Calorie_Maintainence__c,Gender__c,
                       Height__c,Lean_Ratio__c,Target_Weight__c,Total_calorie_needed__c,Weight_Difference__c,Birthdate,Calories_burn_by_exercise__c,Food_Calorie__c
                       FROM Contact where id=:contactId];
        return con;
    }
    
    @AuraEnabled 
    public static Map<String, String> getGenderFieldValue(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Contact.Gender__c.getDescribe();
        List<Schema.PicklistEntry> pValues = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pValues) {
            options.put(p.getValue(), p.getLabel());
        }
        system.debug('options'+options);
        return options;
    }
    
    @AuraEnabled
    public static Contact emailFetch(string email){
        string emailAddress = email;
        Contact con = [SELECT id, FirstName,BMI__c,BMI_Type__c,Daily_Activity_Multiplier__c,Body_Fat__c,Current_Weight__c,Daily_Calorie_Maintainence__c,
                       Gender__c,Height__c,Lean_Ratio__c,Target_Weight__c,Total_calorie_needed__c,Weight_Difference__c,Birthdate,Calories_burn_by_exercise__c,Food_Calorie__c
                       FROM Contact where email=:emailAddress  ORDER BY CreatedDate DESC LIMIT 1];
        return con;
    }
        
    @AuraEnabled
    public static List<clientDetails> getSuggestionsInfo(String emailAddress){
        List<clientDetails> dailyCal= new List<clientDetails>();
        Contact cc = [SELECT id, FirstName,BMI__c,BMI_Type__c,Daily_Activity_Multiplier__c,Body_Fat__c,Current_Weight__c,Daily_Calorie_Maintainence__c,
                      Gender__c,Height__c,Lean_Ratio__c,Target_Weight__c,Total_calorie_needed__c,Weight_Difference__c,Birthdate,Calories_burn_by_exercise__c,Food_Calorie__c	
                      FROM Contact where email=:emailAddress  ORDER BY CreatedDate DESC LIMIT 1];
        
        integer calorieMax = 2200;
        while(calorieMax >= 1700){
            clientDetails info = new clientDetails();
            info.totalCalorieNeeded = cc.Total_calorie_needed__c;
            info.dailyCalorieMaintainence = cc.Daily_Calorie_Maintainence__c;
            info.foodCalorie = calorieMax;
            info.Suggestion  = calorieMax - 200;
            info.calorieDeficitPerDay = info.dailyCalorieMaintainence - info.Suggestion;
            info.dailyCalorieIntake = info.dailyCalorieMaintainence - info.calorieDeficitPerDay;
            info.timeRequired = info.totalCalorieNeeded/(7*info.calorieDeficitPerDay);
            calorieMax = calorieMax - 100;
            dailyCal.add(info);
        }
        return dailyCal;
    }
    
    public class clientDetails{
        @AuraEnabled
        public Integer foodCalorie{get;set;}
        @AuraEnabled
        public Decimal dailyCalorieIntake{get;set;}
        @AuraEnabled
        public Integer Suggestion{get;set;}
        @AuraEnabled
        public Decimal calorieDeficitPerDay{get;set;}
        @AuraEnabled
        public Decimal timeRequired{get;set;}
        @AuraEnabled
        public Decimal totalCalorieNeeded{get;set;}
        @AuraEnabled
        public Decimal dailyCalorieMaintainence{get;set;}
        @AuraEnabled
        public Contact con{get;set;}
    }
}