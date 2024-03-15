//
//  CountryListViewModel.swift
//  EuropeanHoliday
//
//
//

import Foundation

protocol CountryListViewModelDelegate: AnyObject {
    func updateViewUsingFetchedData()
    func fetchDataFailure(message: String, canRetry: Bool)
}

class CountryListViewModel {
    private weak var viewDelegate: CountryListViewModelDelegate?
    private(set) var countryModel: [GetCountryListData] = []
    private let restClient: RestServiceManager
    
    init(restClient: RestServiceManager = RestClient(), viewDelegate: CountryListViewModelDelegate?) {
        self.restClient = restClient
        self.viewDelegate = viewDelegate
    }
    
    func getCountryListFromServer() {
        if NetworkReachability.isConnectedToInternet == false {
            viewDelegate?.fetchDataFailure(message: StringFactory.Messages.noDataError, canRetry: false)
            return
        }
        restClient.fetchDataFromRestAPI(apiKey: StringFactory.ApiURL.availableCountry,
                                        holidayResponseModel: [GetCountryListData].self) { [self] (success, json, message) in
            if success {
                guard let dataModel = json else { fatalError(StringFactory.Messages.unExpectedData) } // if success json shouldn't be null
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
    
}
