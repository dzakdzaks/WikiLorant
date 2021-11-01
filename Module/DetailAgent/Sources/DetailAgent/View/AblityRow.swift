//
//  File.swift
//  
//
//  Created by Dzaky on 01/11/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Agent

struct AbilityRow: View {
    var ability: AbilityModel
    var body: some View {
        VStack {
            image
            content
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.secondary.opacity(0.3))
        .cornerRadius(10)
    }
}
extension AbilityRow {
    var image: some View {
        WebImage(url: URL(string: ability.icon))
            .resizable()
            .placeholder(Image(systemName: "person.fill"))
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 100, height: 100)
            .cornerRadius(10)
            .padding(.top)
    }
    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(ability.name)
                .font(.title3)
                .bold()
            Text(ability.desc)
                .font(.body)
        }.padding(
            EdgeInsets(
                top: 0,
                leading: 16,
                bottom: 16,
                trailing: 16
            )
        )
    }
}
