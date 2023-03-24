////
////  ImageView.swift
////  ArtWorkAssignment
////
////  Created by admin on 20/03/2023.
////
//
//import SwiftUI
//
//struct ImageView: View {
//
////    let urlString: String
//
////    init(urlString: String) {
////        self.urlString = urlString
////    }
//
//    let artWork: ArtworkData?
//    private let imageWidth = 160.0
//    private let cellHeight = 160.0
//
//    var body: some View {
//        if let artWork = artWork {
//
//            CacheAsyncImage(
//                url: URL(string: APIEndpoints.imageURLBeginPoint + (artWork.image_id ?? "1adf2696-8489-499b-cad2-821d7fde4b33") + APIEndpoints.imageEndPoint)!) { phase in
//                switch phase {
//                case .success(let image):
//                    VStack {
//                        image
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: imageWidth)
//                            .padding(.trailing, 10)
//
//                        let id = String(artWork.id ?? 0)
//                                       Text("ID: \(id)")
//                        Text(artWork.title ?? "")
//                                           .font(.title3)
//                                           .bold()
//
//                        Spacer()
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
////                    ErrorView(error: error)
//                case .empty:
//                    HStack {
//                        ProgressView()
//                            .progressViewStyle(CircularProgressViewStyle(tint: .red))
//                        Spacer()
//                    }
//                @unknown default:
//                    Image(systemName: "questionmark")
//                }
//            }
//            .frame(maxWidth: .infinity)
//            .frame(height: cellHeight)
//            .padding()
//            .listRowSeparator(.hidden)
//        }
//
//
//
//           /* CacheAsyncImage(
//                url: URL(string: "\(APIEndpoints.imageURLBeginPoint)\(artWork.image_id)\(APIEndpoints.imageEndPoint)")!) { phase in
//                    switch phase {
//
//                    case .success(let image):
//                        VStack {
//                            image
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .clipped()
//                                .frame(width: imageWidth)
//                                .padding(.trailing, 10)
//                            let id = String(artWork.id)
//                            Text("ID: \(id)")
//                            Text(artWork.artist_title)
//                            Spacer()
//                        }
//                    case .empty:
//                        HStack{
//                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .yellow))
//                        }
//                    case .failure(let error):
//                        print(error)
//
//                    @unknown default :
//                        Image(systemName: "questionmark")
//                    }
//
//                }*/
//
//

//
//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
////        ImageView(urlString: "https://www.artic.edu/iiif/2/1adf2696-8489-499b-cad2-821d7fde4b33/full/843,/0/default.jpg")
//        ImageView(artWork: ArtworkData(id: 0, title: "", place_of_origin: "", artist_title: "", artist_display: "", image_id: ""))
//    }
//}


