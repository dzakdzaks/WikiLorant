//
//  File.swift
//  
//
//  Created by Dzaky on 28/10/21.
//

import Foundation
import RealmSwift

public class AgentEntity: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var halfImage: String = ""
    @objc dynamic var fullImage: String = ""
    @objc dynamic var role: RoleEntity?
    @objc dynamic var isFavorite: Bool = false
    var abilities = List<AbilityEntity>()
    
    public override class func primaryKey() -> String? {
        return "id"
    }
}

public class RoleEntity: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var desc = ""
    @objc dynamic var icon = ""
    let agent = LinkingObjects(fromType: AgentEntity.self, property: "role")

    public override class func primaryKey() -> String? {
        return "id"
    }
}

public class AbilityEntity: Object {
    // other props
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var slot = ""
    @objc dynamic var name = ""
    @objc dynamic var desc = ""
    @objc dynamic var icon = ""
    let agent = LinkingObjects(fromType: AgentEntity.self, property: "abilities")

    public override static func primaryKey() -> String? {
        return "id"
    }
}
