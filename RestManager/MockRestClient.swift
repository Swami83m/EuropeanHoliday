//
//  MockRestClient.swift
//  EuropeanHoliday
//
// 
//

import Foundation

class MockRestClient: RestServiceManager
{

     func getRequestForJSON<T>(apiKey: String,serviceScheme: HolidayServiceScheme, holidayResponseModel: T.Type, mockJsonModel: Data? = nil, completion: @escaping (Bool, T?, String) -> ()) where T : Decodable  {
        // check for a network connection
        if (Connectivity.isConnectedToInternet == false){
            DispatchQueue.main.async {
                completion( false, nil, StringFactory.Messages.no_internet)
            }
            return
        }
        
        if mockJsonModel != nil {
            let decoder = JSONDecoder()
            var jsonObject: T?
        
            do {
                // decode json
                jsonObject  = try decoder.decode(T.self, from: mockJsonModel!)
                
            } catch {
                    DispatchQueue.main.async {
                        completion(true, jsonObject, StringFactory.Messages.unexpected_error)
                    }
                }
                
            }
        }
}
