//
//  MainInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import Models

protocol MainBusinessLogic {
    func getCookNowRecipes(request: MainDataFlow.GetCookNowRecipes.Request)
    func getEventRecipes(request: MainDataFlow.GetEventRecipes.Request)
    func saveRecipe(request: MainDataFlow.SaveRecipe.Request)
    func getCommunitiesById(communityIds: [Int])
    func getProductsByIds(request: MainDataFlow.GetProductsByIDs.Request)
}

final class MainInteractor: MainBusinessLogic {

    // MARK: - Properties
    private let presenter: MainPresentationLogic
    private let provider: MainProviderProtocol
    private let group = DispatchGroup()
    private var communities: [CommunityResponse] = []

    // MARK: - Initialization
    init(
        presenter: MainPresentationLogic,
        provider: MainProviderProtocol = MainProvider()
    ) {
        self.presenter = presenter
        self.provider = provider
    }

    // MARK: - MainBusinessLogic

    func getCookNowRecipes(request: MainDataFlow.GetCookNowRecipes.Request) {
        provider.getCookNowRecipes(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.getCookNowRecipes(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.getCookNowRecipes(response: .init(result: .failed(error: error)))
            }
        }
    }

    func getEventRecipes(request: MainDataFlow.GetEventRecipes.Request) {
        provider.getEventRecipes(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.getEventRecipes(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.getEventRecipes(response: .init(result: .failed(error: error)))
            }
        }
    }

    func saveRecipe(request: MainDataFlow.SaveRecipe.Request) {
        provider.saveRecipe(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.saveRecipe(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.saveRecipe(response: .init(result: .failed(error: error)))
            }
        }
    }
    
    func getCommunitiesById(communityIds: [Int]) {
        communityIds.forEach { id in
            group.enter()
            provider.getCommunity(request: .init(id: id)) { [weak self] in
                switch $0 {
                case let .successful(model):
                    self?.communities.append(model)
                case .failed:
                    break
                }
                self?.group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.presenter.getCommunitiesById(communities: self.communities)
        }
    }

    func getProductsByIds(request: MainDataFlow.GetProductsByIDs.Request) {
        provider.getProductsByIds(request: request) { [weak self] in
            switch $0 {
            case let .success(model: model):
                self?.presenter.getProductsByIds(response: .init(result: .success(model: model)))
            case let .error(error):
                self?.presenter.getProductsByIds(response: .init(result: .error(error: error)))
            }
        }
    }
}
