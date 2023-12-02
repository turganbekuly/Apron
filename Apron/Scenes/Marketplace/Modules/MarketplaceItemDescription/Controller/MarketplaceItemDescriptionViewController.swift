//
//  MarketplaceItemDescriptionViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import PanModal
import Models
import Storages
import AlertMessages

final class MarketplaceItemDescriptionViewController: ViewController, PanModalPresentable{
    // MARK: - PanModal Properties

    var panScrollable: UIScrollView? {
        return scrollView
    }

    var longFormHeight: PanModalHeight {
        return .maxHeight
    }

    var cornerRadius: CGFloat {
        return 25
    }

    var transitionDuration: Double {
        return 0.4
    }
    
    // MARK: - Properties
    
    private let item: MarketplaceItemResponseBody
    private var userStorage: UserStorageProtocol = UserStorage()
    private var authStorage: AuthStorageProtocol = AuthStorage()
    private var timer: Timer?
    private var seconds = 0
    
    // MARK: - Init
    
    init(with item: MarketplaceItemResponseBody) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ApronAnalytics.shared.sendAnalyticsEvent(.marketplaceItemViewed(leftAfterSeconds: seconds))
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Views Factory
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var scrollContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.bold20
        label.textColor = APRAssets.primaryTextMain.color
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var itemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold14
        label.textColor = APRAssets.gray.color
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var buyButton: BlackOpButton = {
        let button = BlackOpButton()
        button.backgroundType = .blackBackground
        button.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 17
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - Methods
    
    private func configureViews() {
        view.addSubviews(scrollView, buyButton)
        scrollView.addSubview(scrollContentView)
        [itemImageView, itemNameLabel, itemDescriptionLabel].forEach { scrollContentView.addSubview($0) }
        
        itemImageView.kf.setImage(
            with: URL(string: item.image ?? ""),
            placeholder: APRAssets.iconPlaceholderItem.image
        )
        itemNameLabel.text = item.name
        itemDescriptionLabel.text = item.description
        
        configureColors()
        makeConstraints()
        
        buyButton.setTitle("Купить за \(item.price ?? 0) Moca Coin", for: .normal)
    }
    
    private func makeConstraints() {
        buyButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(56)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(buyButton.snp.top).offset(-16)
        }

        scrollContentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.width.equalToSuperview()
        }
        
        itemImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(view.snp.width)
        }
        
        itemNameLabel.snp.makeConstraints {
            $0.top.equalTo(itemImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        itemDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(itemNameLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func configureColors() {
        
    }
    
    // MARK: - Private methods
    
    private func startTimer() {
        cancelTimer()
        timer = Timer(
            timeInterval: 1,
            target: self,
            selector: #selector(fireTimer),
            userInfo: nil,
            repeats: true
        )

        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
            
    }
    
    private func cancelTimer() {
        timer?.invalidate()
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
    // MARK: - User actions
    
    @objc
    private func fireTimer() {
        seconds += 1
    }
    
    @objc
    private func buyButtonTapped() {
        guard authStorage.isUserAuthorized else {
            show(type: .error(L10n.Alert.Authorization.Skipped.message))
            return
        }
        
        guard
            let price = item.price,
            let bonus = userStorage.user?.bonusAmount,
            bonus >= price
        else {
            let price = item.price ?? 0
            let bonus = userStorage.user?.bonusAmount ?? 0
            let difference = price - bonus
            show(type: .error("К сожалению, вам еще не хватает \(difference) бонусов для покупки"))
            return
        }
        
        let link = L10n.ShoppingList.Order.link
        let text = L10n.Marketplace.Exchange.ToItem.message + " \(item.name ?? "")"
        if let url = URL(string: link + (text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
