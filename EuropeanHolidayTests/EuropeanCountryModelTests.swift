//
//  EuropeanCountryModelTests.swift
//  EuropeanHolidayTests
//
//  
//

import XCTest
@testable import EuropeanHoliday
final class EuropeanCountryModelTests: XCTestCase {

    var countryModel: [GetCountryListData] = []
    var sut: MockRestClient!
    
    override func setUp() {
        sut = MockRestClient()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    func testParsingMockJSON() {
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
            // Verify the values
            XCTAssertEqual(country.countryCode, "AU")
            XCTAssertEqual(country.countryName, "Australia")
            
        } catch {
            XCTFail("Failed to decode JSON: \(error)")
        }
    }
    func testEmptyCountryCode() {
        let emptyCoutryCode = "AU"
        let isEmptyCode = isEmptyChecking(title: emptyCoutryCode)
        XCTAssertFalse(isEmptyCode, "CountryCode should not be empty")
    }
    func isEmptyChecking(title: String) -> Bool {
        return title.isEmpty
    }
    
    func testCountryList() {
        let t = type(of: self)
        let bundle = Bundle(for: t.self)
        if let filePath = bundle.path(forResource: "CountryListMockModel", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
                let model  = try JSONDecoder().decode([GetHolidayListData].self, from: data)
                
                sut.getRequestForJSON(apiKey:"",
                    serviceScheme: HolidayServiceScheme.holidayListJSON,
                                             holidayResponseModel: [GetCountryListData].self, mockJsonModel: data) { [self] (success, json, message) in
                    if success {
                    guard let dataModel = json else { fatalError("Unexpected data") } // if success json shouldn't be null
                        if dataModel.count > 0 {
                            self.countryModel  = dataModel
                        }
                    }
                }
            XCTAssertFalse(model.isEmpty)
            } catch {
                XCTAssert(false, error.localizedDescription)
            }
        }
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
