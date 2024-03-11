//
//  CountryListModelView.swift
//  EuropeanHoliday
//
//  
//

import Foundation

protocol CountryListVMDelegate: AnyObject {
    func updateViewUsingFetchedData()
    func fetchDataFailure(message: String, canRetry: Bool)
}

class CountryListModelView {
    weak var viewDelegate: CountryListVMDelegate?
    var countryModel: [GetCountryListData] = []
    private let restClient: RestServiceManager
    
    init(restClient: RestServiceManager = RestClient()) {
        self.restClient = restClient
    }
    
    func getCountryListFromServer() {
        restClient.getRequestForJSON(apiKey: "AvailableCountries",
                                     serviceScheme: HolidayServiceScheme.holidayListJSON,
                                     holidayResponseModel: [GetCountryListData].self, mockJsonModel: nil) { [self] (success, json, message) in
            if success {
                guard let dataModel = json else { fatalError("Unexpected data") } // if success json shouldn't be null
                if dataModel.count > 0 {
                    self.countryModel  = dataModel
                    viewDelegate?.updateViewUsingFetchedData()
                }
            } else {
                // retry if network call failed for some reason
                viewDelegate?.fetchDataFailure(message: message, canRetry: false)
            }
        }
        
    }
    
    func getCountryListByMockModel(dataModel: [GetCountryListData]) {
        if dataModel.count > 0 {
            self.countryModel  = dataModel
            viewDelegate?.updateViewUsingFetchedData()
        } else {
            // retry if network call failed for some reason
            viewDelegate?.fetchDataFailure(message: "No Data Show", canRetry: false)
        }
    }
    
}
