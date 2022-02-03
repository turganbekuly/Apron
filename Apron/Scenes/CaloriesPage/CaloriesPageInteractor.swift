//
//  CaloriesPageInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol CaloriesPageBusinessLogic {
    
}

final class CaloriesPageInteractor: CaloriesPageBusinessLogic {
    
    // MARK: - Properties
    private let presenter: CaloriesPagePresentationLogic
    private let provider: CaloriesPageProviderProtocol
    
    // MARK: - Initialization
    init(presenter: CaloriesPagePresentationLogic,
         provider: CaloriesPageProviderProtocol = CaloriesPageProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - CaloriesPageBusinessLogic

}
