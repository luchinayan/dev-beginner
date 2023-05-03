trigger UpdateOutdatedContactsOnAccount on Contact(after insert) {
  List<Contact> outdatedContacts = OutdatedContactsOnAccountHandler.outdatedContacts(
    Trigger.new
  );
  if (!outdatedContacts.isEmpty()) {
    update outdatedContacts;
  }
}
