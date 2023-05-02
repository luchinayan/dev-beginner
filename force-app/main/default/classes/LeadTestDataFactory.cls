@isTest
public class LeadTestDataFactory {
  public static Lead createLeadWithTasks() {
    Lead lead = new Lead(
      FirstName = 'Lead',
      LastName = 'With Tasks',
      Email = 'leadwithtasks@example.com',
      Company = 'FBI'
    );
    insert lead;

    Task task1 = createTask(lead, 'Test Task 1');
    Task task2 = createTask(lead, 'Test Task 2');

    return lead;
  }

  public static Lead createLeadWithoutTasks() {
    Lead lead = new Lead(
      FirstName = 'Lead',
      LastName = 'Without Tasks',
      Email = 'leadwithouttasks@example.com',
      Company = 'FBI'
    );
    insert lead;

    return lead;
  }

  public static Task createTask(Lead lead, String taskBody) {
    Task newTask = new Task(Subject = taskBody, WhoId = lead.Id);
    insert newTask;

    return newTask;
  }
}
