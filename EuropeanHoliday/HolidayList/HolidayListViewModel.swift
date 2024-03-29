//
//  HolidayListVM.swift
//  EuropeanHoliday
//
//
//

import Foundation

protocol HolidayListViewModelDelegate: AnyObject {
    func updateViewUsingFetchedData()
    func fetchDataFailure(message: String, canRetry: Bool)
}

class HolidayListViewModel {
    
    private var selectedCountry: String
    private weak var viewDelegate: HolidayListViewModelDelegate?
    var holidayModel: [GetHolidayListData] = []
    private let restClient: RestServiceManager
    
    init(restClient: RestServiceManager = RestClient(), viewDelegate: HolidayListViewModelDelegate?, selectedCountry: String) {
        self.restClient = restClient
        self.viewDelegate = viewDelegate
        self.selectedCountry = selectedCountry
    }
    
    func getHolidayListfromServer() {
        
        if NetworkReachability.isConnectedToInternet == false {
            viewDelegate?.fetchDataFailure(message: StringFactory.Messages.noDataError, canRetry: false)
            return
        }
        
        restClient.fetchDataFromRestAPI(apiKey: StringFactory.ApiURL.publicHolidayURL + self.selectedCountry,
                                        holidayResponseModel: [GetHolidayListData].self) { [self] (success, json, message) in
            if success {
                guard let dataModel = json else { fatalError(StringFactory.Messages.unExpectedData) } // if success json shouldn't be null
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
    
}
