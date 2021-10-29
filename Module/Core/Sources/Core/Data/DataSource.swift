//
//  File.swift
//  
//
//  Created by Dzaky on 28/10/21.
//

import Foundation
import Combine

public protocol DataSource {
    associatedtype Request
    associatedtype Response
   
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
