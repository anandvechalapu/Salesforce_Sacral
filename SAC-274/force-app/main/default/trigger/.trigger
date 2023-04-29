trigger StudentTrigger on Student__c (before insert, before update) {
    //loop through all records being inserted/updated
    for(Student__c s : Trigger.new){
        //if the Mobile field is empty or null
        if(s.Mobile == null || s.Mobile == '') {
            //update the Mobile field with the phone number of the student
            s.Mobile = s.Phone__c;
        }
    }
}