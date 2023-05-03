public with sharing class OutdatedContactsOnAccountHandler {
  public static List<Contact> outdatedContacts(List<Contact> newContacts) {
    Set<Id> accountIds = new Set<Id>();
    List<Contact> outdatedContacts = new List<Contact>();
    for (Contact contact : newContacts) {
      accountIds.add(contact.AccountId);
    }

    List<Account> accounts = [
      SELECT Id, (SELECT Id, CreatedDate FROM Contacts ORDER BY CreatedDate ASC)
      FROM Account
      WHERE Id IN :accountIds
    ];

    for (Account account : accounts) {
      List<Contact> contacts = account.Contacts;
      Integer contactsCount = contacts.size();

      if (contactsCount >= 4) {
        for (Integer i = 0; i < contactsCount - 4; i++) {
          contacts[i].Is_Outdated__c = true;
          outdatedContacts.add(contacts[i]);
        }
      }
    }
    return outdatedContacts;
  }
}
