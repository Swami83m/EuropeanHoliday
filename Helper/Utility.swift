//
//  Utility.swift
//  EuropeanHoliday
//
//  
//

import Foundation
import UIKit

//MARK: - String Extensions
extension String {
    
    public func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
