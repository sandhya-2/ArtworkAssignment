//
//  Session.swift
//  ArtWorkAssignment
//
//  Created by admin on 22/03/2023.
//

import Foundation

protocol Session {
    func requestData(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
    
//    func requestData(url: URLRequest) -> AnyPublisher<T, Error>
}

extension URLSession: Session {
    
    func requestData(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        self.dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
    
    
}
