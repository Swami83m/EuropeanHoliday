//
//  RestServiceManager.swift
//  EuropeanHoliday
//
//  
//

import Foundation

// Define a protocol for the dependency
protocol RestServiceManager {
    func fetchDataFromRestAPI<T>(apiKey: String,holidayResponseModel: T.Type, completion: @escaping (Bool, T?, String) -> ()) where T : Decodable
}
