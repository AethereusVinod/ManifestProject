({
    getPicklistValues: function(component, event) {
        console.log('Inside picklist values');
        var action = component.get("c.getGenderFieldValue");
        console.log('Action of Picklist', action);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('State_ Picklist',state);
                var result = response.getReturnValue();
                var fieldMap = [];
                for(var key in result){
                    fieldMap.push({key: key, value: result[key]});
                }
                component.set("v.fieldMap", fieldMap);
            }
        });
        $A.enqueueAction(action);
    },
})