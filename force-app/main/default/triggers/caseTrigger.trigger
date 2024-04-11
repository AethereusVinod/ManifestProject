trigger caseTrigger on Case (before Insert, After Insert, Before Update, After Update) {
    
    if (trigger.IsAfter && trigger.isInsert){
        caseTriggerHandler.AfterInsertOperations(Trigger.New);
    }
    else if  (trigger.isAfter && trigger.isUpdate){
        caseTriggerHandler.AfterUpdateOperations(Trigger.OldMap,trigger.new);
    } 
}