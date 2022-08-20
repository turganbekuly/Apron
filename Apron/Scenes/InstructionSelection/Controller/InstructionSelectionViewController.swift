//
//  InstructionSelectionViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models

protocol InstructionSelectionDisplayLogic: AnyObject {
    
}

final class InstructionSelectionViewController: ViewController {
    
    struct Section {
        enum Section {
            case instructions
        }
        enum Row {
            case image
            case placeholder
            case description
        }
        
        var section: Section
        var rows: [Row]
    }
    
    // MARK: - Properties
    
    let interactor: InstructionSelectionBusinessLogic
    var sections: [Section] = []
    var state: State {
        didSet {
            updateState()
        }
    }

    var selectedImage: UIImage? {
        didSet {
            mainView.reloadTableViewWithoutAnimation()
            replaceImageCell(type: .image)
        }
    }

    var instructionDesc: String? {
        didSet {
            configureSaveButton()
        }
    }

    var delegate: InstructionSelectedProtocol?
    
    // MARK: - Views
    lazy var mainView: InstructionSelectionView = {
        let view = InstructionSelectionView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    private lazy var navigationRightButton: NavigationButton = {
        let button = NavigationButton()
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var backButton = NavigationBackButton()
    
    // MARK: - Init
    init(interactor: InstructionSelectionBusinessLogic, state: State) {
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
        backButton.configure(with: "Добавить шаг")
        backButton.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.backgroundColor = ApronAssets.secondary.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigationRightButton)
        navigationRightButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
    }
    
    private func configureViews() {
        [mainView].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureColors() {
        view.backgroundColor = ApronAssets.secondary.color
    }

    private func configureSaveButton() {
        guard let description = instructionDesc, !description.isEmpty
        else {
            navigationRightButton.isEnabled = false
            return
        }
        navigationRightButton.isEnabled = true
    }

    // MARK: - User actions

    @objc
    private func saveButtonTapped() {
        var instruction = RecipeInstruction()
        instruction.description = instructionDesc
        instruction.image = "selectedImage"
        delegate?.onInstructionSelected(instruction: instruction)
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
