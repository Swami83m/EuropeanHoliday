//
//  EuropeanHolidayViewModelTests.swift
//  EuropeanHolidayTests
//
//
//

import XCTest
@testable import EuropeanHoliday

final class EuropeanHolidayViewModelTests: XCTestCase, HolidayListViewModelDelegate {
    
    var sut: HolidayListViewModel!
    var expectationHoliday: XCTestExpectation!
    var holidayList: [GetHolidayListData] = []
    
    override func setUp() {
        sut = HolidayListViewModel.init(restClient: MockHolidayListServiceManager(), viewDelegate: self, selectedCountry: "GB")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDataViewModel()
    
    {
        expectationHoliday = self.expectation(description: "Holiday List Should be fetched")
        sut.getHolidayListfromServer()
        wait(for: [expectationHoliday], timeout: 8)
        XCTAssertFalse(holidayList.isEmpty)
    }
    
    func updateViewUsingFetchedData() {
        holidayList = sut.holidayModel
        expectationHoliday.fulfill()
        
    }
    
    func fetchDataFailure(message: String, canRetry: Bool) {
        expectationHoliday.fulfill()
    }
}



