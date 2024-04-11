({
    Create : function(component, event, helper) {
        var createp = component.get('v.createPerson');
        var action = component.get('c.SaveRecord');
        
        action.setParams({
            "pp" : createp
        });
        
        action.setCallback(this, function(a) {
            var state = a.getState();
            if (state === "SUCCESS") {
                var name = a.getReturnValue();
                console.log(name);
                alert('Record created Sucessfully')
            }
        });
        $A.enqueueAction(action)
    }
})