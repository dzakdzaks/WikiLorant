//
//  Injection.swift
//  WikiLorant
//
//  Created by Dzaky on 29/10/21.
//

import Foundation
import Core
import RealmSwift
import Agent

final class Injection: NSObject {
    
    let realm: Realm
    
    override init() {
        self.realm = try! Realm()
    }
    
    func provideGetAgent<U: UseCase>() -> U
    where U.Request == (AgentEnum, String), U.Response == [AgentModel] {
        let locale = GetAgentLocaleDataSource(realm: realm)
        let remote = GetAgentRemoteDataSource()
        let mapper = AgentListTransformer()
        
        let repository = GetListAgent(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideGetAgentLocale<U: UseCase>() -> U
    where U.Request == (AgentEnum, String), U.Response == [AgentModel] {
        let locale = GetAgentLocaleDataSource(realm: realm)
        let mapper = AgentListTransformerLocale()
        
        let repository = GetListAgentLocale(
            localeDataSource: locale,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
}
