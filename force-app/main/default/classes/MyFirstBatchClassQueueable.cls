public class MyFirstBatchClassQueueable implements Queueable  {
    public void execute(QueueableContext  qtx){
        system.enqueueJob(new MyFirstBatchClassSchedule());
    }
}