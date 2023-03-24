//
//  NetworkManagerTests.swift
//  ArtWorkAssignmentTests
//
//  Created by admin on 23/03/2023.
//

import XCTest
import Combine
@testable import ArtWorkAssignment

final class NetworkManagerTests: XCTestCase {

    var networkManager: MockNetworkManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.networkManager = MockNetworkManager()
    }

    override func tearDownWithError() throws {
        self.networkManager = nil
        try super.tearDownWithError()
    }

    func  test_Successfull_getDataFromAPI() {
        
        let expection = expectation(description: "Successfully received and decoded the data")

//        self.networkManager.getDataFromAPI(url: , type: )
    }



}
