//
//  TasteOnboardingInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

public protocol TasteOnboardingBusinessLogic {

}

public final class TasteOnboardingInteractor: TasteOnboardingBusinessLogic {

    // MARK: - Properties
    private let presenter: TasteOnboardingPresentationLogic
    private let provider: TasteOnboardingProviderProtocol

    // MARK: - Initialization
    public init(presenter: TasteOnboardingPresentationLogic,
         provider: TasteOnboardingProviderProtocol = TasteOnboardingProvider()) {
        self.presenter = presenter
        self.provider = provider
    }

    // MARK: - TasteOnboardingBusinessLogic

}
