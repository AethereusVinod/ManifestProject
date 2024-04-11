@isTest
public class AnimalLocatorTest {
    @isTest static void callout(){
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        string result = AnimalLocator.getAnimalNameById(1);
    }
}