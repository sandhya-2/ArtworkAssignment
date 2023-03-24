//
//  DescriptionView.swift
//  ArtWorkAssignment
//
//  Created by admin on 21/03/2023.
//

import SwiftUI

struct DescriptionView: View {
    
    let artWork: ArtworkData
    let artistDetail: [String] = ["Title", "Artist_title","Place of Origin", "Artist Display"]
    
    var body: some View {
        GroupBox(){
            DisclosureGroup("Artist's Details"){
                                
                ForEach(artistDetail.indices, id: \.self){ value in
                    Divider().padding(.vertical, 2)
                    HStack {
                        Group {
                            Image(systemName: "info.circle")
                            
                                Text(artistDetail[value])
                            Text(artWork.title ?? "None")
                            }
                            
                        
                        .foregroundColor(Color.gray)
                            .font(.system(.body).bold())
                        Spacer(minLength: 25)
//                        Text(artWork?.artist_title ?? "")
                            .multilineTextAlignment(.trailing)
                    }
                
                }
            }
        }
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(artWork: ArtworkData(id: 0, title: "", place_of_origin: "", artist_title: "", artist_display: "", image_id: ""))
    }
}
