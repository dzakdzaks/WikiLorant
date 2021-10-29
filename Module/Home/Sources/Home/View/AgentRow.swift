//
//  File.swift
//  
//
//  Created by Dzaky on 29/10/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Agent

struct AgentRow: View {
    var agent: AgentModel
    var body: some View {
        VStack {
            imageAgent
            content
        }
        .background(Color.secondary.opacity(0.3))
        .cornerRadius(10)
    }
}

extension AgentRow {
    var imageAgent: some View {
        ZStack {
            WebImage(url: URL(string: agent.role?.icon ?? ""))
                .resizable()
                .placeholder(Image(systemName: "person.fill"))
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .padding()
            WebImage(url: URL(string: agent.halfImage))
                .resizable()
                .placeholder(Image(systemName: "person.fill"))
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 150)
                .cornerRadius(10)
                .padding(.top)
        }
    }
    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(agent.name)
                .font(.title)
                .bold()
            Text(agent.desc)
                .font(.system(size: 14))
                .lineLimit(2)
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
