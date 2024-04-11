public class CaseFormController {
    
    @AuraEnabled
    public static List<Case> fetchCase(){
        List<Case> caselst = [SELECT Id, CaseNumber, Status, Subject, Description FROM Case];
        return caselst;
    }

}