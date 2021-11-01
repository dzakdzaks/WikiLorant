//
//  File.swift
//  
//
//  Created by Dzaky on 28/10/21.
//

import Combine

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
   
    func list(request: Request) -> AnyPublisher<[Response], Error>
    func addList(entities: [Response]) -> AnyPublisher<Bool, Error>
    func get(id: String) -> AnyPublisher<Response, Error>
    func isFavorite(id: String) -> AnyPublisher<Bool, Error>
    func update(request: (String, UpdateEnum)) -> AnyPublisher<Bool, Error>
}
