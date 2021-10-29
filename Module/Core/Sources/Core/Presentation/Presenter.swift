//
//  File.swift
//  
//
//  Created by Dzaky on 28/10/21.
//

import Foundation
import Combine

public class Presenter<Request, Response, Interactor: UseCase>: ObservableObject
where Interactor.Request == Request, Interactor.Response == Response {
    
    private var cancellables: Set<AnyCancellable> = []

    @Published public var data: Response?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    private let _useCase: Interactor

    public init(useCase: Interactor) {
        self._useCase = useCase
    }
    
    public func get(request: Request) {
        isLoading = true
        _useCase.execute(request: request)
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
            })
            .store(in: &cancellables)
    }
}
