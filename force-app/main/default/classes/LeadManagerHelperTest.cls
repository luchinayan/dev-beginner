@IsTest
public with sharing class LeadManagerHelperTest {
  @IsTest
  static void getLeadByIdTest() {
    Lead leadWithTasks = new Lead(
      FirstName = 'Lead',
      LastName = 'With Tasks',
      Email = 'leadwithtasks@example.com',
      Company = 'FBI'
    );
    insert leadWithTasks;
    Lead leadWithOutTasks = new Lead(
      FirstName = 'Lead',
      LastName = 'With Out Tasks',
      Email = 'leadwithouttasks@example.com',
      Company = 'FBI'
    );
    insert leadWithOutTasks;

    Task task1 = new Task(Subject = 'Test Task 1', WhoId = leadWithTasks.Id);
    insert task1;

    Task task2 = new Task(Subject = 'Test Task 2', WhoId = leadWithTasks.Id);
    insert task2;

    Lead resultLeadWithTasks = LeadManagerHelper.getLeadById(leadWithTasks.Id);
    Lead resultLeadWithOutTasks = LeadManagerHelper.getLeadById(
      leadWithOutTasks.Id
    );
    System.assertEquals(
      leadWithTasks.Id,
      resultLeadWithTasks.Id,
      'Lead with Tasks Ids doesn\'t matched'
    );
    System.assertEquals(
      2,
      resultLeadWithTasks.Tasks.size(),
      'Lead tasks size doesn\'t matched'
    );
    System.assertEquals(
      0,
      resultLeadWithOutTasks.Tasks.size(),
      'Lead size is not 0'
    );
    System.assertEquals(
      leadWithOutTasks.Id,
      resultLeadWithOutTasks.Id,
      'Lead without Tasks Ids doesn\'t matched'
    );
  }
  @IsTest
  static void getLeadByEmailTest() {
    Lead leadWithTasks = new Lead(
      FirstName = 'Lead',
      LastName = 'With Tasks',
      Email = 'leadwithtasks@example.com',
      Company = 'FBI'
    );
    insert leadWithTasks;
    Lead leadWithOutTasks = new Lead(
      FirstName = 'Lead',
      LastName = 'With Out Tasks',
      Email = 'leadwithouttasks@example.com',
      Company = 'FBI'
    );
    insert leadWithOutTasks;

    Task task1 = new Task(Subject = 'Test Task 1', WhoId = leadWithTasks.Id);
    insert task1;

    Task task2 = new Task(Subject = 'Test Task 2', WhoId = leadWithTasks.Id);
    insert task2;

    Lead resultLeadWithTasks = LeadManagerHelper.getLeadByEmail(
      leadWithTasks.Email
    );
    Lead resultLeadWithOutTasks = LeadManagerHelper.getLeadByEmail(
      leadWithOutTasks.Email
    );
    System.assertEquals(
      leadWithTasks.Email,
      resultLeadWithTasks.Email,
      'Lead with Tasks Emails doesn\'t matched'
    );
    System.assertEquals(
      2,
      resultLeadWithTasks.Tasks.size(),
      'Lead tasks size doesn\'t matched'
    );
    System.assertEquals(
      0,
      resultLeadWithOutTasks.Tasks.size(),
      'Lead size is not 0'
    );
    System.assertEquals(
      leadWithOutTasks.Email,
      resultLeadWithOutTasks.Email,
      'Lead without Tasks Emails doesn\'t matched'
    );
  }

  @IsTest
  static void createTaskForLeadByEmailTest() {
    Lead lead = new Lead(
      FirstName = 'Lead',
      LastName = 'With Tasks',
      Email = 'leadwithtasks@example.com',
      Company = 'FBI'
    );
    insert lead;

    String taskBody = 'Test Task';

    LeadManagerHelper.createTaskForLeadByEmail(taskBody, lead.Email);
    Lead updatedLead = [
      SELECT Id, Name, Email, (SELECT Id, Subject FROM Tasks)
      FROM Lead
      WHERE Id = :lead.Id
    ];

    System.assertEquals(
      updatedLead.Email,
      updatedLead.Email,
      'Lead with Tasks Emails doesn\'t matched'
    );
    System.assertEquals(
      1,
      updatedLead.Tasks.size(),
      'Lead tasks size doesn\'t matched'
    );
    System.assertEquals(
      'Test Task',
      updatedLead.Tasks[0].Subject,
      'Lead tasks subject doesn\'t matched'
    );
  }

  @IsTest
  static void createTaskForLeadByIdTest() {
    Lead lead = new Lead(
      FirstName = 'Lead',
      LastName = 'With Tasks',
      Email = 'leadwithtasks@example.com',
      Company = 'FBI'
    );
    insert lead;

    String taskBody = 'Test Task';

    LeadManagerHelper.createTaskForLeadById(taskBody, lead.Id);
    Lead updatedLead = [
      SELECT Id, Name, Email, (SELECT Id, Subject FROM Tasks)
      FROM Lead
      WHERE Id = :lead.Id
    ];

    System.assertEquals(
      updatedLead.Id,
      updatedLead.Id,
      'Lead with Tasks Ids doesn\'t matched'
    );
    System.assertEquals(
      1,
      updatedLead.Tasks.size(),
      'Lead tasks size doesn\'t matched'
    );
    System.assertEquals(
      'Test Task',
      updatedLead.Tasks[0].Subject,
      'Lead tasks subject doesn\'t matched'
    );
  }

  @IsTest
  static void sendErrorResponseTest() {
    Test.startTest();

    String errorMessage = 'Invalid email';
    RestContext.response = new RestResponse();
    Lead result = LeadManagerHelper.sendErrorResponse(errorMessage);
    System.assertEquals(null, result, 'The result should be null');
    System.assertEquals(
      400,
      RestContext.response.statusCode,
      'The status code should be 400'
    );
    System.assertEquals(
      errorMessage,
      RestContext.response.responseBody.toString(),
      'The response body should match the error message'
    );

    errorMessage = 'Email not found';
    result = LeadManagerHelper.sendErrorResponse(errorMessage);
    System.assertEquals(null, result, 'The result should be null');
    System.assertEquals(
      400,
      RestContext.response.statusCode,
      'The status code should be 400'
    );
    System.assertEquals(
      errorMessage,
      RestContext.response.responseBody.toString(),
      'The response body should match the error message'
    );

    Test.stopTest();
  }
}
