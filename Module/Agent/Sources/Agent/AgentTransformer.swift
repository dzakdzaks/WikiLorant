//
//  File.swift
//  
//
//  Created by Dzaky on 28/10/21.
//

import Core

public struct AgentListTransformer: Mapper {
    
    public typealias Response = [AgentResponse]
    public typealias Entity = [AgentEntity]
    public typealias Domain = [AgentModel]
    
    public init() { }
    
    public func transformResponseToEntity(response: [AgentResponse]) -> [AgentEntity] {
        return response.map { result in
            let roleEntity = RoleEntity()
            roleEntity.id = result.role?.id ?? ""
            roleEntity.name = result.role?.name ?? ""
            roleEntity.desc = result.role?.desc ?? ""
            roleEntity.icon = result.role?.icon ?? ""
            let agentEntity = AgentEntity()
            agentEntity.id = result.id ?? ""
            agentEntity.name = result.name ?? ""
            agentEntity.desc = result.desc ?? ""
            agentEntity.halfImage = result.halfImage ?? ""
            agentEntity.fullImage = result.fullImage ?? ""
            agentEntity.role = roleEntity
            for element in result.abilities {
                let abilityEntity = AbilityEntity()
                abilityEntity.slot = element.slot ?? ""
                abilityEntity.name = element.name ?? ""
                abilityEntity.desc = element.desc ?? ""
                abilityEntity.icon = element.icon ?? ""
                agentEntity.abilities.append(abilityEntity)
            }
            return agentEntity
        }
    }
    
    public func transformEntityToDomain(entity: [AgentEntity]) -> [AgentModel] {
        return entity.map { result in
            let roleModel = RoleModel(id: result.role?.id ?? "",
                                      name: result.role?.name ?? "",
                                      desc: result.role?.desc ?? "",
                                      icon: result.role?.icon ?? "")
            var abilitiesModel: [AbilityModel] = []
            for element in result.abilities {
                let abilityModel = AbilityModel(id: element.id,
                                                slot: element.slot,
                                                name: element.name,
                                                desc: element.desc,
                                                icon: element.icon)
                abilitiesModel.append(abilityModel)
            }
            return AgentModel(id: result.id,
                              name: result.name,
                              desc: result.desc,
                              halfImage: result.halfImage,
                              fullImage: result.fullImage,
                              role: roleModel,
                              abilities: abilitiesModel)
        }
    }
    
}

public struct AgentTransformer: EntityToDomainMapper {
    
    public typealias Entity = AgentEntity
    public typealias Domain = AgentModel
    
    public init() { }
    
    public func transformEntityToDomain(entity: AgentEntity) -> AgentModel {
        let roleModel = RoleModel(id: entity.role?.id ?? "",
                                  name: entity.role?.name ?? "",
                                  desc: entity.role?.desc ?? "",
                                  icon: entity.role?.icon ?? "")
        var abilitiesModel: [AbilityModel] = []
        for element in entity.abilities {
            let abilityModel = AbilityModel(id: element.id,
                                            slot: element.slot,
                                            name: element.name,
                                            desc: element.desc,
                                            icon: element.icon)
            abilitiesModel.append(abilityModel)
        }
        
        return AgentModel(id: entity.id,
                          name: entity.name,
                          desc: entity.desc,
                          halfImage: entity.halfImage,
                          fullImage: entity.fullImage,
                          role: roleModel,
                          abilities: abilitiesModel)
    }
    
}
