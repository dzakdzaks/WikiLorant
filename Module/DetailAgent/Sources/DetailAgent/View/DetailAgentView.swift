//
//  File.swift
//  
//
//  Created by Dzaky on 31/10/21.
//

import SwiftUI
import Agent
import Core
import SDWebImageSwiftUI

public struct DetailAgentView: View {
        
    @ObservedObject var presenter : DetailPresenter<
        Interactor<String, AgentModel, GetAgent<GetAgentLocaleDataSource,AgentTransformer>>,
        Interactor<(String, UpdateEnum), Bool, UpdateAgentFavorite<GetAgentLocaleDataSource>>>
        
    @State var gridItemLayout: [GridItem] = [GridItem(.flexible())]

    public init(presenter: DetailPresenter<Interactor<String, AgentModel, GetAgent<GetAgentLocaleDataSource,AgentTransformer>>,
                Interactor<(String, UpdateEnum), Bool, UpdateAgentFavorite<GetAgentLocaleDataSource>>>) {
        self.presenter = presenter
    }
    
    public var body: some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { favoriteButton }
            }
            .navigationTitle(presenter.data?.name ?? "Detail")
            .navigationBarTitleDisplayMode(.inline)
    }
}

extension DetailAgentView {
    
    var content: some View {
        ScrollView {
            VStack(alignment: .leading) {
                WebImage(url: URL(string: presenter.data?.fullImage ?? ""))
                    .resizable()
                    .placeholder(Image(systemName: "person"))
                    .indicator(.activity)
                    .shadow(radius: 10)
                    .transition(.fade(duration: 0.5))
                    .scaledToFill()
                Text(presenter.data?.name ?? "")
                    .font(.title)
                    .bold()
                HStack {
                    ZStack {
                        WebImage(url: URL(string: presenter.data?.role?.icon ?? ""))
                            .resizable()
                            .placeholder(Image(systemName: "person.fill"))
                            .indicator(.activity)
                            .transition(.fade(duration: 0.5))
                            .scaledToFit()
                            .padding(.all, 4)
                    }
                    .frame(width: 40, height: 40)
                    .background(Color.secondary.opacity(0.3))
                    .cornerRadius(30)
                    Text(presenter.data?.role?.name ?? "")
                        .font(.title3)
                }
                Text(presenter.data?.desc ?? "")
                    .font(.body)
                    .padding(
                    EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                LazyVGrid(columns: gridItemLayout, alignment: .center) {
                    ForEach(presenter.data?.abilities ?? [], id: \.id) { ability in
                        AbilityRow(ability: ability)
                    }
                }
            }
            .padding()
        }
    }
    
    var favoriteButton: some View {
        Button(action: {
            if presenter.isAgentFavorite {
                presenter.updateAgentFavorite(id: presenter.data?.id ?? "", action: .remove)
            } else {
                presenter.updateAgentFavorite(id: presenter.data?.id ?? "", action: .add)
            }
        }) {
            if presenter.isAgentFavorite {
                Image(systemName: "star.fill")
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "star")
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
    
}




