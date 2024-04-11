public class CustomSearchController {
    @AuraEnabled
    public static List<Contact> CntLst() {
      List<Contact> ctlst = [SELECT ID, name FROM Contact];
        return ctlst;
    }
}