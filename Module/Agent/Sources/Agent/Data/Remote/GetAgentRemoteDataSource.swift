//
//  File.swift
//  
//
//  Created by Dzaky on 28/10/21.
//

import Foundation
import Alamofire
import Combine
import Core

public struct GetAgentRemoteDataSource: DataSource {
    
    public typealias Request = Any
    public typealias Response = [AgentResponse]
    
    public init() { }
    
    public func execute(request: Any?) -> AnyPublisher<[AgentResponse], Error> {
        return Future<[AgentResponse], Error> { completion in
            if let url = URL(string: "https://valorant-api.com/v1/agents") {
                AF.request(url, parameters: ["isPlayableCharacter": "true"])
                    .validate()
                    .responseDecodable(of: AgentsResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.agents))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
}
