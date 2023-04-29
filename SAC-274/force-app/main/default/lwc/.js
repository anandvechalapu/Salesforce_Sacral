// Generated Code for LWC component for Salesforce Test Scenario 1
import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class StudentTrigger extends LightningElement {

	@track studentRecords;
	@track error;

	connectedCallback() {
		this.initializeTrigger();
	}

	initializeTrigger() {
		// Get all Student__c records
		fetch('/services/data/v50.0/sobjects/Student__c')
			.then(response => response.json())
			.then(data => {
				this.studentRecords = data.records;
			})
			.catch(error => {
				this.error = error;
			});
	}

	handleInsertRecord(e) {
		let studentRecord = e.detail;

		// Check if Mobile field is empty or null
		if(studentRecord.Mobile == '' || studentRecord.Mobile == null) {
			// Update Mobile field with the phone number of the student
			studentRecord.Mobile = studentRecord.Phone;
		}
		// Create Student__c record with updated Mobile field
		fetch('/services/data/v50.0/sobjects/Student__c', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(studentRecord)
		})
		.then(response => {
			if (response.ok) {
				// Show success message
				this.dispatchEvent(
					new ShowToastEvent({
						title: 'Success',
						message: 'Student record created with updated Mobile field.',
						variant: 'success'
					})
				);
				// Refresh records
				this.initializeTrigger();
			} else {
				// Show error message
				this.dispatchEvent(
					new ShowToastEvent({
						title: 'Error creating record',
						message: 'There was an error creating the record.',
						variant: 'error'
					})
				);
			}
		})
		.catch(error => {
			this.error = error;
		});
	}

}