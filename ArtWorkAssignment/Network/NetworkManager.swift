//
//  NetworkManager.swift
//  ArtWorkAssignment
//
//  Created by admin on 15/03/2023.
//

import Foundation
import Combine

protocol Networkable {
//    func getDataFromAPI(url: URL) async throws -> Data
    func getDataFromAPI<T:Decodable>(url: URL, type:T.Type) -> AnyPublisher<T, Error>
}

//final means subclass cannot be created
final class NetworkManager: Networkable {
    
    func getDataFromAPI<T>(url: URL, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        return URLSession.shared.dataTaskPublisher(for:url)
            .map{$0.data}//.delay(for: .seconds(5.0), scheduler: DispatchQueue.main)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError{
                error -> NetworkError in
                switch error{
                case is URLError:
                    return NetworkError.invalidURL
                case NetworkError.dataNotFound:
                    return NetworkError.dataNotFound
                case is DecodingError:
                    return NetworkError.parsingError
                default:
                    return NetworkError.dataNotFound
                }
                    
            }
            .eraseToAnyPublisher()
    }
    
    
    
/*
    func getDataFromAPI(url: URL) async throws -> Data {
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
        
            return data
        }catch let error{
            print(error.localizedDescription)
            throw error
        }
    }
 */
}

