({
    onChange1: function (component, evt, helper) {
        var selectedLimit = component.find('searchField').get('v.value');
        component.set('v.searchKeyword', selectedLimit);
        helper.SearchHelper(component, event);
    }, 
    doInit: function (component, evt, helper) {
        component.set('v.columns', [
            {label: 'Account Name', fieldName: 'Name', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'Phone'},
            {label: 'Billing Country', fieldName:'BillingCountry', type: 'string'}
        ]);
         component.set('v.cColumns', [
                {label: 'Contact Name', fieldName: 'Name', type: 'text'},
                {label: 'Phone', fieldName: 'Phone', type: 'phone'},
                {label: 'Email', fieldName: 'Email', type: 'email'},
                {label: 'Account Name', fieldName: 'Account.Name', type: 'text'}
            ]);
    },
    
    updateSelectedText : function (component, evt, helper) {
        var selectedRows = evt.getParam('selectedRows');
        component.set('v.SelectedAccounts',selectedRows);
        console.log('selectedAccounts'+JSON.stringify(selectedRows));
    }, 
    
    handleClick : function (component, evt, helper) {
        var action = component.get('c.ContList');
        console.log('Accounts in Handle Click**'+JSON.stringify(component.get("v.SelectedAccounts")));
        action.setParams({ 
            AccountLst : component.get("v.SelectedAccounts"),
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set('v.ContInfo',true);
                var allValues = response.getReturnValue();
                console.log("allValues--->>> " + JSON.stringify(allValues));
                component.set('v.ContactList', allValues);
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