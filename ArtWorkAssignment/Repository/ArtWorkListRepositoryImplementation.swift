//
//  ArtWorkListRepositoryImplementation.swift
//  ArtWorkAssignment
//
//  Created by admin on 22/03/2023.
//

import Foundation

class ArtWorkListRepositoryImplementation: ArtWorkListRepository {
    
    private let networkManager: Networkable
    
    init(networkManager: Networkable) {
        self.networkManager = networkManager
    }
    
    self.networkManager.getDataFromAPI(url: url, type: ArtBaseModel.self)
        .receive(on: RunLoop.main)
        .sink { completion in
            
            switch completion{
            case .finished:
                print("In finished case")
                break
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.state = .error("Could not load: \(error.localizedDescription)")
                    switch error{
                    case is URLError:
                        self.customError = NetworkError.invalidURL
                    case NetworkError.dataNotFound:
                        self.customError = NetworkError.dataNotFound
                    case is DecodingError:
                        self.customError = NetworkError.parsingError
                    default:
                        self.customError = NetworkError.dataNotFound
                    }
                }
            }
        } receiveValue: { artWorkList in
        
            self.currentPage += 1
            self.artArray = artWorkList.data
            self.getSearchResults(searchString: self.searchText)
            self.searchResultArray.append(contentsOf: artWorkList.data)
            
            self.state = self.artArray.count == self.perPage ? .good : .loadAll
            if self.artArray.count < self.perPage {
                self.isSearchListFull = true
            }
            
//                print("searchArray \(self.searchResultArray)")
            print("*****\(self.artArray)")
        }.store(in: &cancellable)
}
