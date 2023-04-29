public with sharing class DRL_UserSurvey{
    
    // Method to match surveys to the user based on their specialty, preferences, and location (if applicable)
    public static void matchSurveyToUser(List<User> users){
        List<Survey> surveys = [SELECT Id, Status, Completion_Status__c FROM Survey WHERE Status = 'Active' AND Completion_Status__c != 'Cancelled' AND Completion_Status__c != 'Completed'];
        // Iterate through users and match surveys to them
        for(User u : users){
            // Retrieve user's specialty, preferences, and location
            String specialty = u.Specialty__c;
            String preferences = u.Preferences__c;
            String location = u.Location__c;
            // Loop through surveys and match to users based on their criteria
            for(Survey s : surveys){
                if(s.Specialty__c == specialty && s.Preferences__c == preferences && s.Location__c == location){
                    // Create a record in the Survey_User_Mapping__c object to map the user to the survey
                    Survey_User_Mapping__c surMap = new Survey_User_Mapping__c();
                    surMap.Survey__c = s.Id;
                    surMap.User__c = u.Id;
                    insert surMap;
                }
            }
        }
    }
    
    // Method to display surveys to logged-in users
    public static void displaySurvey(Id userId){
        List<Survey> surveys = [SELECT Id, Status, Completion_Status__c FROM Survey WHERE Status = 'Active' AND Completion_Status__c != 'Cancelled' AND Completion_Status__c != 'Completed'];
        // Retrieve the surveys that are mapped to the user
        List<Survey_User_Mapping__c> surMaps = [SELECT Survey__c FROM Survey_User_Mapping__c WHERE User__c = :userId];
        // Create a list of surveys to display
        List<Survey> displaySurveys = new List<Survey>();
        // Loop through the user mapping records and add the surveys to the display list
        for(Survey_User_Mapping__c surMap : surMaps){
            for(Survey s : surveys){
                if(s.Id == surMap.Survey__c){
                    displaySurveys.add(s);
                }
            }
        }
        // Display the surveys to the user
        for(Survey s : displaySurveys){
            // Code to display surveys
        }
    }
    
    // Method to provide a "Skip" option for users who do not wish to take a survey
    public static void skipSurvey(Id surveyId, Id userId){
        // Retrieve the survey user mapping record
        Survey_User_Mapping__c surMap = [SELECT Id FROM Survey_User_Mapping__c WHERE Survey__c = :surveyId AND User__c = :userId];
        // Delete the survey user mapping record
        delete surMap;
    }
    
    // Method to allow the admin to download survey reports in a downloadable format such as a CSV or Excel file
    public static void downloadSurveyReports(){
        List<Survey> surveys = [SELECT Id, Status, Completion_Status__c FROM Survey WHERE Status = 'Active' AND Completion_Status__c != 'Cancelled' AND Completion_Status__c != 'Completed'];
        // Create a list of surveys to download
        List<Survey> downloadSurveys = new List<Survey>();
        // Loop through the user mapping records and add the surveys to the download list
        for(Survey_User_Mapping__c surMap : surMaps){
            for(Survey s : surveys){
                if(s.Id == surMap.Survey__c){
                    downloadSurveys.add(s);
                }
            }
        }
        // Generate the CSV file
        String csvString = '';
        for(Survey s : downloadSurveys){
            csvString += s.Id + ',' + s.Status + ',' + s.Completion_Status__c + '\n';
        }
        // Download the CSV file
        PageReference pageRef = new PageReference('/apex/DownloadSurveyReports');
        pageRef.getParameters().put('csvString', csvString