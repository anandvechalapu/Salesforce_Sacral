trigger AccountContactWrapperTrigger on Account (after insert, after update, after delete, after undelete) {
    // Trigger the AccountContactWrapper class when an Account is created, updated, deleted, or undeleted.
    if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete)) {
        AccountContactWrapper.refreshAccountsAndContacts(Trigger.old, Trigger.new);
    }
}