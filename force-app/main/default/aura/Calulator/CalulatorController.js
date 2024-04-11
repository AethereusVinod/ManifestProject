({
    Add : function(component, event, helper) {
        var inpt1value = component.get('v.input1');
        var inpt2value = component.get('v.input2');
        
        component.set('v.outPut', parseInt(inpt1value) + parseInt(inpt2value));
    },
    Subtract : function(component, event, helper) {
        var inpt1value = component.get('v.input1');
        var inpt2value = component.get('v.input2');
        component.set('v.outPut',parseInt(inpt1value) - parseInt(inpt2value));
    },
    Multiply : function(component, event, helper) {
        var inpt1value = component.get('v.input1');
        var inpt2value = component.get('v.input2');
        component.set('v.outPut',parseInt(inpt1value) * parseInt(inpt2value));
        
        },
    Divide : function(component, event, helper) {
        var inpt1value = component.get('v.input1');
        var inpt2value = component.get('v.input2');
        component.set('v.outPut',parseInt(inpt1value) / parseInt(inpt2value));
        
    },
})