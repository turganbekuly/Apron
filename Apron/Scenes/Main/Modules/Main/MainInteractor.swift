//
//  MainInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

public protocol MainBusinessLogic {
    
}

public final class MainInteractor: MainBusinessLogic {
    
    // MARK: - Properties
    private let presenter: MainPresentationLogic
    
    // MARK: - Initialization
    public init(presenter: MainPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - MainBusinessLogic

}
