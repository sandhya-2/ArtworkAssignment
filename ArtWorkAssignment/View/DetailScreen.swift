//
//  DetailScreen.swift
//  ArtWorkAssignment
//
//  Created by admin on 20/03/2023.
//

import SwiftUI

struct DetailScreen: View {
    
    let artWork: ArtworkData
    
    var body: some View {
        VStack{
            ScrollView {
                VStack{
                    AsyncImage(url: URL(string: APIEndpoints.imageURLBeginPoint + (artWork.image_id ?? "1adf2696-8489-499b-cad2-821d7fde4b33") + APIEndpoints.imageEndPoint)!) { phase in
                        if let image = phase.image {
                            image.resizable()
                                .clipped()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                        } else if phase.error != nil {
                            
                            Image(systemName: "questionmark")
                                .padding(.top, 40)
                            
                        } else {
                            ProgressView()
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                    VStack( alignment: .leading, spacing: 2) {
                        if let artWork = artWork {
                            Text("Title: \(artWork.title ?? "NA")")
                                .font(.headline)
                                .padding(5)
                                .bold()
                            
                            Text("Artist: \(artWork.artist_title ?? "NA") ")
                                .font(.headline)
                                .padding(5)
                                .bold()
                            
                            Text("Place of Origin: \(artWork.place_of_origin ?? "NA")")
                                .font(.subheadline)
                                .padding(5)
                            
                            Text("Artist Display: \(artWork.artist_display ?? "NA")")
                                .font(.subheadline)
                                .padding(5)
                        }
                    }
                    
                    Spacer()
                    
                }
                
            }
            
        }.navigationTitle("Detail Screen")
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(artWork: ArtworkData(id: 0, title: "", place_of_origin: "", artist_title: "", artist_display: "", image_id: ""))
    }
}

/* ImageView(urlString: APIEndpoints.imageURLBeginPoint+(artWork?.image_id ?? "1f5b595f-dbbd-3c9d-ca49-9263c3d93841")+APIEndpoints.imageEndPoint)
 .padding()
 */
