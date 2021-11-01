//
//  WikiLorantTests.swift
//  WikiLorantTests
//
//  Created by Dzaky on 29/10/21.
//

import XCTest
import Combine
import Agent
import Core
@testable import WikiLorant

class RemoteDataSourceTest: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        cancellables = []
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetAgentRemoteDataSourceTestSuccess() throws {
        
        let dataSource = GetAgentRemoteMock()
        var dataTest: AgentResponse?
        
        dataSource.execute(request: "")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    break
                case .finished:
                    break
                }
            }, receiveValue: { agent in
                dataTest = agent
            }).store(in: &cancellables)
        
        XCTAssert(dataSource.verify())
        XCTAssertEqual(dataTest?.name ?? "No Data", "Breach")
    }
    
}

extension RemoteDataSourceTest {
    
    class GetAgentRemoteMock: DataSource {
        internal init() {}
        
        typealias Request = Any
        typealias Response = AgentResponse
        
        var functionWasCalled = false
        
        func execute(request: Any?) -> AnyPublisher<AgentResponse, Error> {
            functionWasCalled = true
            return Future<AgentResponse, Error> { completion in
                do {
                    let value = try JSONDecoder().decode(AgentsResponse.self, from: Data(responseJsonData.utf8))
                    completion(.success(value.agents[0]))
                } catch {
                    completion(.failure(URLError.invalidResponse))
                }
                
            }.eraseToAnyPublisher()
            
        }
        
        func verify() -> Bool {
            return functionWasCalled
        }
    }
    
    static var fakeResponse: AgentResponse = AgentResponse(id: "5f8d3a7f-467b-97f3-062c-13acf203c006", name: "Breach", desc: "The bionic Swede Breach fires powerful, targeted kinetic blasts to aggressively clear a path through enemy ground. The damage and disruption he inflicts ensures no fight is ever fair.", halfImage: "https://media.valorant-api.com/agents/5f8d3a7f-467b-97f3-062c-13acf203c006/bustportrait.png", fullImage: "https://media.valorant-api.com/agents/5f8d3a7f-467b-97f3-062c-13acf203c006/fullportrait.png", role: nil, abilities: [])
    
    static var responseJsonData: String = """
    {"status":200,"data":[{"uuid":"5f8d3a7f-467b-97f3-062c-13acf203c006","displayName":"Breach","description":"The bionic Swede Breach fires powerful, targeted kinetic blasts to aggressively clear a path through enemy ground. The damage and disruption he inflicts ensures no fight is ever fair.","developerName":"Breach","characterTags":null,"displayIcon":"https://media.valorant-api.com/agents/5f8d3a7f-467b-97f3-062c-13acf203c006/displayicon.png","displayIconSmall":"https://media.valorant-api.com/agents/5f8d3a7f-467b-97f3-062c-13acf203c006/displayiconsmall.png","bustPortrait":"https://media.valorant-api.com/agents/5f8d3a7f-467b-97f3-062c-13acf203c006/bustportrait.png","fullPortrait":"https://media.valorant-api.com/agents/5f8d3a7f-467b-97f3-062c-13acf203c006/fullportrait.png","killfeedPortrait":"https://media.valorant-api.com/agents/5f8d3a7f-467b-97f3-062c-13acf203c006/killfeedportrait.png","assetPath":"ShooterGame/Content/Characters/Breach/Breach_PrimaryAsset","isFullPortraitRightFacing":false,"isPlayableCharacter":true,"isAvailableForTest":true,"isBaseContent":false,"role":{"uuid":"1b47567f-8f7b-444b-aae3-b0c634622d10","displayName":"Initiator","description":"Initiators challenge angles by setting up their team to enter contested ground and push defenders away.","displayIcon":"https://media.valorant-api.com/agents/roles/1b47567f-8f7b-444b-aae3-b0c634622d10/displayicon.png","assetPath":"ShooterGame/Content/Characters/_Core/Roles/Breaker_PrimaryDataAsset"},"abilities":[{"slot":"Ability1","displayName":"Flashpoint","description":"EQUIP a blinding charge. FIRE the charge to set a fast-acting burst through the wall. The charge detonates to blind all players looking at it.","displayIcon":"https://media.valorant-api.com/agents/5f8d3a7f-467b-97f3-062c-13acf203c006/abilities/ability1/displayicon.png"},{"slot":"Ability2","displayName":"Fault Line","description":"EQUIP a seismic blast. HOLD FIRE to increase the distance. RELEASE to set off the quake, dazing all players in its zone and in a line up to the zone.","displayIcon":"https://media.valorant-api.com/agents/5f8d3a7f-467b-97f3-062c-13acf203c006/abilities/ability2/displayicon.png"},{"slot":"Grenade","displayName":"Aftershock","description":"EQUIP a fusion charge. FIRE the charge to set a slow-acting burst through the wall. The burst does heavy damage to anyone caught in its area.","displayIcon":"https://media.valorant-api.com/agents/5f8d3a7f-467b-97f3-062c-13acf203c006/abilities/grenade/displayicon.png"},{"slot":"Ultimate","displayName":"Rolling Thunder","description":"EQUIP a Seismic Charge. FIRE to send a cascading quake through all terrain in a large cone. The quake dazes and knocks up anyone caught in it.","displayIcon":"https://media.valorant-api.com/agents/5f8d3a7f-467b-97f3-062c-13acf203c006/abilities/ultimate/displayicon.png"}],"voiceLine":{"minDuration":2.456469,"maxDuration":2.456469,"mediaList":[{"id":802792402,"wwise":"https://media.valorant-api.com/sounds/802792402.wem","wave":"https://media.valorant-api.com/sounds/802792402.wav"}]}}]}
    """
    
}
