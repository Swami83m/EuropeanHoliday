//
//  StringFactory.swift
//  EuropeanHoliday
//
//
//

import Foundation
// swiftlint:disable identifier_name
class StringFactory {
    class Messages {
        /** *"Sorry for the inconvenience \nan unexpected error has occurred!\nWould you like to try again?"* */
        class var service_down_retry: String { return "Service Down Retry" }
        /** *"Sorry for the inconvenience \nan unexpected error has occurred!\n Kindly try again later"* */
        class var unexpected_error: String { return "Unexpected Error" }
        /** *"We are not connected to internet!"* */
        class var no_internet: String { return "No Internet"}
        /** *"No Data to Show "* */
        class var noDataError: String { return "No Data to Show"}
        /** *"Unexpected Data "* */
        class var unExpectedData: String { return "Unexpected Data"}
    }
    
    class Actions {
        /** *"Retry"* */
        class var retry: String { return "retry" }
        /** *"Cancel"* */
        class var cancel: String { return "cancel" }
        /** *"Ok"* */
        class var ok: String { return "ok" }
        // swiftlint:enable identifier_name
    }
    class Titles {
        /** *"European Holiday"* */
        class var europeanHoliday: String { return "European Holidays" }
        /** *"UnitedKingdom Holiday"* */
        class var unitedKingdom: String { return "United Kingdom" }
        /** *"Ireland Holiday"* */
        class var ireland: String { return "Ireland" }
        /** *"Germany Holiday"* */
        class var germany: String { return "Germany" }
        /** *"Spain Holiday"* */
        class var spain: String { return "Spain" }
        /** *"France Holiday"* */
        class var france: String { return "France" }
    }
    
    class CountryCode {
        /** *"GB for UnitedKingdom "* */
        class var unitedKingdom: String { return "GB" }
        /** *" IE for Ireland "* */
        class var ireland: String { return "IE" }
        /** *"DE for Germany Holiday"* */
        class var germany: String { return "DE" }
        /** *"ES for Spain "* */
        class var spain: String { return "ES" }
        /** *"France Holiday"* */
        class var france: String { return "FR" }
    }
    
    class ApiURL {
        /** *URL end point to fetch the holiday for particular region "* */
        class var publicHolidayURL: String { return "publicholidays/2024/" }
        
        /** *URL end point to fetch the available country codes & its names  "* */
        class var availableCountry: String { return "AvailableCountries"}
    }
}

