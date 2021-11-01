//
//  Router.swift
//  WikiLorant
//
//  Created by Dzaky on 31/10/21.
//

import SwiftUI
import Core
import Agent
import DetailAgent
import Profile

class Router {
    
    let inject = Injection()
    
    func routeToDetail(for agentId: String) -> DetailAgentView {
        let getUseCase: Interactor<String, AgentModel, GetAgent<GetAgentLocaleDataSource, AgentTransformer>> = inject.provideGetDetailAgentLocale()
        let updateUseCase: Interactor<(String, UpdateEnum), Bool, UpdateAgentFavorite<GetAgentLocaleDataSource>> = inject.provideUpdateAgentFavorite()
        
        let presenter: DetailPresenter = DetailPresenter(id: agentId, getDetailUseCase: getUseCase, updateAgentFavoriteUseCase: updateUseCase)
        
        return DetailAgentView(presenter: presenter)
    }
    
    func routeToProfile() -> ProfileView {
        return ProfileView()
    }
}
