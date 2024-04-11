({
    init : function(component, event, helper) {
        component.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Type', fieldName: 'Type', type: 'text'},
            {label: 'Status', fieldName:'Status', type: 'text'},
            {label: 'Start Date', fieldName:'StartDate', type: 'Date'},
            {label: 'End Date', fieldName:'EndDate', type: 'Date'},
            {label: 'IsActive ', fieldName:'IsActive ', type: 'Boolean'}
        ]);
        
        var action = component.get('c.getRecentCampaignLst');
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var allValues = response.getReturnValue();
                component.set('v.data', allValues);
            }
            else if(state === "ERROR") {
                var errors = response.getError();
                if(errors){
                    if(errors[0] && errors[0].message){
                        console.log("Error Message: " + errors[0].message);
                    }
                }
                else{
                    console.log("Unknown Error");
                }
            }
        });
        $A.enqueueAction(action);
        
    }
})