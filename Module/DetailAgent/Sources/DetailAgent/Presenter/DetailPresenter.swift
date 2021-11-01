//
//  File.swift
//  
//
//  Created by Dzaky on 31/10/21.
//

import Combine
import Core
import Agent
import Foundation

public class DetailPresenter<
    GetDetailUseCase: UseCase,
    UpdateAgentFavoriteUseCase: UseCase>: ObservableObject
where
GetDetailUseCase.Request == String,
GetDetailUseCase.Response == AgentModel,
UpdateAgentFavoriteUseCase.Request == (String, UpdateEnum),
UpdateAgentFavoriteUseCase.Response == Bool {
    
    private var cancellables: Set<AnyCancellable> = []
  
    private let getDetailUseCase : GetDetailUseCase
    private let updateAgentFavoriteUseCase: UpdateAgentFavoriteUseCase
    
    @Published var data: AgentModel?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var isAgentFavorite: Bool = false
    
    public init(id: String, getDetailUseCase: GetDetailUseCase, updateAgentFavoriteUseCase: UpdateAgentFavoriteUseCase) {
        self.getDetailUseCase = getDetailUseCase
        self.updateAgentFavoriteUseCase = updateAgentFavoriteUseCase
        self.getDetail(id: id)
    }
    
    func getDetail(id: String) {
        isLoading = true
        getDetailUseCase.execute(request: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case.failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case.finished:
                    self.isLoading = false
                }
            }, receiveValue: { data in
                self.data = data
                self.isAgentFavorite = data.isFavorite
            })
            .store(in: &cancellables)
    }
    
    func updateAgentFavorite(id: String, action: UpdateEnum) {
        isLoading = true
        updateAgentFavoriteUseCase.execute(request: (id, action))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case.failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case.finished:
                    self.isLoading = false
                }
            }, receiveValue: { isSuccess in
                if isSuccess {
                    self.getDetail(id: id)
                }
            })
            .store(in: &cancellables)
    }
    
}
