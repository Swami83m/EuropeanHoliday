//
//  GetHolidayListData.swift
//  EuropeanHoliday
//
//  
//

import Foundation

public class GetHolidayListData: Decodable {
    
    // MARK: Properties
    public var date: String?
    public var name: String?
    public var fixed: Bool?
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private enum CodingKeys: String, CodingKey {
        case date = "date"
        case name = "name"
        case fixed = "fixed"
        
    }
    
}
