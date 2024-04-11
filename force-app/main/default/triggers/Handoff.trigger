trigger Handoff on Top_X_destination__c (after insert , after updATE) {
    if(trigger.isAfter && (trigger.isInsert  || trigger.isUpdate)){
        HandoffClass.HandoffClassMethod(trigger.new);
    }
    
    if(trigger.isAfter && trigger.isDelete){
       HandoffClass.HandoffClassMethodOld(trigger.old);
    }
}