//
//  SearchResultBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14.01.2022.
//

import Protocols
import UIKit

public final class SearchResultBuilder {

    // MARK: Properties

    private let state: SearchResultViewController.State

    // MARK: Initialization

    public init(state: SearchResultViewController.State) {
        self.state = state
    }

    // MARK: - ModuleBuilder

    public func build() -> UIViewController {
        let viewController = SearchResultViewController(state: state)
        return viewController
    }

}

