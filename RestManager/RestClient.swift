//
//  RestClient.swift
//  EuropeanHoliday
//
//
//

import Foundation
import Alamofire

// MARK: - Properties
// set base service properties based on build environment
#if DEBUG
private let httpProtocol                     = "https://"
private let hostName                         = "date.nager.at/api/v3/"

#else

#endif


struct ServiceScheme {
    let baseURL: String
    var header: HTTPHeaders
}


func getRequestProperties(apiUrl: String? = nil)->ServiceScheme{
    return ServiceScheme(baseURL: httpProtocol + hostName,
                         header: ["Content-Type": "application/json"])
}

class RestClient: RestServiceManager {
    
    // The difference here is that the initialized manager is not owned, and is deallocated shortly after it goes out of scope. As a result, any pending tasks are cancelled.
    //https://github.com/Alamofire/Alamofire/issues/157
    static let sessionMananger: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        /* This property determines the maximum number of simultaneous connections made to each host by tasks within sessions based on this configuration.The default value is 6 in macOS, or 4 in iOS.
         Additionally, depending on your connection to the Internet, a session may use a lower limit than the one you specify. */
        configuration.httpMaximumConnectionsPerHost = 10
        
        configuration.timeoutIntervalForRequest = 60
        //configuration.timeoutIntervalForResource = 60  // The default value is 7 days. Keep it as default
        return Alamofire.Session(configuration: configuration)
    }()
    
    
    func fetchDataFromRestAPI<T>(apiKey: String,holidayResponseModel: T.Type, completion: @escaping (Bool, T?, String) -> ()) where T : Decodable  {
        
        var serviceURL = ""
        if !apiKey.isEmpty {
            // create a service call configuration based on run environment
            serviceURL = getRequestProperties().baseURL + apiKey.trim()
        }
        let serviceHeader = getRequestProperties().header
        
        RestClient.sessionMananger.request(serviceURL, method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: serviceHeader)
            .responseData(queue: DispatchQueue.global(qos: .utility)) { response in
                
                if case .success(_) = response.result{
                    guard let jsonData = response.data else{
                        
                        // data is no more null according to latest Alamofire update but need to be here to shut up swift compiler
                        DispatchQueue.main.async {
                            completion(false, nil, StringFactory.Messages.service_down_retry)
                        }
                        return
                    }
                    
                    
                    do {
                        // decode json
                        let jsonObject  = try JSONDecoder().decode(T.self, from: jsonData)
                        DispatchQueue.main.async {
                            completion(true, jsonObject,"" )
                        }
                        
                    } catch {
                        
                        DispatchQueue.main.async {
                            completion(false, nil, StringFactory.Messages.service_down_retry)
                        }
                    }
                    
                } else {
                    
                    DispatchQueue.main.async {
                        completion(false, nil, StringFactory.Messages.service_down_retry)
                    }
                }
                
            }
    }
}
