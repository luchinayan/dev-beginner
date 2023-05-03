@IsTest
public with sharing class LeadTestDataFactoryTest {
  @IsTest
  static void createLeadWithTasksTest() {
    Lead lead = LeadTestDataFactory.createLeadWithTasks();
    List<Task> tasks = [SELECT Subject FROM Task WHERE WhoId = :lead.Id];

    System.assertEquals(2, tasks.size(), 'Lead tasks size are not as expected');
    System.assertEquals(
      'Test Task 1',
      tasks[0].Subject,
      'Lead task 1 subject are not matched'
    );
  }
  @IsTest
  static void createLeadTest() {
    Lead lead = LeadTestDataFactory.createLead();

    System.assertEquals('Lead', lead.FirstName, 'Lead name does not matched');
  }
  @IsTest
  static void createTaskTest() {
    String taskBody = 'Task Test Body';
    Lead lead = LeadTestDataFactory.createLead();
    Task task = LeadTestDataFactory.createTask(lead, taskBody);

    System.assertEquals('Lead', lead.FirstName, 'Lead name does not matched');
    System.assertEquals(
      taskBody,
      task.Subject,
      'Lead subject does not matched'
    );
  }
}
