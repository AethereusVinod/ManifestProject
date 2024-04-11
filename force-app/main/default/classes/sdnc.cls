public class sdnc {
    public static void Method(){
        List<Case> cselst = [SELECT id, casenumber,subject,status FROM Case WHERE status = 'new'];
        system.debug('cselist '+cselst);
        Map<Id, case> CseMap = new Map<Id, case>();
        system.debug('cseMap'+cseMap);
        for(case cc : cselst){
            case oldinstance = (case)CseMap.get(cc.id);
            system.debug('ID '+oldinstance);
        }
    }
}