//
//  ArtWorkAssignmentTests.swift
//  ArtWorkAssignmentTests
//
//  Created by admin on 20/03/2023.
//

import XCTest
@testable import ArtWorkAssignment

final class ArtWorkAssignmentTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
    }
    
    override func tearDownWithError() throws {
        
        try super.tearDownWithError()
    }
    
    func test_ArtworkViewModel_WhenEverthing_isCorrect() throws {
        let viewModel = ArtworkViewModel(networkManager: MockNetworkManager())
        XCTAssertNotNil(viewModel)
        let expectation = XCTestExpectation(description: "Successfully decoded and fetched the ArtWorkData")
        
        viewModel.getDataArtList(urlString: "ArtworkTest")
        
        let waitDuration = 2.0

        DispatchQueue.main.asyncAfter(deadline:.now() + waitDuration ){
            let expectedResult = viewModel.searchResultArray.count
            let actualResult = 12
            let artwork = viewModel.searchResultArray.first
            XCTAssertFalse(viewModel.searchResultArray.isEmpty)
            XCTAssertNotNil(viewModel.searchResultArray)
            XCTAssertEqual(expectedResult, actualResult)
            XCTAssertNil(viewModel.customError)
            
            XCTAssertEqual("Max Beckmann", artwork?.artist_title)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }
    
    func test_ArtworkViewModel_When_URL_isWrong(){
        let viewModel = ArtworkViewModel(networkManager: MockNetworkManager())
        XCTAssertNotNil(viewModel)
        
        viewModel.getDataArtList(urlString: "ArtworkTest34")
        let expectation = XCTestExpectation(description: "Data not found is received when fetching the data")
        
        let waitDuration = 3.0
        let expectedResult = viewModel.searchResultArray.count
        let actualResult = 0
        DispatchQueue.main.asyncAfter(deadline:.now() + waitDuration ){
            XCTAssertTrue(viewModel.searchResultArray.isEmpty)
            XCTAssertEqual(expectedResult, actualResult)
            XCTAssertNotNil(viewModel.customError)
            XCTAssertEqual(viewModel.customError, NetworkError.dataNotFound)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
        
    }
    
    func test_ArtworkViewModel_When_EmptyURL_isPassed() {
        let viewModel = ArtworkViewModel(networkManager: MockNetworkManager())
        XCTAssertNotNil(viewModel)
        
        viewModel.getDataArtList(urlString: "")
        let expectation = XCTestExpectation(description: "Invalid Error is received when fetching the data")
        
        let waitDuration = 3.0
        let expectedResult = viewModel.searchResultArray.count
        let actualResult = 0
        
        DispatchQueue.main.asyncAfter(deadline:.now() + waitDuration ){
            XCTAssertTrue(viewModel.searchResultArray.isEmpty)
            XCTAssertEqual(expectedResult, actualResult)
            XCTAssertNotNil(viewModel.customError)
            XCTAssertEqual(viewModel.customError, NetworkError.invalidURL)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
        
    }
    
    func test_ArtworkViewModel_When_URLisCorrect_But_NoData_is_received(){
        let viewModel = ArtworkViewModel(networkManager: MockNetworkManager())
        XCTAssertNotNil(viewModel)
        
        viewModel.getDataArtList(urlString: "ArtworkTestEmpty")
        let expectation = XCTestExpectation(description: "DataNot Found Error is received and No Data is received")
        
        let waitDuration = 3.0
        let expectedResult = viewModel.searchResultArray.count
        let actualResult = 0
        
        DispatchQueue.main.asyncAfter(deadline:.now() + waitDuration ){
            XCTAssertTrue(viewModel.searchResultArray.isEmpty)
            XCTAssertEqual(expectedResult, actualResult)
            XCTAssertNotNil(viewModel.customError)
            XCTAssertEqual(viewModel.customError, NetworkError.dataNotFound)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
        
    }
    
    func test_getSearchResults_when_searchText_isInthe_List(){
        let viewModel = ArtworkViewModel(networkManager: MockNetworkManager())
        XCTAssertNotNil(viewModel)
        
        viewModel.getDataArtList(urlString: "ArtworkTest")
        viewModel.searchText = "Guido Reni"
        let expectation = XCTestExpectation(description: "Fetching searchText in the list")
        let waitDuration = 3.0

        DispatchQueue.main.asyncAfter(deadline:.now() + waitDuration ){
            XCTAssertFalse(viewModel.artArray.isEmpty)
            XCTAssertEqual(viewModel.artArray.first?.artist_title, "Guido Reni")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }
    
    func test_getSearchResults_when_searchText_isNot_IN_the_List(){
        let viewModel = ArtworkViewModel(networkManager: MockNetworkManager())
        XCTAssertNotNil(viewModel)
        
        viewModel.getDataArtList(urlString: "ArtworkTest")
        viewModel.searchText = "Mkghk"
        
        let expectation = XCTestExpectation(description: "Fetching searchText in the list but no match")
        let waitDuration = 3.0
        
        DispatchQueue.main.asyncAfter(deadline:.now() + waitDuration ){
            XCTAssertTrue(viewModel.artArray.isEmpty)
            XCTAssertEqual(viewModel.artArray.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
        
    }
    
    func test_getSearchResults_when_searchText_isEmpty_String(){
        let viewModel = ArtworkViewModel(networkManager: MockNetworkManager())
        XCTAssertNotNil(viewModel)
        
        viewModel.getDataArtList(urlString: "ArtworkTest")
        viewModel.searchText = " "
        
        let expectation = XCTestExpectation(description: "Fetching searchText as empty string with space but No match is found")
        let waitDuration = 3.0
        
        DispatchQueue.main.asyncAfter(deadline:.now() + waitDuration ){
            XCTAssertTrue(viewModel.artArray.isEmpty)
            XCTAssertEqual(viewModel.artArray.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
        
        
    }
    
}
