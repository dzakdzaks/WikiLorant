//
//  File.swift
//  
//
//  Created by Dzaky on 29/10/21.
//

import SwiftUI
import Core
import Agent

public struct HomeView: View {
    
    @EnvironmentObject
    var presenter: GetListPresenter<
        (AgentEnum, String), AgentModel, Interactor<(AgentEnum, String), [AgentModel], GetListAgent<GetAgentLocaleDataSource, GetAgentRemoteDataSource, AgentListTransformer>>>
    
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
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack {
                            if presenter.list.isEmpty {
                                Spacer()
                                Text(presenter.errorMessage)
                            } else {
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
            .navigationTitle("Home")
            .navigationBarSearch($searchKey, hidesSearchBarWhenScrolling: false, onTextChange: { result in
                presenter.getList(request: (AgentEnum.all, result))
            }, cancelClicked: {
                presenter.getList(request: (AgentEnum.all, ""))
            })
        }.onAppear {
            presenter.getList(request: (AgentEnum.all, ""))
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
