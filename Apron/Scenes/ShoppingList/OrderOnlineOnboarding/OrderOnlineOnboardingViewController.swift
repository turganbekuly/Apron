//
//  OrderOnlineOnboardingViewController.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 21.08.2023.
//

import UIKit
import APRUIKit

final class OrderOnlineOnboardingViewController: UIViewController {
    // MARK: - Properties
    
    struct Section {
        enum Section {
            case screens
        }
        enum Row {
            case screen(UIImage)
        }
        
        let section: Section
        let rows: [Row]
    }
    
    var sections: [Section] = [] {
        didSet {
            mainView.reloadData()
        }
    }
    
    var images = [
        APRAssets.step1.image,
        APRAssets.step2.image,
        APRAssets.step3.image,
        APRAssets.step4.image
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        sections = [
            .init(section: .screens, rows: images.compactMap { .screen($0) })
        ]
    }
    
    // MARK: - Views factory
    
    private lazy var mainView: OrderOnlineOnboardingView = {
       let view = OrderOnlineOnboardingView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var closeButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = APRAssets.iconNavigationCloseBackground.image
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var backButton: BlackOpButton = {
        let button = BlackOpButton()
        button.backgroundType = .blackBackground
        button.setTitle(L10n.ShoppingList.Onboarding.BackButton.title, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 23
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var forwardButton: BlackOpButton = {
        let button = BlackOpButton()
        button.backgroundType = .blackBackground
        button.setTitle(L10n.ShoppingList.Onboarding.NextButton.title, for: .normal)
        button.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 23
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, forwardButton])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Setup Views
    
    private func setupViews() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        closeButton.addGestureRecognizer(tapGR)
        view.addSubviews(mainView, hStackView)
        backButton.isEnabled = false
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        hStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            $0.height.equalTo(46)
        }
    }
    
    // MARK: - Private methods
    
    private func move(by delta: Int) {
        let currentIndexPath = mainView.indexPathsForVisibleItems.first ?? IndexPath(row: 0, section: 0)
        let nextRow = currentIndexPath.row + delta
        if nextRow >= 0 && nextRow < sections[currentIndexPath.section].rows.count {
            let nextIndexPath = IndexPath(row: nextRow, section: currentIndexPath.section)
            mainView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: false)
            // Update button states
            backButton.isEnabled = nextRow > 0
            if nextRow >= sections[currentIndexPath.section].rows.count - 1 {
                forwardButton.setTitle(L10n.ShoppingList.Onboarding.FinishButton.title, for: .normal)
            } else {
                forwardButton.setTitle(L10n.ShoppingList.Onboarding.NextButton.title, for: .normal)
            }
        } else {
            dismiss(animated: true)
        }
    }
    
    // MARK: - User actions
    
    @objc
    private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func backButtonTapped() {
        move(by: -1)
    }
    
    @objc
    private func forwardButtonTapped() {
        move(by: 1)
    }
}

extension OrderOnlineOnboardingViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].rows.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .screen:
            let cell: OrderOnlineOnboardingCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension OrderOnlineOnboardingViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .screen:
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .screen(imageUrl):
            guard let cell = cell as? OrderOnlineOnboardingCell else { return }
            cell.configure(with: imageUrl)
        }
    }
}


