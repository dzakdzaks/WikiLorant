//
//  File.swift
//  
//
//  Created by Dzaky on 29/10/21.
//

import Foundation

import SwiftUI
import Core

public struct FavoriteView: View {
    
    @State
    var searchText = ""
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Favorite")
                }
            }
            .navigationTitle("Favorite Agent")
            .navigationBarSearch($searchText)
        }
    }
    
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
