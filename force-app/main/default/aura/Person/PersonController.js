({
     doInit : function(component, event, helper) {
        
      var action = component.get('c.personMethod');
        action.setParams({
            
        });
        
        action.setCallback(this, function(a){
           var valueee = a.getReturnValue();
            console.log('Values',valueee);
            component.set('v.personlist',valueee);
        });
        $A.enqueueAction(action);
    }
})