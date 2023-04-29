public with sharing class UserSurveyController {
    //constructor
    public UserSurveyController(){
    }
    
    //method to match surveys to users based on their criteria
    public List<Survey__c> matchSurveysToUsers(String specialty, String preferences, String location){
        List<Survey__c> surveys = new List<Survey__c>();
        //query surveys that match the user's specialty, preferences, and location
        surveys = [SELECT Id, Name, Status__c FROM Survey__c WHERE Status__c = 'Active' AND Specialty__c = :specialty AND Preferences__c = :preferences AND Location__c = :location];
        //return the list of surveys
        return surveys;
    }
    
    //method to display surveys to logged-in users only
    public List<Survey__c> displaySurveysToLoggedInUsers(){
        List<Survey__c> surveys = new List<Survey__c>();
        //query surveys that have not yet been completed or cancelled
        surveys = [SELECT Id, Name, Status__c FROM Survey__c WHERE Status__c = 'Active' AND Completed__c = false AND Cancelled__c = false];
        //check if the user is logged in
        if(UserInfo.isCurrentUserLicensed()){
            //return the list of surveys
            return surveys;
        }
        //if the user is not logged in, return an empty list
        return new List<Survey__c>();
    }
    
    //method to provide a "Skip" option for users who do not wish to take a survey
    public void skipSurvey(String surveyId){
        //query the survey
        Survey__c survey = [SELECT Id, Name, Status__c FROM Survey__c WHERE Id = :surveyId];
        //update the survey's status to "Skipped"
        survey.Status__c = 'Skipped';
        //update the survey
        update survey;
    }
    
    //method to allow the admin to download survey reports in a downloadable format
    public void downloadSurveyReports(){
        //query surveys
        List<Survey__c> surveys = [SELECT Id, Name, Status__c FROM Survey__c];
        //create a CSV or Excel file
        String fileName = 'SurveyReports.csv';
        //create a new blob
        Blob csvBlob = Blob.valueof('Name,Status' + '\n');
        //loop through each survey
        for(Survey__c survey : surveys){
            //append each survey's details to the blob
            csvBlob.append(survey.Name + ',' + survey.Status__c + '\n');
        }
        //create a new attachment
        Attachment attachment = new Attachment();
        //set the attachment's properties
        attachment.Body = csvBlob;
        attachment.Name = fileName;
        attachment.ContentType = 'application/csv';
        //insert the attachment
        insert attachment;
    }
}