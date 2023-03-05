//
//  ProfilePresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol ProfilePresentationLogic: AnyObject {
    func getProfile(response: ProfileDataFlow.GetProfile.Response)
    func deleteAccount(response: ProfileDataFlow.DeleteAccount.Response)
}

final class ProfilePresenter: ProfilePresentationLogic {

    // MARK: - Properties
    weak var viewController: ProfileDisplayLogic?

    // MARK: - ProfilePresentationLogic

    func getProfile(response: ProfileDataFlow.GetProfile.Response) {
        DispatchQueue.main.async {
            var viewModel: ProfileDataFlow.GetProfile.ViewModel

            defer { self.viewController?.displayProfile(with: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .fetchProfile(model))
            case let .failed(error):
                viewModel = .init(state: .fetchProfileFailed(error))
            }
        }
    }

    func deleteAccount(response: ProfileDataFlow.DeleteAccount.Response) {
        DispatchQueue.main.async {
            var viewModel: ProfileDataFlow.DeleteAccount.ViewModel

            defer { self.viewController?.displayDeleteAccount(with: viewModel) }

            switch response.result {
            case .successful:
                viewModel = .init(state: .deleteAccount)
            case .failed:
                viewModel = .init(state: .deleteAccountFailed)
            }
        }
    }
}
