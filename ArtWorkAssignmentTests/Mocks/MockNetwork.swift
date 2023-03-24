//
//  MockNetwork.swift
//  ArtWorkAssignmentTests
//
//  Created by admin on 22/03/2023.
//
//
import Foundation
import Combine
@testable import ArtWorkAssignment

class MockNetwork: Networkable {
 
    func getDataFromAPI<T>(url: URL, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        
        switch url.absoluteString {
        case _ where url.absoluteString.contains(NetworkError.invalidURL.urlTest):
            guard let model = [] as? T else { return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher() }
            /* this is the success case*/
            return Just(model)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            
        case _ where url.absoluteString.contains(NetworkError.dataNotFound.urlTest):
            return Fail(error: NetworkError.dataNotFound).eraseToAnyPublisher()
            
        case _ where url.absoluteString.contains(NetworkError.parsingError.urlTest):
            
            return Fail(error: NetworkError.parsingError).eraseToAnyPublisher()
        default:
            do
            {
                let bundle = Bundle(for: MockNetwork.self)
                guard let path = bundle.url(forResource: url.absoluteString, withExtension: "json") else {
                    return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
                }
                
                let data = try Data(contentsOf: path)
                let artList = try JSONDecoder().decode(T.self, from: data)

//                guard let model = artList as? T else { return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher() }
                /* this is the success case*/
                return Just(artList)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } catch {
                return Fail(error: NetworkError.dataNotFound).eraseToAnyPublisher()
                
            }
           
            
            
        }
        
    }
    
}

extension NetworkError {
    
    var urlTest: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .dataNotFound:
            return "DataNot Found"
        case .parsingError:
            return "Parsing Error"
        @unknown default:
            return "Parsing Error"
        }
    }
    
}
