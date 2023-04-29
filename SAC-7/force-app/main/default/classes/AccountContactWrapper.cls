public with sharing class AccountContactWrapper {

    public List<Account> accounts {get; set;}
    public List<Contact> contacts {get; set;}

    public AccountContactWrapper(){
        accounts = new List<Account>();
        contacts = new List<Contact>();
    }

    public void init(){
        accounts = [SELECT Id, Name, Phone, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry FROM Account WHERE IsVisible = true];
        contacts = [SELECT Id, Name, Email, Phone FROM Contact WHERE IsVisible = true];
    }
    
    public Account getAccountById(Id accountId){
        Account acc = [SELECT Id, Name, Phone, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry FROM Account WHERE Id = :accountId];
        return acc;
    }

    public Contact getContactById(Id contactId){
        Contact con = [SELECT Id, Name, Email, Phone FROM Contact WHERE Id = :contactId];
        return con;
    }
}