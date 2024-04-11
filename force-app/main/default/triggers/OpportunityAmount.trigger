trigger OpportunityAmount on Opportunity (before insert, before update) {
    for(opportunity opp : trigger.new){
        if(trigger.isInsert && opp.Amount<=5000){
            opp.addError('Amount should not be less than 5000');
        }
        
        if(trigger.isUpdate && opp.Amount<=3000){
            opp.addError('Amount should not be less than 3000'); 
        }
        
    }
}