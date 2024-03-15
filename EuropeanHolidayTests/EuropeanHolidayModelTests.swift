//
//  EuropeanHolidayTests.swift
//  EuropeanHolidayTests
//
//
//

import XCTest
@testable import EuropeanHoliday
final class EuropeanHolidayModelTests: XCTestCase {
    
    override func setUp() {
        
    }
    override func tearDown() {
        
        super.tearDown()
    }
    func testIsHolidayModelValidity() {
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
            let user = try JSONDecoder().decode(GetHolidayListData.self, from: jsonData)
            // Verify the values
            XCTAssertEqual(user.name, "Newyear")
            XCTAssertEqual(user.date, "2024-01-01")
            XCTAssertEqual(user.fixed, false)
            
        } catch {
            XCTFail("Failed to decode JSON: \(error)")
        }
    }
    
    func testHolidayList() {
        let t = type(of: self)
        let bundle = Bundle(for: t.self)
        if let filePath = bundle.path(forResource: "HolidayMockModel", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
                let model  = try JSONDecoder().decode([GetHolidayListData].self, from: data)
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
