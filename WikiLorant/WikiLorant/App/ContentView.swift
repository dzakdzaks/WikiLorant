//
//  ContentView.swift
//  WikiLorant
//
//  Created by Dzaky on 29/10/21.
//

import SwiftUI
import Home
import Favorite

enum TabSelection {
    case tab1, tab2, tab3
}

struct ContentView: View {
    var body: some View {
        TabMain()
    }
}

struct TabMain: View {
    
    @State private var selection: TabSelection = .tab1

    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(TabSelection.tab1)
            FavoriteView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorite")
                }
                .tag(TabSelection.tab2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
