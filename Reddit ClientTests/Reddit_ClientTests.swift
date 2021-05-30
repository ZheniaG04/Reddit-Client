//
//  Reddit_ClientTests.swift
//  Reddit ClientTests
//
//  Created by Женя on 24.05.2021.
//

import XCTest
@testable import Reddit_Client

class Reddit_ClientTests: XCTestCase {
    
    var networkManager: NetworkManager!

    override func setUpWithError() throws {
        networkManager = NetworkManager()
    }

    override func tearDownWithError() throws {
        networkManager = nil
    }

    func testNetworkManagerFetchData() throws {
        
        //Given
        var successFetch = false
        let fetchDataExpectation = expectation(description: "Expectation in " + #function)
        
        //When
        networkManager.fetchData { result in
            if case .success = result {
                successFetch = true
            } else {
                successFetch = false
            }
            fetchDataExpectation.fulfill()
        }
        
        //Then
        waitForExpectations(timeout: 5.0) { _ in
            XCTAssertTrue(successFetch)
        }
    }
}
