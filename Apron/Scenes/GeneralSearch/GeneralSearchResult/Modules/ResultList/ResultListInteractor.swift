//
//  ResultListInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol ResultListBusinessLogic {
    
}

final class ResultListInteractor: ResultListBusinessLogic {
    
    // MARK: - Properties
    private let presenter: ResultListPresentationLogic
    private let provider: ResultListProviderProtocol
    
    // MARK: - Initialization
    init(presenter: ResultListPresentationLogic,
         provider: ResultListProviderProtocol = ResultListProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - ResultListBusinessLogic

}
