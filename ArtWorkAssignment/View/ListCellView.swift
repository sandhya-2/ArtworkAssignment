//
//  ListCellView.swift
//  ArtWorkAssignment
//
//  Created by admin on 20/03/2023.
//

import SwiftUI

struct ListCellView: View {
    
    let artWork: ArtworkData
    
    var body: some View {
        VStack{
            
            ImageView(artWork: artWork)

            Text(artWork.artist_title ?? "Guido Reni")
                .font(.subheadline)

        }.frame(width: 170, height: 170, alignment: .top)
            .background(Color.yellow)
            .cornerRadius(20)
         
    }
}

struct ListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ListCellView(artWork: ArtworkData(id: 0, title: "", place_of_origin: "", artist_title: "Guido Reni", artist_display: "", image_id: "1f5b595f-dbbd-3c9d-ca49-9263c3d93841"))
    }
}
