//
//  EmojiCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09.08.2022.
//

import UIKit
import APRUIKit
import HapticTouch

enum EmojiState: Int {
    case love = 0
    case sad = 1
}

protocol RatedProtocol: AnyObject {
    func didRate(with state: EmojiState)
}

final class EmojiCell: UITableViewCell {
    // MARK: - Public properties

    weak var delegate: RatedProtocol?

    // MARK: - Private properties

    private var activeEmojies = [
        APRAssets.ratingLoveInitial.image,
        APRAssets.ratingSadInitial.image
    ]

    private var inactiveEmojies = [
        APRAssets.ratingLoveInactive.image,
        APRAssets.ratingSadInactive.image
    ]

    private lazy var buttons = [loveButton, sadButton]

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    let containerView = UIView()

    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loveButton, sadButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()

    private lazy var sadButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.setImage(APRAssets.ratingSadInitial.image, for: .normal)
        return button
    }()

    private lazy var loveButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.setImage(APRAssets.ratingLoveInitial.image, for: .normal)
        return button
    }()

    // MARK: - Setup Views

    private func setupViews() {
        buttons.forEach {
            $0.addTarget(self, action: #selector(emojiSelected), for: .touchUpInside)
        }
        contentView.addSubview(containerView)
        containerView.addSubview(hStackView)

        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        hStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(200)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - Private methods

    private func chooseEmoji(at index: Int) {
        for button in 0...buttons.count - 1 {
            if button != index {
                buttons[button].setImage(inactiveEmojies[button], for: .normal)
            }

            UIView.animate(withDuration: 0.6,
                           animations: {
                self.buttons[index].setImage(self.activeEmojies[index], for: .normal)
                self.buttons[index].transform = CGAffineTransform(scaleX: -0.2, y: -0.2)
            },
                           completion: { _ in
                UIView.animate(withDuration: 0.6) {
                    self.buttons[index].transform = CGAffineTransform.identity
                    HapticTouch.generateSuccess()
                }
            })

        }
        delegate?.didRate(with: EmojiState(rawValue: index) ?? .love)
    }

    // MARK: - User actions

    @objc
    private func emojiSelected(_ sender: UIButton) {
        chooseEmoji(at: sender.tag)
    }

    // MARK: - Public methods

    func configure() {

    }
}
