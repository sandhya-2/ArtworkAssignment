//
//  ArtworkViewModel.swift
//  ArtWorkAssignment
//
//  Created by admin on 15/03/2023.
//

import Foundation
import Combine
import SwiftUI

class ArtworkViewModel: ObservableObject {
    
    enum State: Comparable {
        case good
        case isLoading
        case loadAll
        case error(String)
    }
        
    @Published var artArray:[ArtworkData] = []
    var searchResultArray:[ArtworkData] = []
    
    @Published var customError: NetworkError?
    @Published var searchText: String = "" 
    let columns:[GridItem] = Array(repeating:.init(.flexible()), count: 2)
    
    let networkManager : Networkable
    private var cancellable = Set<AnyCancellable>()
    private var cancel: AnyCancellable?
    
    @Published var currentPage: Int = 1
    var isSearchListFull = false
    var totalPages = 0
    var perPage = 12
    
    @Published var state: State = .good {
        didSet {
//            print("state changed to: \(state)")
        }
    }
    
    init(networkManager: Networkable){
        self.networkManager = networkManager
    }
    
    //MARK: - PAGINATION
    func loadMore(){
        guard searchText.count == 0 else {
            return
        }
        getDataArtList(urlString: APIEndpoints.baseURL+"\(currentPage)")
    }
    
    //MARK: - SearchBar
    func getSearchResults(searchString:String) {

        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map {
            guard !$0.isEmpty else { return self.searchResultArray }
                let lowerCasedText = $0.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            return self.searchResultArray.filter {
                guard let artist = $0.artist_title else {
                    return false
                }
                return artist.lowercased().contains(lowerCasedText)
            }
        }/* capturing the results on this array*/
        .assign(to: \.artArray,on: self)
        .store(in: &cancellable)
    }
    
    //MARK: - Fetching the data
    func getDataArtList(urlString:String){
        guard let url = URL(string: urlString) else {
            self.customError = NetworkError.invalidURL
            return }
                
        guard state == State.good else {
            return
        }
        print("Starting fetching \(currentPage)....")
        print(" fetching no. \(url.absoluteString)")
        state = .isLoading
        /*here the actual root model should be used*/
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
    
  /*
      func getDataArtList() async{
     let networkManager = NetworkManager()
     do {
     
     let data =  try await networkManager.getDataFromAPI(url: URL(string: "https://api.artic.edu/api/v1/artworks")!)
     let results = try JSONDecoder().decode(ArtBaseModel.self, from: data)
     DispatchQueue.main.async {
         self.artArray = results.data ?? []
     }
     print(self.artArray)
     
     }catch let error{
     print(error.localizedDescription)
     }
     
     
     }
   */
}


