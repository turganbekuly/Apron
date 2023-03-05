//
//  WebViewHandler.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.09.2022.
//

import UIKit
import WebKit
import APRUIKit
import NVActivityIndicatorView

final class WebViewHandler: ViewController {
    // MARK: - Properties

    var urlString: String

    // MARK: - Views factory
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.navigationDelegate = self
        return webView
    }()

    private lazy var activityIndicator = NVActivityIndicatorView(
        frame: .zero,
        type: .ballClipRotatePulse,
        color: ApronAssets.mainAppColor.color,
        padding: nil
    )

    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }

    // MARK: - Setup views

    private func setupViews() {
        view.addSubviews(
            webView,
            activityIndicator
        )
        setupConstraints()
    }

    private func setupConstraints() {
        webView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(45)
        }
    }

    private func displayLoading(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    @objc private func onBackTapped() {
        dismiss(animated: true)
    }
}

// MARK: - WKWebView Delegate

extension WebViewHandler: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        displayLoading(true)
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        displayLoading(false)
    }
}
