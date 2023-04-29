public with sharing class StudentManager{

    public static void updateMobileField(List<Student__c> studentList) {
        List<Student__c> updateStudentList = new List<Student__c>();
        for(Student__c student : studentList) {
            if(student.Phone != null && student.Phone.length() <= 15) {
                student.Mobile__c = student.Phone;
                updateStudentList.add(student);
            }
            else {
                student.Mobile__c = null;
                updateStudentList.add(student);
            }
        }
        if(updateStudentList.size() > 0) {
            update updateStudentList;
        }
    }
}