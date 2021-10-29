//
//  File.swift
//  
//
//  Created by Dzaky on 28/10/21.
//

import Core
import Combine

public struct GetListAgent<Locale: LocaleDataSource,
                           Remote: DataSource, Transformer: Mapper>: Repository
where
Locale.Request == (AgentEnum, String),
Locale.Response == AgentEntity,
Remote.Response == [AgentResponse],
Transformer.Response == [AgentResponse],
Transformer.Entity == [AgentEntity],
Transformer.Domain == [AgentModel] {
    
    public typealias Request = (AgentEnum, String)
    public typealias Response = [AgentModel]
    
    private let locale: Locale
    private let remote: Remote
    private let _mapper: Transformer
    
    public init(localeDataSource: Locale,
                remoteDataSource: Remote,
                mapper: Transformer) {
        
        self.locale = localeDataSource
        self.remote = remoteDataSource
        self._mapper = mapper
        
    }
    
    public func execute(request: (AgentEnum, String)) -> AnyPublisher<[AgentModel], Error> {
        return self.locale.list(request: request)
            .flatMap { result -> AnyPublisher<[AgentModel], Error> in
                if result.isEmpty {
                    return self.remote.execute(request: nil)
                        .map { self._mapper.transformResponseToEntity(response: $0) }
                        .catch { _ in self.locale.list(request: request) }
                        .flatMap { self.locale.addList(entities: $0) }
                        .filter { $0 }
                        .flatMap { _ in
                            self.locale.list(request: request)
                                .map { self._mapper.transformEntityToDomain(entity: $0) }
                        }.eraseToAnyPublisher()
                } else {
                    return self.locale.list(request: request)
                        .map { self._mapper.transformEntityToDomain(entity: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
}

public struct GetAgent<Locale: LocaleDataSource, Transformer: EntityToDomainMapper>: Repository
where Locale.Request == String,
      Locale.Response == AgentEntity,
      Transformer.Entity == AgentEntity,
      Transformer.Domain == AgentModel {
    
    public typealias Request = String
    public typealias Response = AgentModel
    
    private let locale: Locale
    private let _mapper: Transformer
    
    public init(localeDataSource: Locale,
                mapper: Transformer) {
        
        self.locale = localeDataSource
        self._mapper = mapper
        
    }
    
    public func execute(request: String) -> AnyPublisher<AgentModel, Error> {
        return self.locale.get(id: request)
            .map { self._mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}

public struct IsAgentFavorite<Locale: LocaleDataSource>: Repository
where Locale.Request == String,
      Locale.Response == Bool {
    
    public typealias Request = String
    public typealias Response = Bool
    
    private let locale: Locale
    
    public init(locale: Locale) {
        self.locale = locale
    }
    
    public func execute(request: String) -> AnyPublisher<Bool, Error> {
        return self.locale.isFavorite(id: request)
            .eraseToAnyPublisher()
    }
}

public struct UpdateAgentFavorite<Locale: LocaleDataSource>: Repository
where Locale.Request == (String, String),
      Locale.Response == Bool {
    
    public typealias Request = (String, String)
    public typealias Response = Bool
    
    private let locale: Locale
    
    public init(locale: Locale) {
        self.locale = locale
    }
    
    public func execute(request: (String, String)) -> AnyPublisher<Bool, Error> {
        return self.locale.update(request: request)
            .eraseToAnyPublisher()
    }
}
