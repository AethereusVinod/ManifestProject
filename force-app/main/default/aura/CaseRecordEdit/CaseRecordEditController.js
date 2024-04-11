({
    doInit : function(component, event, helper) {
        var action = component.get("c.fetchCase");
        action.setCallback(this, function(response){
            var state = response.getState();
            var packSizeArray = response.getReturnValue();
            console.log('packSizeArray '+JSON.stringify(packSizeArray));
            component.set("v.CaseInfo",packSizeArray);
        });
        $A.enqueueAction(action);     
    },
    
    handleOnChange : function(component, event, helper){
        console.log('Selected Item *****'+component.get("v.CaseSelected"));
        component.set("v.RecordType", true);
    },
    
    handleSubmit : function(component, event, helper){
        console.log('Submit Called');
        var eventParams = event.getParams();
        console.log(''+JSON.stringify(eventParams));
    }
})