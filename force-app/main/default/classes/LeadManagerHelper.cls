public with sharing class LeadManagerHelper {
  public static Lead getLeadByEmail(String email) {
    Lead lead = [
      SELECT
        Id,
        Name,
        Status,
        OwnerId,
        Email,
        (SELECT Id, Subject FROM Tasks ORDER BY CreatedDate DESC)
      FROM Lead
      WHERE Email = :email
    ];
    if (lead == null) {
      return sendErrorResponse('No lead found for email: ' + email);
    }
    return lead;
  }

  public static Lead getLeadById(String id) {
    Lead lead = [
      SELECT
        Id,
        Name,
        Status,
        OwnerId,
        Email,
        (SELECT Id, Subject FROM Tasks ORDER BY CreatedDate DESC)
      FROM Lead
      WHERE Id = :id
    ];
    if (lead == null) {
      return sendErrorResponse('No lead found for id: ' + id);
    }
    return lead;
  }

  public static Lead createTaskForLeadByEmail(String taskBody, String email) {
    Lead lead = getLeadByEmail(email);
    Task newTask = new Task(Subject = taskBody, WhoId = lead.Id);
    insert newTask;
    return lead;
  }

  public static Lead createTaskForLeadById(String taskBody, String id) {
    Lead lead = getLeadById(id);
    Task newTask = new Task(Subject = taskBody, WhoId = lead.Id);
    insert newTask;
    return lead;
  }

  public static Lead sendErrorResponse(String message) {
    RestContext.response.statusCode = 400;
    RestContext.response.responseBody = Blob.valueOf(message);
    return null;
  }
}
