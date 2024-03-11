//
//  EuropeanHolidayViewModelTests.swift
//  EuropeanHolidayTests
//
//
//

import XCTest
@testable import EuropeanHoliday

final class EuropeanHolidayViewModelTests: XCTestCase, HolidayListVMDelegate {
    
    var sut: HolidayListViewModel!
    var expectationHoliday: XCTestExpectation!
    var holidayList: [GetHolidayListData] = []
    
    override func setUp() {
        sut = HolidayListViewModel()
        sut.viewDelegate = self
        expectationHoliday = self.expectation(description: "Holiday List Should be fetched")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDataViewModel()
    {
        sut.getHolidayListByMockModel(dataModel: getSampleMockedJSON())
        wait(for: [expectationHoliday], timeout: 4)
        XCTAssertFalse(holidayList.isEmpty)
    }
    
    func updateViewUsingFetchedData() {
        holidayList = sut.holidayModel
        expectationHoliday.fulfill()
        
    }
    
    func fetchDataFailure(message: String, canRetry: Bool) {
        expectationHoliday.fulfill()
    }
    
    func getSampleMockedJSON() -> [GetHolidayListData] {
        // Your mock JSON data
        let jsonData = """
            {
                "name": "Newyear",
                "date": "2024-01-01",
                "fixed": false
            }
            """.data(using: .utf8)!
        // Use JSONDecoder to parse the data into your model
        do {
            let holiday = try JSONDecoder().decode(GetHolidayListData.self, from: jsonData)
            return [holiday]
            
        } catch {
            return []
        }
    }
    
    func testSelectedCountryNotEmpty()
    {
        sut.selectedCountry = "AU"
        XCTAssertNotNil(sut.selectedCountry)
        let isEmptyCode = isEmptyChecking(title: sut.selectedCountry ?? "")
        XCTAssertFalse(isEmptyCode, "CountryCode should not be empty")
    }
    
    func isEmptyChecking(title: String) -> Bool {
        return title.isEmpty
    }
}



