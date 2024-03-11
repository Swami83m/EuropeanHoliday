//
//  GetCountryListData.swift
//  EuropeanHoliday
//
//  
//

import Foundation

public class GetCountryListData: Decodable {
    
    // MARK: Properties
    public var countryName: String?
    public var countryCode: String?
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private enum CodingKeys: String, CodingKey {
        case countryName = "name"
        case countryCode = "countryCode"
        
    }
    
}

