//
//  File.swift
//  
//
//  Created by Dzaky on 29/10/21.
//

import SwiftUI
import Core
import Agent

public struct FavoriteView<DetailRoute: View>: View {
    
    @EnvironmentObject
    var presenter: GetListPresenter<
        (AgentEnum, String), AgentModel, Interactor<(AgentEnum, String), [AgentModel], GetListAgentLocale<GetAgentLocaleDataSource, AgentListTransformerLocale>>>
    
    @State
    var searchKey = ""
    
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    let detailRoute: ((_ id: String) -> DetailRoute)
    
    public init(detailRoute: @escaping ((String) -> DetailRoute)) {
        self.detailRoute = detailRoute
    }
    
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
                                            NavigationLink(destination: self.detailRoute(agent.id)) {
                                                AgentRow(agent: agent)
                                            }.buttonStyle(PlainButtonStyle())
                                        }.padding(8)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { refreshButton }
            }
            .navigationTitle("Favorite")
            .navigationBarSearch($searchKey, placeholder: "Search Favorite Agent", hidesSearchBarWhenScrolling: false, onTextChange: { result in
                presenter.getList(request: (AgentEnum.favorite, result))
            }, cancelClicked: {
                presenter.getList(request: (AgentEnum.favorite, ""))
            })
        }.onAppear {
            presenter.checkIfThereAnyNewData(request: (AgentEnum.favorite, searchKey))
        }
    }
    
}

extension FavoriteView {
    
    var refreshButton: some View {
        Button(action: {
            presenter.checkIfThereAnyNewData(request: (AgentEnum.favorite, searchKey))
        }) {
            Image(systemName: "arrow.clockwise")
                .aspectRatio(contentMode: .fit)
        }
    }
    
    var deleteButton: some View {
        Button(action: {
            
        }) {
            Image(systemName: "trash.fill")
                .aspectRatio(contentMode: .fit)
        }
    }
    
}
