//
//  CategorySelectionService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol CategorySelectionServiceProtocol {
    func getCategories(
        request: CategorySelectionDataFlow.GetCategories.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class CategorySelectionService: CategorySelectionServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<CategorySelectionEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<CategorySelectionEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - CategorySelectionServiceProtocol

    func getCategories(
        request: CategorySelectionDataFlow.GetCategories.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getCategories) { result in
            completion(result)
        }
    }
}
