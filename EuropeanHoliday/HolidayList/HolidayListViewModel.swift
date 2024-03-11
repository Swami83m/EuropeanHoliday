//
//  HolidayListVM.swift
//  EuropeanHoliday
//
// 
//

import Foundation

protocol HolidayListVMDelegate: AnyObject {
func updateViewUsingFetchedData()
func fetchDataFailure(message: String, canRetry: Bool)
}

class HolidayListViewModel {
    
var selectedCountry: String?
weak var viewDelegate: HolidayListVMDelegate?
var holidayModel: [GetHolidayListData] = []
private let restClient: RestServiceManager
    
    init(restClient: RestServiceManager = RestClient()) {
        self.restClient = restClient
    }
   
func getHolidayListfromServer() {
    
    guard let countryCode = self.selectedCountry else { return }
    
    restClient.getRequestForJSON(apiKey: "publicholidays/2024/\(countryCode)",
        serviceScheme: HolidayServiceScheme.holidayListJSON,
                                 holidayResponseModel: [GetHolidayListData].self, mockJsonModel: nil) { [self] (success, json, message) in
        if success {
        guard let dataModel = json else { fatalError("Unexpected data") } // if success json shouldn't be null
            if dataModel.count > 0 {
                self.holidayModel  = dataModel
                viewDelegate?.updateViewUsingFetchedData()
            }
        } else {
            // retry if network call failed for some reason
            viewDelegate?.fetchDataFailure(message: message, canRetry: false)
        }
    }
}
    
    func getHolidayListByMockModel(dataModel: [GetHolidayListData]) {
        if dataModel.count > 0 {
            self.holidayModel  = dataModel
            viewDelegate?.updateViewUsingFetchedData()
        } else {
            // retry if network call failed for some reason
            viewDelegate?.fetchDataFailure(message: "No Data Show", canRetry: false)
        }
    }
    
}
