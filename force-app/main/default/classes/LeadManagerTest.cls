@IsTest
private class LeadManagerTest {
  @isTest
  static void getLeadByIdTest() {
    Lead lead = LeadTestDataFactory.createLead();
    RestRequest request = new RestRequest();
    request.requestURI =
      'https://empathetic-panda-wuy3pp-dev-ed.trailblaze.lightning.force.com/services/apexrest/Leads/' +
      lead.Id;
    request.httpMethod = 'GET';
    RestContext.request = request;
    Lead resultLead = LeadManager.getLead();
    System.assertEquals(lead.Id, resultLead.Id, 'Leads Ids are not equals');
    System.assertEquals(
      lead.Email,
      resultLead.Email,
      'Leads Email are not equals'
    );
  }
  @isTest
  static void getLeadByEmailTest() {
    Lead lead = LeadTestDataFactory.createLead();
    RestRequest request = new RestRequest();
    request.requestURI =
      'https://empathetic-panda-wuy3pp-dev-ed.trailblaze.lightning.force.com/services/apexrest/Leads/Email/' +
      lead.Email;
    request.httpMethod = 'GET';
    RestContext.request = request;
    Lead resultLead = LeadManager.getLead();
    System.assertEquals(lead.Id, resultLead.Id, 'Leads Ids are not equals');
    System.assertEquals(
      lead.Email,
      resultLead.Email,
      'Leads Email are not equals'
    );
  }
  @isTest
  static void createTaskByEmailTest() {
    Lead lead = LeadTestDataFactory.createLead();

    RestRequest request = new RestRequest();
    request.requestUri =
      'https://empathetic-panda-wuy3pp-dev-ed.trailblaze.lightning.force.com/services/apexrest/Leads/Email/' +
      lead.Email;
    request.httpMethod = 'POST';
    request.requestBody = Blob.valueOf('{"taskBody": "Test Task"}');

    RestContext.request = request;

    Lead result = LeadManager.createTask('Test Task');
    Lead updatedLead = [
      SELECT Id, Name, Email, (SELECT Id, Subject FROM Tasks)
      FROM Lead
      WHERE Id = :lead.Id
    ];
    System.assertEquals(
      'Test Task',
      updatedLead.Tasks[0].Subject,
      'task subkect are not equals'
    );
    System.assertEquals(lead.Id, result.Id, 'id are not equals');
  }

  @isTest
  static void createTaskByIdTest() {
    Lead lead = LeadTestDataFactory.createLead();

    RestRequest request = new RestRequest();
    request.requestUri =
      'https://empathetic-panda-wuy3pp-dev-ed.trailblaze.lightning.force.com/services/apexrest/Leads/' +
      lead.Id;
    request.httpMethod = 'POST';
    request.requestBody = Blob.valueOf('{"taskBody": "Test Task"}');

    RestContext.request = request;

    Lead result = LeadManager.createTask('Test Task');
    Lead updatedLead = [
      SELECT Id, Name, Email, (SELECT Id, Subject FROM Tasks)
      FROM Lead
      WHERE Id = :lead.Id
    ];
    System.assertEquals(
      'Test Task',
      updatedLead.Tasks[0].Subject,
      'task subkect are not equals'
    );
    System.assertEquals(lead.Id, result.Id, 'id are not equals');
  }
}
