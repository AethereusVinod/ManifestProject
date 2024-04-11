public class MyFirstBatchClassSchedule implements Schedulable {
    public void execute(SchedulableContext ctx){
        MyFirstBatchClass fbc = new MyFirstBatchClass();
        database.executeBatch(fbc,30);
    }
}