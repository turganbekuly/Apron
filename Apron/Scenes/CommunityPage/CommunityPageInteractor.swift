//
//  CommunityPageInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

public protocol CommunityPageBusinessLogic {
    
}

public final class CommunityPageInteractor: CommunityPageBusinessLogic {
    
    // MARK: - Properties
    private let presenter: CommunityPagePresentationLogic
    private let provider: CommunityPageProviderProtocol
    
    // MARK: - Initialization
    public init(presenter: CommunityPagePresentationLogic,
         provider: CommunityPageProviderProtocol = CommunityPageProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - CommunityPageBusinessLogic

}
