//
//  DefaultButton.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 22.05.2022.
//

import UIKit

open class DefaultButton: UIButton {

    // MARK: - Properties
    private var isLoading = false
    private var loaderWorkItem: DispatchWorkItem?

    // MARK: - Views
    private lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.alpha = 0
        return view
    }()

    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    public required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Methods
    public func setLoading(_ loading: Bool) {
        if loading {
            showLoader([titleLabel, imageView])
        } else {
            hideLoader()
        }
    }

    private func configure() {
        clipsToBounds = true
        layer.cornerRadius = 8
        titleLabel?.font = TypographyFonts.regular14

        addIndicator()
    }

    private func showLoader(_ viewsToBeHidden: [UIView?], userInteraction: Bool = false) {
        isLoading = true
        self.isUserInteractionEnabled = userInteraction
        indicator.alpha = 0.0
        loaderWorkItem?.cancel()
        loaderWorkItem = nil
        loaderWorkItem = DispatchWorkItem { [weak self] in
            guard let `self` = self,
                  let item = self.loaderWorkItem,
                  !item.isCancelled else { return }

            UIView.transition(with: self,
                              duration: 0.2,
                              options: .curveEaseOut,
                              animations: { [weak self] in
                                viewsToBeHidden.forEach {
                                    $0?.alpha = 0.0
                                }
                                self?.indicator.alpha = 1.0
                              },
                              completion: { [weak self] _ in
                                guard let `self` = self,
                                      !item.isCancelled else { return }

                                self.isLoading ? self.indicator.startAnimating() : self.hideLoader()
                              })
        }
        loaderWorkItem?.perform()
    }

    private func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }

            self.isLoading = false
            self.isUserInteractionEnabled = true
            self.indicator.stopAnimating()
            self.loaderWorkItem?.cancel()
            self.loaderWorkItem = nil
            self.loaderWorkItem = DispatchWorkItem { [weak self] in
                guard let `self` = self, let item = self.loaderWorkItem, !item.isCancelled else { return }

                UIView.transition(with: self,
                                  duration: 0.2,
                                  options: .curveEaseIn) { [weak self] in
                    self?.titleLabel?.alpha = 1.0
                    self?.imageView?.alpha = 1.0
                    self?.indicator.alpha = 0
                }
            }
            self.loaderWorkItem?.perform()
        }
    }

    private func addIndicator() {
        [indicator].forEach {
            addSubview($0)
        }

        makeIndicatorConstraints()
    }

    private func makeIndicatorConstraints() {
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
    }

}

