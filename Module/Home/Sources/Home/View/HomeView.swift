//
//  File.swift
//  
//
//  Created by Dzaky on 29/10/21.
//

import SwiftUI
import Core
import Agent

public struct HomeView<DetailRoute: View>: View {
    
    @EnvironmentObject
    var presenter: GetListPresenter<
        (AgentEnum, String), AgentModel, Interactor<(AgentEnum, String), [AgentModel], GetListAgent<GetAgentLocaleDataSource, GetAgentRemoteDataSource, AgentListTransformer>>>
    
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
                                            Text("There is no agent here")
                                        } else {
                                            Text("There is no agent with key '\(searchKey)'")
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
            .navigationTitle("Home")
            .navigationBarSearch($searchKey, placeholder: "Search Agent", hidesSearchBarWhenScrolling: false, onTextChange: { result in
                presenter.getList(request: (AgentEnum.all, result))
            }, cancelClicked: {
                presenter.getList(request: (AgentEnum.all, ""))
            })
        }.onAppear {
            if (presenter.list.isEmpty) {
                presenter.getList(request: (AgentEnum.all, searchKey))
            }
        }
    }
    
}
