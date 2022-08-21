//
//  AddCommentViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models
import AlertMessages

protocol AddCommentDisplayLogic: AnyObject {
    func displayAddComment(viewModel: AddCommentDataFlow.AddComment.ViewModel)
    func displayRateRecipe(viewModel: AddCommentDataFlow.RateRecipe.ViewModel)
    func displayUploadImage(viewModel: AddCommentDataFlow.UploadImage.ViewModel)
}

final class AddCommentViewController: ViewController, Messagable {
    
    struct Section {
        enum Section {
            case comment
        }
        enum Row {
            case rate
            case placeholder
            case image
            case note
            case tags
        }
        
        var section: Section
        var rows: [Row]
    }

    struct TagsSection {
        enum Section {
            case howDidItTaste(String)
            case whatWasGood(String)
            case makeItAgain(String)
        }
        enum Row {
            case option(String)
        }

        var section: Section
        var rows: [Row]
    }
    
    // MARK: - Properties

    weak var delegate: RecipePageCommentAdded?
    let interactor: AddCommentBusinessLogic
    var sections: [Section] = []
    var tagsSections: [TagsSection] = [] {
        didSet {
            let howDidItTasteOptions = ["Вкусный", "Сладкий", "Пряный", "Мягкий", "Влажный", "Сухой", "Хрустящий", "Свежий"]
            let whatWasGoodOptions = ["Легкий", "Подходит для детей", "Одна посуда", "До 30 минут"]
            let makeItAgainOptions = ["Частый выбор", "Никогда" , "Особый случай"]
            tagsSections = [
                .init(section: .howDidItTaste("Как это было на вкус?"), rows: howDidItTasteOptions.compactMap { .option($0) }),
                .init(section: .whatWasGood("Что в нем было хорошего?"), rows: whatWasGoodOptions.compactMap { .option($0) }),
                .init(section: .makeItAgain("Приготовили бы снова?"), rows: makeItAgainOptions.compactMap { .option($0) })
            ]
        }
    }
    var selectedOptions = [String]() {
        didSet {
            addCommentRequestBody?.tags = selectedOptions
        }
    }
    var selectedRate: EmojiState?

    var state: State {
        didSet {
            updateState()
        }
    }

    var addCommentRequestBody: AddCommentRequestBody?

    var selectedImage: UIImage? {
        didSet {
            if let selectedImage = selectedImage {
                uploadImage(with: selectedImage)
                configureImageCell(isLoaded: true)
            }
        }
    }

    var recipeId: Int? {
        didSet {
            tagsSections = []
            sections = [.init(section: .comment, rows: [.rate, .placeholder, .note, .tags])]
            mainView.reloadData()
        }
    }
    
    // MARK: - Views

    private lazy var backButton = NavigationBackButton()

    lazy var mainView: AddCommentView = {
        let view = AddCommentView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    private lazy var saveButton: BlackOpButton = {
        let button = BlackOpButton()
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 17
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - Init
    init(interactor: AddCommentBusinessLogic, state: State) {
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

    // MARK: - Public methods

    func configureImageCell(isLoaded: Bool) {
        guard
            let section = sections.firstIndex(where: { $0.section == .comment }),
            let row = sections[section].rows.firstIndex(of: .placeholder),
            let cell = mainView.cellForRow(at: IndexPath(row: row, section: section)) as? RecipeCreationPlaceholderImageCell
        else { return }
        if isLoaded {
            cell.startAnimating()
        } else {
            cell.stopAnimating()
        }
        mainView.reloadTableViewWithoutAnimation()
    }
    
    // MARK: - Methods
    private func configureNavigation() {
        backButton.configure(with: "Добавить отзыв")
        backButton.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.backgroundColor = ApronAssets.secondary.color
    }
    
    private func configureViews() {
        [mainView, saveButton].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        saveButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(38)
        }

        mainView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(saveButton.snp.top)
        }
    }
    
    private func configureColors() {
        view.backgroundColor = ApronAssets.secondary.color
    }

    // MARK: - User actions

    @objc
    private func saveButtonTapped() {
        guard let _ = selectedRate else {
            show(type: .error("Пожалуйста, выберите подходящий смайлик"))
            return
        }
        
        guard let comment = addCommentRequestBody, comment.comment != nil || comment.tags != nil else {
            show(type: .error("Пожалуйста, заполните поля!"))
            return
        }
        
        addComment(body: comment)
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
