// Apex Controller
public with sharing class StudentController {

    public Student__c student {get; set;}

    public StudentController(ApexPages.StandardController stdController) {
        this.student = (Student__c)stdController.getRecord();
    }

    public PageReference saveStudent() {
        try {
            // Validate student name
            if (student.Name == null || student.Name.trim().length() == 0) {
                ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Student Name is required');
                ApexPages.addMessage(errMsg);
                return null;
            }

            // Validate student ID
            if (student.Student_ID__c == null) {
                ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Student ID is required');
                ApexPages.addMessage(errMsg);
                return null;
            }

            // Validate student grade
            if (student.Grade__c == null) {
                ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Grade is required');
                ApexPages.addMessage(errMsg);
                return null;
            }

            // Save the student record
            update student;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Student record saved successfully'));
            return null;
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error saving student record'));
            return null;
        }
    }
}

// LWC
import { LightningElement, api } from 'lwc';

export default class StudentEditForm extends LightningElement {
    @api student;

    handleSave() {
        // Create the recordUpdated event
        const saveEvent = new CustomEvent('save', {detail: this.student});
        // Fire the event
        this.dispatchEvent(saveEvent);
    }
}