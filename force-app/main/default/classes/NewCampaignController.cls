public class NewCampaignController {
    @auraEnabled
    public static List<Campaign> getRecentCampaignLst (){
        List<Campaign> cmplist = [SELECT Id, Name, Type, Status, EndDate, StartDate, IsActive FROM Campaign 
                                  ORDER BY LastViewedDate DESC LIMIT 10];
        return cmplist;
    }
}