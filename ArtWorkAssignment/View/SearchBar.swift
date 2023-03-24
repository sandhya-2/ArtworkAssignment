//
//  SearchBar.swift
//  ArtWorkAssignment
//
//  Created by admin on 17/03/2023.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack{
            
            TextField("       Search", text: $searchText)
                .frame(width: 350, height: 40)
                .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
                .font(.headline)
                .overlay(Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .offset(x: -160)
                    .opacity(!searchText.isEmpty ? 0.0 : 1.0)
                )
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.red)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.closeEdit()
                            searchText = ""
                        }
                    ,alignment: .trailing)
        }
    
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var searchWord = ""
    static var previews: some View {
        SearchBar(searchText: $searchWord)
    }
}

extension UIApplication {
    func closeEdit() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
