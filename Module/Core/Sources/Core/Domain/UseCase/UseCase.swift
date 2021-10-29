//
//  File.swift
//  
//
//  Created by Dzaky on 28/10/21.
//

import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request) -> AnyPublisher<Response, Error>
}
