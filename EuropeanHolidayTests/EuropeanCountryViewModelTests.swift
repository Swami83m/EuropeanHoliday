//
//  EuropeanCountryViewModelTests.swift
//  EuropeanHolidayTests
//
//  
//

import XCTest
@testable import  EuropeanHoliday
final class EuropeanCountryViewModelTests: XCTestCase, CountryListVMDelegate {

    var sut: CountryListModelView!
    var expectation: XCTestExpectation!
    var countryList: [GetCountryListData] = []
    
    override func setUp() {
        expectation = self.expectation(description: "Country List Should be fetched")
        sut = CountryListModelView()
        sut.viewDelegate = self
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDataViewModel()
    {
        sut.getCountryListByMockModel(dataModel: getSampleMockedJSON())
        wait(for: [expectation], timeout: 4)
        XCTAssertFalse(countryList.isEmpty)
    }
    
    func updateViewUsingFetchedData() {
        countryList = sut.countryModel
        expectation.fulfill()
    }
    
    func getSampleMockedJSON() -> [GetCountryListData] {
        // Your mock JSON data
        let jsonData = """
            {
                "countryCode": "AU",
                "name": "Australia",
            }
            """.data(using: .utf8)!
        // Use JSONDecoder to parse the data into your model
        do {
            let country = try JSONDecoder().decode(GetCountryListData.self, from: jsonData)
            return [country]
            
        } catch {
            return []
        }
    }
    
    func fetchDataFailure(message: String, canRetry: Bool) {
        expectation.fulfill()
    }
}
