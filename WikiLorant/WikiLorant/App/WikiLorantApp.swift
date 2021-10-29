//
//  WikiLorantApp.swift
//  WikiLorant
//
//  Created by Dzaky on 29/10/21.
//

import SwiftUI
import Core
import Agent

@main
struct WikilorantApp: App {
    
    var body: some Scene {
        let injection = Injection()
        
        let getAgentUseCase: Interactor<(AgentEnum, String), [AgentModel], GetListAgent<GetAgentLocaleDataSource, GetAgentRemoteDataSource, AgentListTransformer>> = injection.provideGetAgent()
        
        let getAgentPresenter = GetListPresenter(useCase: getAgentUseCase)
        
        WindowGroup {
            ContentView()
                .environmentObject(getAgentPresenter)
        }
    }
}

