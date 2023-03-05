//
//  IngredientInsertionViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit

protocol IngredientInsertionDisplayLogic: AnyObject {

}

final class IngredientInsertionViewController: ViewController {

    struct Section {
        enum Section {

        }
        enum Row {

        }

        let section: Section
        let rows: [Row]
    }

    // MARK: - Properties
    let interactor: IngredientInsertionBusinessLogic
    var sections: [Section] = []
    var state: State {
        didSet {
            updateState()
        }
    }

    weak var delegate: RecipeCreationAddIngredientCellProtocol?

    // MARK: - Views

    // MARK: - Init
    init(interactor: IngredientInsertionBusinessLogic, state: State) {
        self.interactor = interactor
        self.state = state

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()

        configureViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        state = { state }()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureNavigation()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods
    private func configureNavigation() {
        navigationItem.title = ""
    }

    private func configureViews() {
        [].forEach { view.addSubview($0) }

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
    }

    private func configureColors() {

    }

    deinit {
        NSLog("deinit \(self)")
    }

}
