@isTest
private class AccountManagerTest
{
    @isTest static void testGetAccount ()
    {
        Id recordId = createTestRecord ();
        RestRequest request = new RestRequest ();
        request.requestUri = 'https://vinodsinghbeniwal-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + recordId + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account thisAccount = AccountManager.getAccount();
        System.assert (thisAccount != null);
        System.assertEquals ('Test Record', thisAccount.Name);

    }

    static Id createTestRecord ()
    {
        Account testAccount = new Account (Name = 'Test Record');
        insert testAccount;
        Contact testContact = new Contact (AccountId = testAccount.Id);
        return testAccount.Id;
    }

}