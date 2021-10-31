//
//  ContentView.swift
//  WikiLorant
//
//  Created by Dzaky on 29/10/21.
//

import SwiftUI
import Home
import Favorite
import Profile

enum TabSelection {
    case tab1, tab2, tab3
}

struct ContentView: View {
    var body: some View {
        TabMain()
    }
}

struct TabMain: View {
    
    @State
    private var selection: TabSelection = .tab1
    
    @State
    private var oldselection: TabSelection = .tab1
    
    @State
    private var showSheet: Bool = false
    
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
            
            Image("valo_icon")
                .resizable()
                .shadow(radius: 10)
                .scaledToFit()
                .frame(width: 200, height: 200, alignment: .center)
                .padding()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(TabSelection.tab3)
        }
        .onChange(of: selection) { selected in
            if selected == .tab3 {
                showSheet = true
            } else {
                oldselection = selected
            }
        }
        .sheet(isPresented: $showSheet, onDismiss: {
            showSheet = false
            selection = oldselection
        }) {
            ProfileView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
