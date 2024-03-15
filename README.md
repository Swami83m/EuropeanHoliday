# EuropeanHoliday
 A simple application to integrate the public API to parse the data and update the UI.

 **Introduction**
 An iOS native application to demonstrate the integration of RESTFUL services and update the  User Interface with received data. This application 
 uses the PUBLIC API to get the get the data from server using native network methods and display it into UITableView. The application follows 
 MVVM architecture, SOLID principles for concern separation, cocoa pods for API network calls and Code coverage.  Moreover Unit testing is 
 performed at Mocking the API calls and parsing .json file inside the project bundle. 

 **Application Work Flow:**
 The aim of this application to show the list of holidays available for particular country code. Once the user has selected any of the country 
 from the list then it will navigate the user to another screen with list of holidays available for particular country. There are 2 public api’s 
 implemented in this application which one for getting all the countries with “Name” and “Country Code”. The Country code is used here as input 
 parameter for another API call to get the list of holiday information. 

**API Details: **
1) https://date.nager.at/api/v3/AvailableCountries
2) https://date.nager.at/api/v3/publicholidays/2024/?
	?- is the query parameter which will take the country code. 

**Architecture: MVVM**
Dependency: Cocoa-pods
List of Pods: Alamofire (for network calls) & SWIFTLint (for code coverage)

**Development Environment:**
IDE – Xcode 15.3
Unit Test – XCTest Framework
Swift Version – 5.0
Deployment Target – iOS 17.0

**Future Enhancement:**
In future, the year can be passed as dynamic value instead of default value 2024 from the API (https://date.nager.at/api/v3/publicholidays/2024/). We can design the “Date Picker” component in the UI where can select the specific year to view the list of holidays for that particular year for the selected country.

**Project Setup**
Install the cocoa pods to support to make use of integrated framework
Navigate to the project root folder and run “Pod install”
We can find the .xcworkspace file after the successful “Pod install” operation
Click the “Run” button to execute the application



