//
//  ProfileInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol ProfileBusinessLogic {
    func getProfile(request: ProfileDataFlow.GetProfile.Request)
}

final class ProfileInteractor: ProfileBusinessLogic {
    
    // MARK: - Properties
    private let presenter: ProfilePresentationLogic
    private let provider: ProfileProviderProtocol
    
    // MARK: - Initialization
    init(presenter: ProfilePresentationLogic,
         provider: ProfileProviderProtocol = ProfileProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - ProfileBusinessLogic

    func getProfile(request: ProfileDataFlow.GetProfile.Request) {
        provider.getProfile(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.getProfile(response: .init(result: .successful(model)))
            case let .failed(error):
                self?.presenter.getProfile(response: .init(result: .failed(error)))
            }
        }
    }
}
