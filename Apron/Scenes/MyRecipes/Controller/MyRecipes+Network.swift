//
//  MyRecipes+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

extension MyRecipesViewController {
    
    // MARK: - Network

    func getProfileRecipes() {
        interactor.getProfileRecipes(request: .init())
    }
}
