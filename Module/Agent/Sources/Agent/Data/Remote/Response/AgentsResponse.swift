//
//  File.swift
//  
//
//  Created by Dzaky on 28/10/21.
//

import Foundation

public struct AgentsResponse: Decodable {
    let status: Int
    let agents: [AgentResponse]
    private enum CodingKeys: String, CodingKey {
        case status
        case agents = "data"
    }
}

public struct AgentResponse: Decodable {
    let id: String?
    let name: String?
    let desc: String?
    let halfImage: String?
    let fullImage: String?
    let role: RoleResponse?
    let abilities: [AbilityResponse]
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
