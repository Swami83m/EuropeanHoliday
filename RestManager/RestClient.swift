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

class Connectivity {
    // check for network connectivity using Alamofire
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

struct ServiceScheme {
    let baseURL: String
    var header: HTTPHeaders
}


// MARK: - Struct to create an error message object
struct ErrorMessage: Decodable {
    var enMessage: String?
    var message: String?
    
    private enum CodingKeys: String, CodingKey {
        case enMessage = "ENErrorMessage"
        case message = "message"
    }
}

// make it easy to handle different REST service configuration
enum HolidayServiceScheme {
    case holidayListJSON
    
    func getRequestProperties(apiUrl: String? = nil)->ServiceScheme{
        switch self {
            
        case .holidayListJSON:
            return ServiceScheme(baseURL: httpProtocol + hostName,
                                 header: ["Content-Type": "application/json"])
        }
    }
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
    
   
    
     func getRequestForJSON<T>(apiKey: String,serviceScheme: HolidayServiceScheme, holidayResponseModel: T.Type, mockJsonModel: Data? = nil, completion: @escaping (Bool, T?, String) -> ()) where T : Decodable  {
        // check for a network connection
        if (Connectivity.isConnectedToInternet == false){
            DispatchQueue.main.async {
                completion( false, nil, StringFactory.Messages.no_internet)
            }
            
            return
        }
    
        if  mockJsonModel != nil {
            return
        }
        
        var serviceURL = ""
        if !apiKey.isEmpty {
            // create a service call configuration based on run environment
            serviceURL = serviceScheme.getRequestProperties().baseURL + apiKey.trim()
        }
        let serviceHeader = serviceScheme.getRequestProperties().header
        
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
