//
//  InstructionSelectionViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit

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

    private lazy var saveButton: BlackOpButton = {
        let button = BlackOpButton(arrowState: .none, frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавить рецепт"
        label.font = TypographyFonts.semibold20
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(
            ApronAssets.navBackButton.image
                .withTintColor(.black),
            for: .normal
        )
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var leftButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButtonStackView)
        navigationController?.navigationBar.backgroundColor = ApronAssets.secondary.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
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
            saveButton.isEnabled = false
            return
        }
        saveButton.isEnabled = true
    }

    // MARK: - User actions

    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    private func saveButtonTapped() {
        delegate?.onInstructionSelected(image: selectedImage, description: instructionDesc ?? "")
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
