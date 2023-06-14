//
//  AdviceManager.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 17.02.2023.
//

import Foundation
import Alamofire
import Combine


class AdviceManager: ObservableObject{
    
    enum State {
        case none
        case loading
        case loaded
    }
    
    static let shared: AdviceManager = {
        AdviceManager(adviceService: AdviceServiceImp())
    }()
    
    @Published var state: State = .none
    @Published var advice: MAdvice?
    @Published var activated: Bool = true
    
    private let adviceService: AdviceService
    private var cancellables: [AnyCancellable] = []
    
    init(adviceService: AdviceService) {
        self.adviceService = adviceService
    }
    
    func loadAdvices() {
        adviceService
            .getAdvices(model: MAdvice.self)
            .filter { [weak self] recievedValue in self?.state != .loaded }
            .print("Advice")
            .sink { [weak self] recievedValue in
                guard let self = self else { return }
                if recievedValue != nil {
                    self.advice = recievedValue
                    self.state = .loaded
                } else {
                    self.state = .loading
                }
            }
            .store(in: &cancellables)
    }
    
    func toggleAdvice() {
        activated.toggle()
        state = .none
    }
}
