//
//  CommunityPageViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit
import SnapKit

public protocol CommunityPageDisplayLogic: AnyObject {
    
}

public final class CommunityPageViewController: ViewController {
    // MARK: - Properties
    public let interactor: CommunityPageBusinessLogic
    public var sections: [Section] = []
    public var recipesSection: [CommunityPageCollectionSection] = [] {
        didSet {
            configureRecipesSection()
        }
    }
    public var state: State {
        didSet {
            updateState()
        }
    }

    var selectedSegment: CommunitySegmentCell.CommunitySegment? {
        didSet {
            //
        }
    }

    var topInfo = [
        CommunityInfoCellViewModel(
            title: "Итальянская кухня",
            subtitle: "Здесь вы найдете рецепты Итальянских блюд",
            recipiesCount: "865",
            membersCount: "198 778"
        )
    ]

    var filter = [
        CommunityFilterCellViewModel(searchbarPlaceholder: "Итальянская кухня")
    ]

    var recipies: [CommunityRecipesCollectionCellViewModel] = [
        CommunityRecipesCollectionCellViewModel(
            recipeName: "Пицца Маргарита",
            cookingTime: "45 мин",
            imageURL: "",
            favCount: "0",
            userImage: "",
            userName: "Akarys Turganbekuly",
            sourceURL: "apron.ws",
            postingTime: "3 для назад"
        ),
        CommunityRecipesCollectionCellViewModel(
            recipeName: "Пицца Маргарита",
            cookingTime: "45 мин",
            imageURL: "",
            favCount: "45",
            userImage: "",
            userName: "Akarys Turganbekuly",
            sourceURL: "apron.ws",
            postingTime: "3 для назад"
        ),
        CommunityRecipesCollectionCellViewModel(
            recipeName: "Пицца Маргарита",
            cookingTime: "45 мин",
            imageURL: "",
            favCount: "45",
            userImage: "",
            userName: "Akarys Turganbekuly",
            sourceURL: "apron.ws",
            postingTime: "3 для назад"
        )
    ]

    private var tableViewTopConstraint: Constraint?
    private var cacheOffset: CGPoint?
    
    // MARK: - Views
    lazy var imageView: ImageHeaderView = {
        let imageHeader = ImageHeaderView()
        imageHeader.imageUrl = ""
        return imageHeader
    }()

    private lazy var navigationBarView = UIView()

    private lazy var backButton = NavigationIconFillButton()
    private lazy var moreButton = NavigationIconFillButton()

    public lazy var mainView: CommunityPageView = {
        let view = CommunityPageView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    private lazy var refreshControl = UIRefreshControl()
    
    // MARK: - Init
    public init(interactor: CommunityPageBusinessLogic, state: State) {
        self.interactor = interactor
        self.state = state
        
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Life Cycle
    override public func loadView() {
        super.loadView()
        
        configureViews()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        state = { state }()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBarView.frame = CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: view.safeAreaInsets.top
        )
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle()
    }
    
    // MARK: - Methods
    private func configureNavigation() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem =  UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreButton)
    }
    
    private func configureViews() {
        mainView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshControlActivated), for: .valueChanged)
        backButton.icon = Assets.navBackButton.image.withTintColor(.black)
        moreButton.icon = Assets.navMoreButton.image.withTintColor(.black)
        backButton.onTouch = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        [imageView, mainView, navigationBarView].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(174)
        }

        mainView.snp.makeConstraints {
            tableViewTopConstraint = $0.top
                .equalToSuperview().offset(imageView.imageHeight - 36)
                .constraint
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func statusBarStyle() -> UIStatusBarStyle {
        guard let topConstraintConstant = tableViewTopConstraint?.layoutConstraints.first?.constant else {
            return .default
        }

        if topConstraintConstant < view.safeAreaInsets.top {
            return .default
        }

        return .lightContent
    }
    
    private func configureColors() {
        view.backgroundColor = Assets.secondary.color
        navigationBarView.backgroundColor = .clear
        refreshControl.tintColor = .white
        refreshControl.backgroundColor = .clear
    }
    
    deinit {
        NSLog("deinit \(self)")
    }

    // MARK: - Methods

    private func configureRecipesSection() {
        guard
            let section = sections.firstIndex(where: { $0.section == .recipiesView }),
            let row = sections[section].rows.firstIndex(where: { $0 == .recipiesView }),
            let cell = mainView.cellForRow(at: .init(row: row, section: section)) as? CommunityRecipeCell
        else { return }

        cell.recipesCollectionView.reloadData()
    }

    private func configureCommentsSection() {
        guard
            let section = sections.firstIndex(where: { $0.section == .recipiesView }),
            let row = sections[section].rows.firstIndex(where: { $0 == .recipiesView }),
            let cell = mainView.cellForRow(at: .init(row: row, section: section))
        else { return }
    }

    // MARK: - User actions

    @objc
    private func refreshControlActivated() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.refreshControl.endRefreshing()
        }
    }
}

extension CommunityPageViewController {
    func handleScrollForImage(contentOffset: CGFloat) {
        guard let topConstraint = tableViewTopConstraint?.layoutConstraints.first else {
            return
        }

        let oldOffsetY = (cacheOffset?.y ?? contentOffset)
        var scrollDiff = contentOffset - oldOffsetY

        if abs(scrollDiff) > 100 {
            scrollDiff = scrollDiff > 0 ? 1 : -1
        }

        let isScrollingUp = scrollDiff > 0 && contentOffset + mainView.contentInset.top > 0
        let isScrollingDown = scrollDiff < 0 && contentOffset + mainView.contentInset.top < 0
        var constant = topConstraint.constant

        if isScrollingDown {
            constant = min(imageView.imageHeight - 36, topConstraint.constant + abs(scrollDiff))
        } else if isScrollingUp {
            constant = max(0, topConstraint.constant - abs(scrollDiff))
        }

        if constant != topConstraint.constant {
            topConstraint.constant = constant
            mainView.contentOffset.y = oldOffsetY
        }

        self.cacheOffset = mainView.contentOffset

        setNeedsStatusBarAppearanceUpdate()

        // navigation bar overlay
        if topConstraint.constant <= view.safeAreaInsets.top {
            imageView.isHidden = true
            navigationBarView.backgroundColor = Assets.secondary.color
            navigationItem.title = topInfo.first?.title ?? ""
        } else {
            imageView.isHidden = false
            navigationItem.title = nil
            navigationBarView.backgroundColor = .clear
        }



        let offsetY = mainView.contentOffset.y + mainView.contentInset.top
        guard offsetY <= 0 else {
            imageView.imageView.layer.transform = CATransform3DIdentity
            return
        }

        let scaleFactor = 1 + (-1 * offsetY / (imageView.imageHeight / 2))
            imageView.imageView.layer.transform = CATransform3DScale(
            CATransform3DIdentity,
            scaleFactor,
            scaleFactor,
            1
        )
    }
}
