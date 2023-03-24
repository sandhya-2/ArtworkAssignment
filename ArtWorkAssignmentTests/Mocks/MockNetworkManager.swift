//
//  MockNetworkManager.swift
//  ArtWorkAssignmentTests
//
//  Created by admin on 22/03/2023.
//

import Foundation
import Combine
@testable import ArtWorkAssignment

class MockNetworkManager: Networkable {
    
    func getDataFromAPI<T>(url: URL, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        
        do {
            let bundle = Bundle(for: MockNetworkManager.self)
            guard let path = bundle.url(forResource: url.absoluteString, withExtension: "json") else {
                return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()         
            }
            let data = try Data(contentsOf: path)
            let artList = try JSONDecoder().decode(T.self, from: data)
            let mockPublisher = Just(artList)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            return mockPublisher
        } catch {
            return Fail(error: NetworkError.dataNotFound).eraseToAnyPublisher()
        }
    }
    
    
    
}

