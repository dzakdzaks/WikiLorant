//
//  File.swift
//  
//
//  Created by Dzaky on 30/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

public struct ProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode

    public init() {  }
    
    public var body: some View {
        
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                }
                Spacer()
                Text("Profile")
                    .font(.title3)
                    .bold()
                Spacer()
            }.padding()
            VStack() {
                WebImage(url: URL(string: "https://dzakdzaks.github.io/images/pp.jpg"))
                    .resizable()
                    .placeholder(Image(systemName: "person.fill"))
                    .indicator(.activity)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: .center)
                    .padding()
                Text("Muhammad Dzaky Rahmanto")
                Link("Thanks to Valorant API Community", destination: URL(string: "https://valorant-api.com/")!)
                    .padding()
            }.padding()
            Spacer()
        }
        
    }
    
}

struct ProfileView_Preview: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
