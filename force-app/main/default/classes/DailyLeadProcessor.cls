public class DailyLeadProcessor implements Schedulable{
    public void execute(SchedulableContext ctx){
        list<Lead> ldlst = [SELECT id FROM Lead WHERE leadsource = null LIMIT 200];
        
        list<Lead> UpdatedLead = new List<Lead>();
        if(!ldlst.isEmpty()){
            for(lead ld : ldlst){
                ld.LeadSource = 'Dreamforce';
                UpdatedLead.add(ld);
            }
        }
        update UpdatedLead;
    }
}