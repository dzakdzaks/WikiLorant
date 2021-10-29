//
//  File.swift
//  
//
//  Created by Dzaky on 28/10/21.
//

import Foundation

public protocol EntityToDomainMapper {
    associatedtype Entity
    associatedtype Domain
    
    func transformEntityToDomain(entity: Entity) -> Domain
}
