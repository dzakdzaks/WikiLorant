//
//  File.swift
//  
//
//  Created by Dzaky on 28/10/21.
//

import Foundation

public struct AgentsResponse: Decodable {
    public let status: Int
    public let agents: [AgentResponse]
    private enum CodingKeys: String, CodingKey {
        case status
        case agents = "data"
    }
}

public struct AgentResponse: Decodable {
    public let id: String?
    public let name: String?
    public let desc: String?
    public let halfImage: String?
    public let fullImage: String?
    public let role: RoleResponse?
    public let abilities: [AbilityResponse]
    
    public init(id: String, name: String, desc: String,
                halfImage: String, fullImage: String,
                role: RoleResponse?, abilities: [AbilityResponse]?) {
        self.id = id
        self.name = name
        self.desc = desc
        self.halfImage = halfImage
        self.fullImage = fullImage
        self.role = role
        self.abilities = abilities ?? []
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name = "displayName"
        case desc = "description"
        case halfImage = "bustPortrait"
        case fullImage = "fullPortrait"
        case role
        case abilities
    }
}

public struct RoleResponse: Decodable {
    let id: String?
    let name: String?
    let desc: String?
    let icon: String?
    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name = "displayName"
        case desc = "description"
        case icon = "displayIcon"
    }
}

public struct AbilityResponse: Decodable {
    let slot: String?
    let name: String?
    let desc: String?
    let icon: String?
    private enum CodingKeys: String, CodingKey {
        case slot
        case name = "displayName"
        case desc = "description"
        case icon = "displayIcon"
    }
}
