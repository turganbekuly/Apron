//
//  CategorySelectionProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork
import Models

protocol CategorySelectionProviderProtocol {
    func getCategories(
        request: CategorySelectionDataFlow.GetCategories.Request,
        completion: @escaping ((CategorySelectionDataFlow.GetCategoriesResult) -> Void)
    )
}

final class CategorySelectionProvider: CategorySelectionProviderProtocol {

    // MARK: - Properties
    private let service: CategorySelectionServiceProtocol

    // MARK: - Init
    init(service: CategorySelectionServiceProtocol =
                    CategorySelectionService(provider: AKNetworkProvider<CategorySelectionEndpoint>())) {
        self.service = service
    }

    // MARK: - CategorySelectionProviderProtocol

    func getCategories(
        request: CategorySelectionDataFlow.GetCategories.Request,
        completion: @escaping ((CategorySelectionDataFlow.GetCategoriesResult) -> Void)
    ) {
        service.getCategories(request: request) {
            switch $0 {
            case let .success(json):
                if let jsons = json["data"] as? [JSON] {
                    completion(.successful(
                        model: jsons
                            .compactMap { CommunityCategory(json: $0) })
                    )
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }
}
