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
    
    @State private var scrollViewContentOffset: CGFloat = .zero
    
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
        GeometryReader { geo in
            ScrollViewOffset(onOffsetChange: {
                scrollViewContentOffset = $0
            }) {
                VStack {
                    WebImage(url: URL(string: presenter.data?.fullImage ?? ""))
                        .resizable()
                        .placeholder(Image(systemName: "person"))
                        .indicator(.activity)
                        .shadow(radius: 10)
                        .transition(.fade(duration: 0.5))
                        .frame(width: geo.size.width, height: scrollViewContentOffset <= 0 ? 400 : 400 + scrollViewContentOffset, alignment: .center)
                }
            }
        }
        .edgesIgnoringSafeArea(.horizontal)
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




