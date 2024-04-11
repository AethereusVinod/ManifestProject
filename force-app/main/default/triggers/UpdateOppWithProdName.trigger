trigger UpdateOppWithProdName on OpportunityLineItem (after insert, before Update, after delete) {
    SET<Id> oliIds = new SET<Id>();
    for(OpportunityLineItem oli : trigger.new){
        oliIds.add(oli.OpportunityId);
        system.debug('****oli****'+oli);
    }
    
    List<OpportunityLineItem> oliList =[SELECT Id, OpportunityId, Product2.Name, ProductCode, Name FROM OpportunityLineItem 
                                        WHERE OpportunityId IN: oliIds];
    system.debug('*******oliList******'+oliList);
    
    
    Map<Id, String> OliMap = new Map<Id, String>();
    List<String> strlist = new List<String>();
    string str;
    for(OpportunityLineItem ol : oliList){
        if(str!=''){
            str = str+';'+ol.Product2.Name;
        }
        strlist.add(ol.Product2.Name);
        if(OliMap.containsKey(ol.id)){
            if(OliMap.get(ol.id)!=null){
                OliMap.put(ol.OpportunityId, OliMap.get(ol.id)+';'+ol.Product2.Name);
            }
        }
        else{
            OliMap.put(ol.OpportunityId, ol.Product2.Name);
        }
    }
    system.debug('Map '+OliMap);
    system.debug('**strlist**'+strlist);
    system.debug('**str**'+str);
    
}