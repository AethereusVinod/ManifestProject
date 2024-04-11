public class RandomContactFactory {
    public static list<Contact> generateRandomContacts(integer NoCnts, string LstName){
        List<Contact> cntlist = new list<Contact>();
        for(Integer i=0; i<NoCnts; i++){
            LstName = 'Test' +i ;
            Contact c = new Contact(FirstName=LstName, LastName= LstName);
            cntlist.add(c);
        }
        return cntlist;
    }
}