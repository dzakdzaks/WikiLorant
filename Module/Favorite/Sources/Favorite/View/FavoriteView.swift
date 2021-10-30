//
//  File.swift
//  
//
//  Created by Dzaky on 29/10/21.
//

import SwiftUI
import Core
import Agent

public struct FavoriteView: View {
    
    @EnvironmentObject
    var presenter: GetListPresenter<
        (AgentEnum, String), AgentModel, Interactor<(AgentEnum, String), [AgentModel], GetListAgentLocale<GetAgentLocaleDataSource, AgentListTransformerLocale>>>
    
    @State
    var searchKey = ""
    
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            ZStack {
                if presenter.isLoading {
                    VStack {
                        Text("Loading...")
                        ProgressView()
                    }
                } else {
                    VStack {
                        if presenter.list.isEmpty {
                            GeometryReader { geometry in
                                ScrollView {
                                    VStack {
                                        Spacer()
                                        if searchKey.isEmpty {
                                            Text("There is no favorite agent here")
                                        } else {
                                            Text("There is no favorite agent with key '\(searchKey)'")
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                    .frame(width: geometry.size.width)
                                    .frame(minHeight: geometry.size.height)
                                }
                            }
                        } else {
                            ScrollView(.vertical, showsIndicators: true) {
                                LazyVGrid(columns: gridItemLayout) {
                                    ForEach(presenter.list, id: \.id) { agent in
                                        ZStack {
                                            AgentRow(agent: agent)
                                        }.padding(8)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorite")
            .navigationBarSearch($searchKey, placeholder: "Search Favorite Agent", hidesSearchBarWhenScrolling: false, onTextChange: { result in
                presenter.getList(request: (AgentEnum.favorite, result))
            }, cancelClicked: {
                presenter.getList(request: (AgentEnum.favorite, ""))
            })
        }.onAppear {
            presenter.getList(request: (AgentEnum.favorite, searchKey))
        }
    }
    
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
