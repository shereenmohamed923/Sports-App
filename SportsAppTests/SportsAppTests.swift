//
//  SportsAppTests.swift
//  SportsAppTests
//
//  Created by Macos on 15/05/2025.
//

import XCTest
@testable import SportsApp

final class SportsAppTests: XCTestCase {

    func testFetchSuccess() {
            let mock = FakeNetworkApi()
            mock.mockData = [["league": "NBA", "teams": 32]]
            mock.mockError = nil

            let expectation = self.expectation(description: "fetchData completes")

            mock.fetchData(sport: .basketball, endpoint: .league, addOn: "") { data, error in
                XCTAssertNotNil(data)
                XCTAssertNil(error)
                XCTAssertEqual(data?.first?["league"] as? String, "NBA")
                expectation.fulfill()
            }

            waitForExpectations(timeout: 1.0)
        }

        func testFetchFailure() {
            let mock = FakeNetworkApi()
            mock.mockError = NSError(domain: "test", code: 1, userInfo: nil)
            mock.shouldFail=true
            let expectation = self.expectation(description: "fetchData fails")

            mock.fetchData(sport: .football, endpoint: .league, addOn: "") { data, error in
                XCTAssertNil(data)
                XCTAssertNotNil(error)
                expectation.fulfill()
            }

            waitForExpectations(timeout: 1.0)
        }
    
    func testRealNetworkFetch() {
            let networkService = NetworkService()
            let expectation = self.expectation(description: "Fetch data from real API")

            networkService.fetchData(sport: .basketball, endpoint: .league, addOn: "") { data, error in
                XCTAssertNil(error, "Expected no error, got: \(String(describing: error))")
                XCTAssertNotNil(data, "Expected data")
                XCTAssertFalse(data!.isEmpty, "Expected non-empty data array")
                expectation.fulfill()
            }

            waitForExpectations(timeout: 5.0, handler: nil)
        }
    

}
