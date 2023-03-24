//
//  ContentView.swift
//  ArtWorkAssignment
//
//  Created by admin on 20/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ArtworkViewModel
    @State var isErrorOccurred: Bool = false
        
    var body: some View {
        
        NavigationStack(){
            SearchBar(searchText: $viewModel.searchText).padding(5)
            ScrollView {
                
                VStack {
                    if viewModel.customError != nil {
                        ProgressView().alert(isPresented: $isErrorOccurred){
                            Alert(title: Text("Oops Something Went Wrong!"), message: Text(viewModel.customError?.localizedDescription ?? ""), dismissButton: .default(Text("Okay")))
                        }
                    } else {
                        
                        LazyVGrid(columns: viewModel.columns) {
                            ForEach(viewModel.artArray){ artValue in
                                NavigationLink(destination: DetailScreen(artWork: artValue)){
                                    
                                    ListCellView(artWork: artValue)
                                    
                                }
                                
                            }
                                                       
                            if viewModel.isSearchListFull == false {
                                Color.clear.onAppear{
                                    viewModel.loadMore()
                                    
                                }
                            }
                             
                          /*
                            switch viewModel.state {
                            case .good:
                            ProgressView().onAppear{
                                viewModel.loadMore()
                            }
                            case .isLoading:
                                ProgressView().progressViewStyle(.circular)
                            case .loadAll:
                                Color.red.frame(height: 50)
                            case .error(let message):
                                Text(message).foregroundColor(.pink)
                                
                            }
                            */
                            
                        }.onAppear{
                            viewModel.getDataArtList(urlString: APIEndpoints.baseURL)
                            if viewModel.customError != nil {
                                isErrorOccurred = true
                            } else {
                                isErrorOccurred = false
                            }

                        }
                        
                    }
                                      
                }

                
            }.navigationTitle("ArtWork List")
            
        }.padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ArtworkViewModel(networkManager: NetworkManager()))
    }
}
