//
//  ErrorView.swift
//  ArtWorkAssignment
//
//  Created by admin on 21/03/2023.
//

import SwiftUI

struct ErrorView: View {
    
    let error: Error
    
    var body: some View {
        print(error)
        return Text("❌ **Error**").font(.system(size: 30))
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: NetworkError.dataNotFound)
    }
}
