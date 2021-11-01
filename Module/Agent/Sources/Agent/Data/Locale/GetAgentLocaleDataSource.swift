//
//  File.swift
//  
//
//  Created by Dzaky on 28/10/21.
//

import Foundation
import RealmSwift
import Core
import Combine

public struct GetAgentLocaleDataSource: LocaleDataSource {
    
    public typealias Request = (AgentEnum, String)
    public typealias Response = AgentEntity
    
    private let _realm: Realm
    
    public init (realm: Realm) {
        self._realm = realm
    }
    
    public func list(request: (AgentEnum, String)) -> AnyPublisher<[AgentEntity], Error> {
        return Future<[AgentEntity], Error> { completion in
            let agents: Results<AgentEntity> = {
                switch request.0 {
                case .favorite:
                    if request.1.isEmpty {
                        return self._realm.objects(AgentEntity.self)
                            .filter("isFavorite == true")
                            .sorted(byKeyPath: "name", ascending: true)
                    } else {
                        return self._realm.objects(AgentEntity.self)
                            .filter("isFavorite == true && name CONTAINS [c] '\(request.1)'")
                            .sorted(byKeyPath: "name", ascending: true)
                    }
                    
                case .unfavorite:
                    if request.1.isEmpty {
                        return self._realm.objects(AgentEntity.self)
                            .filter("isFavorite == false")
                            .sorted(byKeyPath: "name", ascending: true)
                    } else {
                        return self._realm.objects(AgentEntity.self)
                            .filter("isFavorite == false && name CONTAINS [c] '\(request.1)'")
                            .sorted(byKeyPath: "name", ascending: true)
                    }
                case .all:
                    if request.1.isEmpty {
                        return self._realm.objects(AgentEntity.self)
                            .sorted(byKeyPath: "name", ascending: true)
                    } else {
                        return self._realm.objects(AgentEntity.self)
                            .filter("name CONTAINS [c] '\(request.1)'")
                            .sorted(byKeyPath: "name", ascending: true)
                    }
                }
            }()
            completion(.success(agents.toArray(ofType: AgentEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    public func addList(entities: [AgentEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try self._realm.write {
                    for agent in entities {
                        self._realm.add(agent, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func get(id: String) -> AnyPublisher<AgentEntity, Error> {
        return Future<AgentEntity, Error> { completion in
            let agent = {
                self._realm.object(ofType: AgentEntity.self, forPrimaryKey: id)
            }()
            if agent != nil {
                completion(.success(agent!))
            } else {
                completion(.failure(DatabaseError.empty))
            }
        }.eraseToAnyPublisher()
    }
    
    public func isFavorite(id: String) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            let isAgentFavorite = {
                self._realm.object(ofType: AgentEntity.self, forPrimaryKey: id)?.isFavorite ?? false
            }()
            if isAgentFavorite {
                completion(.success(true))
            } else {
                completion(.success(false))
            }
        }.eraseToAnyPublisher()
    }
    
    public func update(request: (String, UpdateEnum)) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            let agent = self._realm.object(ofType: AgentEntity.self, forPrimaryKey: request.0)
            do {
                try self._realm.write {
                    switch request.1 {
                    case .add:
                        agent?.isFavorite = true
                    case .remove:
                        agent?.isFavorite = false
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
}
