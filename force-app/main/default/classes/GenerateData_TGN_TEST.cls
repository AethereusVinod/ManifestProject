/* Generated by TestGen on Tue Oct 3 2023 at 6:16 AM (GMT) */
@isTest
private class GenerateData_TGN_TEST{
    @isTest(SeeAllData=true)
    private static void init_TGN_TEST(){
        Test.startTest();
        GenerateData.init();
        Test.stopTest();
    }
    @isTest
    private static void getLengthForBoatType_TGN_TEST(){
        Test.startTest();
        GenerateData.getLengthForBoatType('jetski');
        GenerateData.getLengthForBoatType('skiboat');
        GenerateData.getLengthForBoatType('houseboat');
        GenerateData.getLengthForBoatType('fishingboat');
        GenerateData.getLengthForBoatType('sailboat');
        GenerateData.getLengthForBoatType('pleasureboat');
        GenerateData.getLengthForBoatType('yacht');
        GenerateData.getLengthForBoatType('highperformance');
        GenerateData.getLengthForBoatType('_jetski');
        GenerateData.getLengthForBoatType('_skiboat');
        GenerateData.getLengthForBoatType('_houseboat');
        GenerateData.getLengthForBoatType('_fishingboat');
        GenerateData.getLengthForBoatType('_sailboat');
        GenerateData.getLengthForBoatType('_pleasureboat');
        GenerateData.getLengthForBoatType('_yacht');
        GenerateData.getLengthForBoatType('_highperformance');
        Test.stopTest();
    }
    @isTest
    private static void getPriceForBoatType_TGN_TEST(){
        Test.startTest();
        GenerateData.getPriceForBoatType('jetski');
        GenerateData.getPriceForBoatType('skiboat');
        GenerateData.getPriceForBoatType('houseboat');
        GenerateData.getPriceForBoatType('fishingboat');
        GenerateData.getPriceForBoatType('sailboat');
        GenerateData.getPriceForBoatType('pleasureboat');
        GenerateData.getPriceForBoatType('yacht');
        GenerateData.getPriceForBoatType('highperformance');
        GenerateData.getPriceForBoatType('_jetski');
        GenerateData.getPriceForBoatType('_skiboat');
        GenerateData.getPriceForBoatType('_houseboat');
        GenerateData.getPriceForBoatType('_fishingboat');
        GenerateData.getPriceForBoatType('_sailboat');
        GenerateData.getPriceForBoatType('_pleasureboat');
        GenerateData.getPriceForBoatType('_yacht');
        GenerateData.getPriceForBoatType('_highperformance');
        Test.stopTest();
    }
    @isTest
    private static void GenerateData_TGN_TEST(){
        GenerateData obj = new GenerateData();
    }
}