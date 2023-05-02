@RestResource(urlMapping='/Leads/*')
global with sharing class LeadManager {
  @HttpGet
  global static Lead getLead() {
    String email = null;
    String id = null;
    RestRequest request = RestContext.request;
    if (request.requestURI.contains('/Email/')) {
      email = request.requestURI.substring(
        request.requestURI.lastIndexOf('/') + 1
      );
    } else {
      id = request.requestURI.substring(
        request.requestURI.lastIndexOf('/') + 1
      );
    }

    if (email != null) {
      return leadManagerHelper.getLeadByEmail(email);
    } else if (id != null) {
      return leadManagerHelper.getLeadById(id);
    }

    return leadManagerHelper.sendErrorResponse(
      'Invalid request: provide either an email or an id'
    );
  }

  @HttpPost
  global static Lead createTask(String taskBody) {
    RestRequest request = RestContext.request;
    String email;
    String id;
    if (request.requestURI.contains('/Email/')) {
      email = request.requestURI.substring(
        request.requestURI.lastIndexOf('/') + 1
      );
    } else {
      id = request.requestURI.substring(
        request.requestURI.lastIndexOf('/') + 1
      );
    }

    if (email != null) {
      return leadManagerHelper.createTaskForLeadByEmail(taskBody, email);
    } else if (id != null) {
      return leadManagerHelper.createTaskForLeadById(taskBody, id);
    }

    return leadManagerHelper.sendErrorResponse(
      'Invalid request: provide either an email or an id'
    );
  }
}
