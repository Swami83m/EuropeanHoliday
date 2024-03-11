//
//  RestServiceManager.swift
//  EuropeanHoliday
//
//  
//

import Foundation

// Define a protocol for the dependency
protocol RestServiceManager {
     func getRequestForJSON < T :Decodable  > ( apiKey : String,
        serviceScheme : HolidayServiceScheme,
        holidayResponseModel : T.Type, mockJsonModel: Data?,
        completion:  @escaping (_ success:Bool, _ dataResponse: T?, _ errorMessage: String) -> () )
}
