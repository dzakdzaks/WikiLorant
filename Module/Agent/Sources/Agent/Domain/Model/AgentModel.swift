//
//  File.swift
//  
//
//  Created by Dzaky on 28/10/21.
//

import Foundation

public struct AgentModel: Equatable, Identifiable {
    public let id: String
    public let name: String
    public let desc: String
    public let halfImage: String
    public let fullImage: String
    public let role: RoleModel?
    public let abilities: [AbilityModel]
}

public struct RoleModel: Equatable, Identifiable {
    public let id: String
    public let name: String
    public let desc: String
    public let icon: String
}

public struct AbilityModel: Equatable, Identifiable {
    public let id: String
    public let slot: String
    public let name: String
    public let desc: String
    public let icon: String
}
