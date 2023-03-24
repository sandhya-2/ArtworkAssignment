//
//  ImageView.swift
//  ArtWorkAssignment
//
//  Created by admin on 21/03/2023.
//

import SwiftUI

struct ImageView: View {
    let artWork: ArtworkData?
    private let imageWidth = 180.0
        private let cellHeight = 130.0

    var body: some View {
        
        if let artWork = artWork{
            CacheAsyncImage(
                url: URL(string: APIEndpoints.imageURLBeginPoint + (artWork.image_id ?? "1f5b595f-dbbd-3c9d-ca49-9263c3d93841" ) + APIEndpoints.imageEndPoint)!) { phase in
                switch phase {
                case .success(let image):
                    VStack {
                        image
                            .resizable()
                            .clipped()
                            .aspectRatio(contentMode: .fit)
                            .padding(.trailing, 5)
                            .frame(maxWidth: .infinity)
            
                    }
                case .failure(let error):
                    EmptyView()
//                    ErrorView(error: error)
                case .empty:
                    HStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .red))
                        Spacer()
                    }
                @unknown default:
                    // AsyncImagePhase is not marked as @frozen.
                    // We need to support new cases in the future.
                    Image(systemName: "questionmark")
                }
            }
            .frame(maxWidth: 180)
//            .frame(height: cellHeight)
            .padding()
            

        }
                
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(artWork: ArtworkData(id: 63279, title: "Grand Avenue, Chicago", place_of_origin: "United States", artist_title: "Guido Reni", artist_display: "José Lopez (American, born Cuba, 1941–1991) and\nLuis Medina (American, born Cuba, 1942–1985", image_id: "1f5b595f-dbbd-3c9d-ca49-9263c3d93841"))
    }
}

/*
 
 AsyncImage(url: URL(string: APIEndpoints.imageURLBeginPoint + (artWork?.image_id ?? "1adf2696-8489-499b-cad2-821d7fde4b33") + APIEndpoints.imageEndPoint)!) { phase in
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
 
 
 */

