//
//  ShoppingItemCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.05.2022.
//

import UIKit
import APRUIKit
import M13Checkbox
import HapticTouch
import Storages

protocol ShoppingListCellProtocol: AnyObject {
    func onCheckboxTapped(with item: CartItem, value: M13Checkbox.CheckState)
}

final class ShoppingItemCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: ShoppingListCellProtocol?
    var checkState: M13Checkbox.CheckState = .unchecked {
        didSet {
            switch checkState {
            case .checked:
                HapticTouch.generateMedium()
                checkbox.setCheckState(.checked, animated: false)
                containerView.alpha = 0.5
            case .unchecked:
                HapticTouch.generateLight()
                checkbox.setCheckState(.unchecked, animated: false)
                containerView.alpha = 1
            default:
                break
            }
        }
    }

    // MARK: - Private properties

    private var cartItem: CartItem?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.checkbox.setCheckState(.unchecked, animated: false)
        self.containerView.alpha = 1
    }

    // MARK: - Views factory

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 17
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        view.layer.shadowOffset = CGSize(width: 4, height: 0)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 19
        return view
    }()

    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var sourceRecipsButton: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = APRAssets.gray.color
        label.textAlignment = .left
        return label
    }()

    private lazy var ingredientNameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.bold14
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    private lazy var measurementLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold12
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    lazy var checkbox: M13Checkbox = {
        let checkbox = M13Checkbox()
        checkbox.boxType = .square
        checkbox.cornerRadius = 8
        checkbox.stateChangeAnimation = .fill
        checkbox.tintColor = APRAssets.mainAppColor.color
        checkbox.secondaryTintColor = .gray
        checkbox.secondaryCheckmarkTintColor = .white
//        checkbox.isUserInteractionEnabled = false
        checkbox.addTarget(self, action: #selector(checkboxValueChanged), for: .valueChanged)
        return checkbox
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(containerView)
        containerView.addSubviews(
            productImageView,
            sourceRecipsButton,
            ingredientNameLabel,
            measurementLabel,
            checkbox
        )
        setupConstraints()
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        productImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(60)
        }

        checkbox.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(ingredientNameLabel.snp.centerY)
            $0.size.equalTo(24)
        }

        sourceRecipsButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalTo(productImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(checkbox.snp.leading).offset(-4)
        }

        ingredientNameLabel.snp.makeConstraints {
            $0.top.equalTo(sourceRecipsButton.snp.bottom).offset(4)
            $0.leading.equalTo(productImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(checkbox.snp.leading).offset(-4)
        }

        measurementLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(productImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(checkbox.snp.leading).offset(-4)
            $0.bottom.equalToSuperview().inset(4)
        }
    }

    // MARK: - User actions

    @objc
    private func checkboxValueChanged() {
        guard let cartItem = cartItem else {
            return
        }
        
        switch checkbox.checkState {
        case .unchecked:
            self.delegate?.onCheckboxTapped(with: cartItem, value: .unchecked)
        case .checked:
            self.delegate?.onCheckboxTapped(with: cartItem, value: .checked)
        default:
            break
        }
    }

    // MARK: - Public methods

    func configure(item: CartItem) {
        cartItem = item
        productImageView.kf.setImage(
            with: URL(string: cartItem?.productImage ?? ""),
            placeholder: APRAssets.iconPlaceholderItem.image
        )
        sourceRecipsButton.text = item.recipeName?.first ?? ""
        ingredientNameLabel.text = item.productName
        
        measurementLabel.text = "\(item.amount?.clean ?? "") \(item.measurement ?? "")"
        checkState = item.bought ? .checked : .unchecked
        containerView.alpha = item.bought ? 0.5 : 1

    }
}

private extension FloatingPoint {
    var isWholeNumber: Bool { isNormal ? self == rounded() : isZero }
}
