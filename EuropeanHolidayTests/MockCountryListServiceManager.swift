

import Foundation
@testable import EuropeanHoliday

class MockCountryListServiceManager: RestServiceManager {
    func fetchDataFromRestAPI<T>(apiKey: String, holidayResponseModel: T.Type, completion: @escaping (Bool, T?, String) -> ()) where T : Decodable {
        guard let jsonData = """
                    [{
                        "countryCode": "AU",
                        "name": "Australia",
                    }]
                    """.data(using: .utf8) else { return }
        
        do {
            let response = try JSONDecoder().decode(T.self, from: jsonData)
            completion(true, response, "")
        } catch let err {
            completion(false, nil, err.localizedDescription)
        }
    }
}
