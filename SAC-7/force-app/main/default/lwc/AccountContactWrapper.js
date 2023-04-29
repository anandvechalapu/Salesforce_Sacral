// Lightning Web Component
import { LightningElement, api, track } from 'lwc';
import { getAccountsAndContacts } from '@salesforce/apex/AccountContactWrapper.getAccountsAndContacts';

export default class AccountContactWrapper extends LightningElement {
    @api accounts;
    @api contacts;
    @track selectedAccount;
    @track selectedContact;
    
    connectedCallback() {
        getAccountsAndContacts()
            .then(result => {
                this.accounts = result.accounts;
                this.contacts = result.contacts;
            })
            .catch(error => {
                // handle error
            });
    }

    handleAccountSelection(event) {
        this.selectedAccount = event.detail.value;
    }

    handleContactSelection(event) {
        this.selectedContact = event.detail.value;
    }

}