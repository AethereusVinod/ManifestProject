({
    doInit: function(component, event, helper) {        
        helper.getPicklistValues(component, event);
    },
    
    newUser: function(component, event, helper) { 
        component.set("v.forwardToCreateUser",true);
        component.set("v.existingUserInfo",false);
    },
    
    existingUser: function(component, event, helper) {  
        component.set("v.forwardToCreateUser",false);
        component.set("v.existingUserInfo",true);     
    },
    
    checkEmail: function(component, event, helper) {   
        var emailstring = component.get("v.emailString");
        var action = component.get('c.emailFetch');
        action.setParams({
            "email" : emailstring
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('Email____State---------'+state);
            if (state === "SUCCESS") {
                component.set("v.successMsg",'We found you :)');
                console.log('Sucess msg');
                $A.util.removeClass(component.find('successDiv'), 'slds-hide');
                window.setTimeout($A.getCallback(function() {
                    $A.util.addClass(component.find('successDiv'), 'slds-hide');
                }), 2000);
                var name = response.getReturnValue();
                component.set("v.returnConObject",response.getReturnValue());
                component.set("v.afterSubmit",true);
                component.set("v.userTypeCheck",false);
            }
            else if (state === "ERROR")
            {
                component.set("v.errorMsg",'We didnot find you , Please enter correct mail id or Create a new User');
                $A.util.removeClass(component.find('erroDiv'), 'slds-hide');
                window.setTimeout($A.getCallback(function() {
                    $A.util.addClass(component.find('erroDiv'), 'slds-hide');
                }), 2000);  
            }
        });
        $A.enqueueAction(action);
    },
    
    suggestion: function(component, event, helper) { 
        console.log('Suggestion button called');
        component.set("v.suggestions",true);
        var emlstrng = component.get("v.emailString");
        var action = component.get('c.getSuggestionsInfo');
        action.setParams({
            "emailAddress" : emlstrng
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var name = response.getReturnValue();
                component.set("v.wrapperList",name);
                component.set("v.successMsg",'Here are suggestions for your daily calorie maintaince below');
                $A.util.removeClass(component.find('successDiv'), 'slds-hide');
                window.setTimeout($A.getCallback(function() {
                    $A.util.addClass(component.find('successDiv'), 'slds-hide');
                }), 2000);
            }
            else if (state === "ERROR")
            {
                Console.log('Error in wrapper');
            }
        });
        $A.enqueueAction(action);
    },
    
    doSave : function(component, event, helper) {
        console.log('Enter to DoSave----');
        var newcon = component.get('v.ContactObjct');
        var action = component.get('c.createContact');
        action.setParams({
            "ContObj" : newcon
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var name = response.getReturnValue();
                component.set("v.afterSubmit",true);
                component.set("v.returnConObject",name);
                component.set("v.existingUserInfo",false);
                component.set("v.forwardToCreateUser",false);
                component.set("v.userTypeCheck",false);
                component.set("v.successMsg",'Contact has been created');
                $A.util.removeClass(component.find('successDiv'), 'slds-hide');
                window.setTimeout($A.getCallback(function() {
                    $A.util.addClass(component.find('successDiv'), 'slds-hide');
                }), 2000);   
            }
            else if (state === "ERROR")
            {
                component.set("v.errorMsg",'Please enter all values');
                $A.util.removeClass(component.find('erroDiv'), 'slds-hide');
                window.setTimeout($A.getCallback(function() {
                    $A.util.addClass(component.find('erroDiv'), 'slds-hide');
                }), 5000);           
            }
        });
        $A.enqueueAction(action);
    }})