//
//  EuropeanCountryViewModelTests.swift
//  EuropeanHolidayTests
//
//  
//

import XCTest
@testable import  EuropeanHoliday
final class EuropeanCountryViewModelTests: XCTestCase, CountryListViewModelDelegate {
    
    var sut: CountryListViewModel!
    var expectation: XCTestExpectation!
    var countryList: [GetCountryListData] = []
    
    override func setUp() {
        sut = CountryListViewModel.init(restClient: MockCountryListServiceManager(), viewDelegate: self)
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDataViewModel()
    {
        expectation = self.expectation(description: "Country List Should be fetched")
        sut.getCountryListFromServer()
        wait(for: [expectation], timeout: 8)
        XCTAssertFalse(countryList.isEmpty)
    }
    
    func updateViewUsingFetchedData() {
        countryList = sut.countryModel
        expectation.fulfill()
    }
    
    
    func fetchDataFailure(message: String, canRetry: Bool) {
        expectation.fulfill()
    }
}
